import Foundation
import OneStepSDK
import SwiftAvroCore
import CryptoKit

class AvroSetup {
    static var avroFile: AvroFileManager?
    
    static func initialize() {
        setupAvroEncoder()
        setupAvroFile()
    }
    
    private static func setupAvroFile() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsPath.appendingPathComponent("sensor_data.avro")
        avroFile = AvroFileManager(fileURL: fileURL)
    }
    
    private static func setupAvroEncoder() {
        OSTSDKCore.customDataEncoder = { sensorData, metadata in
            // Try the full schema approach
            let fullData = try encodeFullRecord(sensorData, metadata: metadata)
            
            // Write individual record file for testing (not appended)
            try writeIndividualRecord(fullData, metadata: metadata)
            
            // Also try appending to main file
            try avroFile?.appendRecord(fullData)
            
            // Return empty data since we're writing to file
            return (data: Data(), format: "avro")
        }
    }
    
    private static func writeIndividualRecord(_ data: Data, metadata: EncodingMetadata) throws {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filename = "individual_\(metadata.measurementId.uuidString).avro"
        let fileURL = documentsPath.appendingPathComponent(filename)
        
        try data.write(to: fileURL)
        print("📝 Individual record written: \(fileURL.path)")
    }
    
    private static func encodeMinimalRecord(_ sensorData: SDKSensorData, metadata: EncodingMetadata) throws -> Data {
        let retentionMicros: Int = metadata.retentionExpiresAt.map { Int($0.timeIntervalSince1970 * 1_000_000) } ?? 0
        let recordingStartMicros = Int(metadata.recordingStart.timeIntervalSince1970 * 1_000_000)
        
        let minimalRecord = MinimalTestStruct(
            id: metadata.measurementId.uuidString,
            retention_expires_at: retentionMicros,
            recording_start: recordingStartMicros
        )
        
        let avro = Avro()
        let encodedData = try avro.encode(minimalRecord)
        
        // Validate by decoding
        print("🔍 VALIDATION: Encoded data size: \(encodedData.count) bytes")
        do {
            let decoded = try avro.decode(from: encodedData) as MinimalTestStruct
            print("✅ VALIDATION: Successfully decoded!")
            print("   ID: \(decoded.id)")
            print("   Retention: \(decoded.retention_expires_at)")
            print("   Recording: \(decoded.recording_start)")
        } catch {
            print("❌ VALIDATION: Decode failed: \(error)")
        }
        
        return encodedData
    }
    
    private static func encodeFullRecord(_ sensorData: SDKSensorData, metadata: EncodingMetadata) throws -> Data {
        let retentionMicros: Int = metadata.retentionExpiresAt.map { Int($0.timeIntervalSince1970 * 1_000_000) } ?? 0
        let recordingStartMicros = Int(metadata.recordingStart.timeIntervalSince1970 * 1_000_000)
        
        let perception = PerceptionDataChunk(
            id: metadata.measurementId.uuidString,
            context: metadata.context,
            patient: metadata.patientId,
            agent: metadata.agentId,
            retention_expires_at: retentionMicros,
            device_model: metadata.deviceModel,
            sdk_version: metadata.sdkVersion,
            platform: "IOS",
            activity_name: metadata.activityType,
            recording_start: recordingStartMicros,
            timezone: metadata.timezone,
            len_seconds: Float(calculateRecordingLength(sensorData)),
            
            // Acceleration arrays (flattened)
            acceleration_t: sensorData.accelerationData.map { Float($0.t) },
            acceleration_x: sensorData.accelerationData.compactMap { $0.x }.map { Float($0) },
            acceleration_y: sensorData.accelerationData.compactMap { $0.y }.map { Float($0) },
            acceleration_z: sensorData.accelerationData.compactMap { $0.z }.map { Float($0) },
            
            // Rotation arrays (flattened)  
            rotation_t: sensorData.rotationData.map { Float($0.t) },
            rotation_x: sensorData.rotationData.compactMap { $0.x }.map { Float($0) },
            rotation_y: sensorData.rotationData.compactMap { $0.y }.map { Float($0) },
            rotation_z: sensorData.rotationData.compactMap { $0.z }.map { Float($0) },
            rotation_w: sensorData.rotationData.compactMap { $0.w }.map { Float($0) },
            
            // Gyroscope arrays (raw gyro data)
            gyroscope_t: sensorData.rawGyroData.map { Float($0.t) },
            gyroscope_x: sensorData.rawGyroData.compactMap { $0.x }.map { Float($0) },
            gyroscope_y: sensorData.rawGyroData.compactMap { $0.y }.map { Float($0) },
            gyroscope_z: sensorData.rawGyroData.compactMap { $0.z }.map { Float($0) },
            
            // Magnetometer arrays
            magnetometer_t: sensorData.magnetometerData.map { Float($0.t) },
            magnetometer_x: sensorData.magnetometerData.compactMap { $0.x }.map { Float($0) },
            magnetometer_y: sensorData.magnetometerData.compactMap { $0.y }.map { Float($0) },
            magnetometer_z: sensorData.magnetometerData.compactMap { $0.z }.map { Float($0) },
            magnetometer_w: sensorData.magnetometerData.compactMap { $0.w }.map { Float($0) },
            
            // Step counter arrays
            step_counter_t: sensorData.stepsData.map { Float($0.t) },
            step_counter_value: sensorData.stepsData.compactMap { $0.x }.map { Float($0) },
            
            // Pressure arrays (altimeter)
            pressure_t: sensorData.altimeterData.map { Float($0.t) },
            pressure_value: sensorData.altimeterData.compactMap { $0.x }.map { Float($0) }
        )
        
        // Create Avro encoder with explicit schema
        let avro = Avro()
        let schema = createFullPerceptionSchema()
        _ = avro.decodeSchema(schema: schema)
        
        let encodedData = try avro.encode(perception)
        
        // Validate
        print("🔍 FULL VALIDATION: Encoded data size: \(encodedData.count) bytes")
        print("   ID: \(perception.id)")
        print("   Context: \(perception.context)")
        print("   Platform: \(perception.platform)")
        print("   Activity: \(perception.activity_name)")
        print("   Acceleration points: \(perception.acceleration_t.count)")
        
        return encodedData
    }
    
    private static func createFullPerceptionSchema() -> String {
        return """
        {
          "type": "record",
          "name": "PerceptionDataChunk",
          "fields": [
            {"name": "id", "type": "string"},
            {"name": "context", "type": "string"},
            {"name": "patient", "type": "string"},
            {"name": "agent", "type": "string"},
            {"name": "retention_expires_at", "type": "int"},
            {"name": "device_model", "type": "string"},
            {"name": "sdk_version", "type": "string"},
            {"name": "platform", "type": "string"},
            {"name": "activity_name", "type": "string"},
            {"name": "recording_start", "type": "int"},
            {"name": "timezone", "type": "string"},
            {"name": "len_seconds", "type": "float"},
            {"name": "acceleration_t", "type": {"type": "array", "items": "float"}},
            {"name": "acceleration_x", "type": {"type": "array", "items": "float"}},
            {"name": "acceleration_y", "type": {"type": "array", "items": "float"}},
            {"name": "acceleration_z", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_t", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_x", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_y", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_z", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_w", "type": {"type": "array", "items": "float"}},
            {"name": "gyroscope_t", "type": {"type": "array", "items": "float"}},
            {"name": "gyroscope_x", "type": {"type": "array", "items": "float"}},
            {"name": "gyroscope_y", "type": {"type": "array", "items": "float"}},
            {"name": "gyroscope_z", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_t", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_x", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_y", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_z", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_w", "type": {"type": "array", "items": "float"}},
            {"name": "step_counter_t", "type": {"type": "array", "items": "float"}},
            {"name": "step_counter_value", "type": {"type": "array", "items": "float"}},
            {"name": "pressure_t", "type": {"type": "array", "items": "float"}},
            {"name": "pressure_value", "type": {"type": "array", "items": "float"}}
          ]
        }
        """
    }
    
    private static func encodeToAvro(_ sensorData: SDKSensorData, metadata: EncodingMetadata) throws -> Data {
        // Create PerceptionDataChunk record with real metadata + flattened sensor arrays
        let retentionMicros: Int? = metadata.retentionExpiresAt.map { Int($0.timeIntervalSince1970 * 1_000_000) }
        
        let recordingStartMicros = Int(metadata.recordingStart.timeIntervalSince1970 * 1_000_000)
        
        let perception = PerceptionDataChunk(
            id: metadata.measurementId.uuidString,
            context: metadata.context,
            patient: metadata.patientId,
            agent: metadata.agentId,
            retention_expires_at: retentionMicros ?? 0,
            device_model: metadata.deviceModel,
            sdk_version: metadata.sdkVersion,
            platform: "IOS",
            activity_name: metadata.activityType,
            recording_start: recordingStartMicros,
            timezone: metadata.timezone,
            len_seconds: Float(calculateRecordingLength(sensorData)),
            
            // Acceleration arrays (flattened)
            acceleration_t: sensorData.accelerationData.map { Float($0.t) },
            acceleration_x: sensorData.accelerationData.compactMap { $0.x }.map { Float($0) },
            acceleration_y: sensorData.accelerationData.compactMap { $0.y }.map { Float($0) },
            acceleration_z: sensorData.accelerationData.compactMap { $0.z }.map { Float($0) },
            
            // Rotation arrays (flattened)  
            rotation_t: sensorData.rotationData.map { Float($0.t) },
            rotation_x: sensorData.rotationData.compactMap { $0.x }.map { Float($0) },
            rotation_y: sensorData.rotationData.compactMap { $0.y }.map { Float($0) },
            rotation_z: sensorData.rotationData.compactMap { $0.z }.map { Float($0) },
            rotation_w: sensorData.rotationData.compactMap { $0.w }.map { Float($0) },
            
            // Gyroscope arrays (raw gyro data)
            gyroscope_t: sensorData.rawGyroData.map { Float($0.t) },
            gyroscope_x: sensorData.rawGyroData.compactMap { $0.x }.map { Float($0) },
            gyroscope_y: sensorData.rawGyroData.compactMap { $0.y }.map { Float($0) },
            gyroscope_z: sensorData.rawGyroData.compactMap { $0.z }.map { Float($0) },
            
            // Magnetometer arrays
            magnetometer_t: sensorData.magnetometerData.map { Float($0.t) },
            magnetometer_x: sensorData.magnetometerData.compactMap { $0.x }.map { Float($0) },
            magnetometer_y: sensorData.magnetometerData.compactMap { $0.y }.map { Float($0) },
            magnetometer_z: sensorData.magnetometerData.compactMap { $0.z }.map { Float($0) },
            magnetometer_w: sensorData.magnetometerData.compactMap { $0.w }.map { Float($0) },
            
            // Step counter arrays
            step_counter_t: sensorData.stepsData.map { Float($0.t) },
            step_counter_value: sensorData.stepsData.compactMap { $0.x }.map { Float($0) },
            
            // Pressure arrays (altimeter)
            pressure_t: sensorData.altimeterData.map { Float($0.t) },
            pressure_value: sensorData.altimeterData.compactMap { $0.x }.map { Float($0) }
        )
        
        // Debug all Int64 fields
        print("🔍 DEBUG: retention_expires_at = \(perception.retention_expires_at) (type: \(type(of: perception.retention_expires_at)))")
        print("🔍 DEBUG: recording_start = \(perception.recording_start) (type: \(type(of: perception.recording_start)))")
        
        // Try encoding a minimal struct first to isolate the issue
        let minimalTest = MinimalTestStruct(
            id: perception.id,
            retention_expires_at: Int(perception.retention_expires_at),
            recording_start: Int(perception.recording_start)
        )
        
        print("🔍 Testing minimal struct...")
        let avro = Avro()
        do {
            let testData = try avro.encode(minimalTest)
            print("✅ Minimal struct encoded successfully")
        } catch {
            print("❌ Minimal struct failed: \(error)")
        }
        
        // Test with progressively more fields to isolate the Bool issue
        let testWithStrings = TestWithStringsStruct(
            id: perception.id,
            context: perception.context,
            platform: perception.platform,
            retention_expires_at: perception.retention_expires_at,
            recording_start: perception.recording_start
        )
        
        print("🔍 Testing with strings...")
        do {
            let testData = try avro.encode(testWithStrings)
            print("✅ Strings struct encoded successfully")
        } catch {
            print("❌ Strings struct failed: \(error)")
        }
        
        let testWithFloat = TestWithFloatStruct(
            id: perception.id,
            len_seconds: perception.len_seconds,
            retention_expires_at: perception.retention_expires_at,
            recording_start: perception.recording_start
        )
        
        print("🔍 Testing with float...")
        do {
            let testData = try avro.encode(testWithFloat)
            print("✅ Float struct encoded successfully")
        } catch {
            print("❌ Float struct failed: \(error)")
        }
        
        // Try a completely different approach - maybe SwiftAvroCore needs schema
        print("🔍 Trying with explicit schema...")
        let avroWithSchema = Avro()
        let simpleSchema = """
        {
          "type": "record",
          "name": "MinimalTest",
          "fields": [
            {"name": "id", "type": "string"},
            {"name": "retention_expires_at", "type": "int"},
            {"name": "recording_start", "type": "int"}
          ]
        }
        """
        
        do {
            _ = avroWithSchema.decodeSchema(schema: simpleSchema)
            let testData = try avroWithSchema.encode(minimalTest)
            print("✅ Explicit schema worked!")
        } catch {
            print("❌ Explicit schema failed: \(error)")
        }
        
        print("🔍 Testing full struct...")
        let avroData = try avro.encode(perception)
        
        // Write to file for debugging/testing
        writeAvroDataToFile(avroData, metadata: metadata, sensorData: sensorData)
        
        return avroData
    }
    
    private static func calculateRecordingLength(_ sensorData: SDKSensorData) -> Int {
        // Calculate from first to last timestamp
        guard let firstAccel = sensorData.accelerationData.first,
              let lastAccel = sensorData.accelerationData.last else {
            return 0
        }
        return (lastAccel.t - firstAccel.t) / 1000 // Convert to seconds
    }
    
    private static func writeAvroDataToFile(_ avroData: Data, metadata: EncodingMetadata, sensorData: SDKSensorData) {
        do {
            // Create filename with timestamp and measurement ID
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
            let timestamp = dateFormatter.string(from: Date())
            let filename = "avro_\(metadata.measurementId.uuidString)_\(timestamp).avro"
            
            // Get Documents directory
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsPath.appendingPathComponent(filename)
            
            // Write data to file
            try avroData.write(to: fileURL)
            
            print("🔴 AVRO FILE WRITTEN:")
            print("📁 Path: \(fileURL.path)")
            print("📊 Size: \(avroData.count) bytes")
            print("🆔 Measurement ID: \(metadata.measurementId.uuidString)")
            print("🏃 Activity: \(metadata.activityType)")
            print("📱 Platform: IOS")
            print("⏰ Recording Start: \(metadata.recordingStart)")
            print("🕒 Length: \(calculateRecordingLength(sensorData)) seconds")
            print("📋 Copy this path to share the file:")
            print("   \(fileURL.path)")
            
        } catch {
            print("❌ Failed to write Avro file: \(error)")
        }
    }
    
//    private static func createPerceptionRecordSchema() -> String {
//        return """
//        {
//          "type": "record",
//          "name": "PerceptionDataChunk",
//          "fields": [
//            {"name": "id", "type": "string"},
//            {"name": "context", "type": "string"}
//          ]
//        }
//        """
//    }
//
//    private static func createPerceptionSchema() -> String {
//        return """
//        {
//          "protocol" : "PerceptionProtocol",
//          "types" : [ {
//            "type" : "enum",
//            "name" : "Platform",
//            "symbols" : [ "ANDROID", "IOS" ]
//          }, {
//            "type" : "enum",
//            "name" : "Context",
//            "symbols" : [ "INAPP", "BACKGROUND" ]
//          }, {
//            "type" : "enum",
//            "name" : "Activities",
//            "symbols" : [ "balance_test", "dual_task_walk_subtract", "rom_hip_abd", "rom_hip_add", "rom_hip_ext", "rom_hip_flex", "rom_knee_ext", "rom_knee_flex", "rom_knee_flexion_passive", "running", "short_walk", "stairs", "sts", "tug", "walk", "walk_6_min_test" ]
//          }, {
//            "type" : "record",
//            "name" : "PerceptionDataChunk",
//            "fields" : [ {
//              "name" : "id",
//              "type" : {
//                "type" : "string",
//                "logicalType" : "uuid"
//              }
//            }, {
//              "name" : "context",
//              "type" : "Context"
//            }, {
//              "name" : "patient",
//              "type" : {
//                "type" : "string",
//                "logicalType" : "uuid"
//              }
//            }, {
//              "name" : "agent",
//              "type" : {
//                "type" : "string",
//                "logicalType" : "uuid"
//              }
//            }, {
//              "name" : "retention_expires_at",
//              "type" : [ "null", {
//                "type" : "long",
//                "logicalType" : "timestamp-micros"
//              } ]
//            }, {
//              "name" : "device_model",
//              "type" : "string"
//            }, {
//              "name" : "sdk_version",
//              "type" : "string"
//            }, {
//              "name" : "platform",
//              "type" : "Platform"
//            }, {
//              "name" : "activity_name",
//              "type" : "Activities"
//            }, {
//              "name" : "recording_start",
//              "type" : {
//                "type" : "long",
//                "logicalType" : "timestamp-micros"
//              }
//            }, {
//              "name" : "timezone",
//              "type" : "string"
//            }, {
//              "name" : "len_seconds",
//              "type" : "float"
//            }, {
//              "name" : "acceleration_t",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "acceleration_x",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "acceleration_y",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "acceleration_z",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "rotation_t",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "rotation_x",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "rotation_y",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "rotation_z",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "rotation_w",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "gyroscope_t",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "gyroscope_x",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "gyroscope_y",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "gyroscope_z",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "magnetometer_t",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "magnetometer_x",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "magnetometer_y",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "magnetometer_z",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "magnetometer_w",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "step_counter_t",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "step_counter_value",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "pressure_t",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            }, {
//              "name" : "pressure_value",
//              "type" : {
//                "type" : "array",
//                "items" : "float"
//              },
//              "default" : [ ]
//            } ]
//          } ],
//          "messages" : { }
//        }
//        """
//    }
}

import UIKit

private struct PerceptionDataChunk: Codable {
    let id: String
    let context: String
    let patient: String
    let agent: String
    let retention_expires_at: Int
    let device_model: String
    let sdk_version: String
    let platform: String
    let activity_name: String
    let recording_start: Int
    let timezone: String
    let len_seconds: Float
    
    // Flattened sensor arrays
    let acceleration_t: [Float]
    let acceleration_x: [Float]
    let acceleration_y: [Float]
    let acceleration_z: [Float]
    
    let rotation_t: [Float]
    let rotation_x: [Float]
    let rotation_y: [Float]
    let rotation_z: [Float]
    let rotation_w: [Float]
    
    let gyroscope_t: [Float]
    let gyroscope_x: [Float]
    let gyroscope_y: [Float]
    let gyroscope_z: [Float]
    
    let magnetometer_t: [Float]
    let magnetometer_x: [Float]
    let magnetometer_y: [Float]
    let magnetometer_z: [Float]
    let magnetometer_w: [Float]
    
    let step_counter_t: [Float]
    let step_counter_value: [Float]
    
    let pressure_t: [Float]
    let pressure_value: [Float]
}

private struct MinimalTestStruct: Codable {
    let id: String
    let retention_expires_at: Int
    let recording_start: Int
}

private struct TestWithStringsStruct: Codable {
    let id: String
    let context: String
    let platform: String
    let retention_expires_at: Int
    let recording_start: Int
}

private struct TestWithFloatStruct: Codable {
    let id: String
    let len_seconds: Float
    let retention_expires_at: Int
    let recording_start: Int
}

// MARK: - Avro File Format Manager
class AvroFileManager {
    private let fileURL: URL
    private let syncMarker: Data
    private let schemaJSON: String
    
    init(fileURL: URL) {
        self.fileURL = fileURL
        // Generate random 16-byte sync marker
        var syncBytes = Data(count: 16)
        _ = syncBytes.withUnsafeMutableBytes { SecRandomCopyBytes(kSecRandomDefault, 16, $0.bindMemory(to: UInt8.self).baseAddress!) }
        self.syncMarker = syncBytes
        
        // Use simplified schema for file header
        self.schemaJSON = """
        {
          "type": "record",
          "name": "PerceptionDataChunk",
          "fields": [
            {"name": "id", "type": "string"},
            {"name": "context", "type": "string"},
            {"name": "patient", "type": "string"},
            {"name": "agent", "type": "string"},
            {"name": "retention_expires_at", "type": "long"},
            {"name": "device_model", "type": "string"},
            {"name": "sdk_version", "type": "string"},
            {"name": "platform", "type": "string"},
            {"name": "activity_name", "type": "string"},
            {"name": "recording_start", "type": "long"},
            {"name": "timezone", "type": "string"},
            {"name": "len_seconds", "type": "float"},
            {"name": "acceleration_t", "type": {"type": "array", "items": "float"}},
            {"name": "acceleration_x", "type": {"type": "array", "items": "float"}},
            {"name": "acceleration_y", "type": {"type": "array", "items": "float"}},
            {"name": "acceleration_z", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_t", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_x", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_y", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_z", "type": {"type": "array", "items": "float"}},
            {"name": "rotation_w", "type": {"type": "array", "items": "float"}},
            {"name": "gyroscope_t", "type": {"type": "array", "items": "float"}},
            {"name": "gyroscope_x", "type": {"type": "array", "items": "float"}},
            {"name": "gyroscope_y", "type": {"type": "array", "items": "float"}},
            {"name": "gyroscope_z", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_t", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_x", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_y", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_z", "type": {"type": "array", "items": "float"}},
            {"name": "magnetometer_w", "type": {"type": "array", "items": "float"}},
            {"name": "step_counter_t", "type": {"type": "array", "items": "float"}},
            {"name": "step_counter_value", "type": {"type": "array", "items": "float"}},
            {"name": "pressure_t", "type": {"type": "array", "items": "float"}},
            {"name": "pressure_value", "type": {"type": "array", "items": "float"}}
          ]
        }
        """
    }
    
    func appendRecord(_ recordData: Data) throws {
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            try createFile()
        }
        
        try appendDataBlock(recordData)
    }
    
    private func createFile() throws {
        var fileData = Data()
        
        // 1. Magic bytes: "Obj" + 0x01
        fileData.append(Data([0x4F, 0x62, 0x6A, 0x01]))
        
        // 2. File metadata (schema)
        let metadata = ["avro.schema": schemaJSON]
        let metadataData = try encodeMetadata(metadata)
        fileData.append(metadataData)
        
        // 3. Sync marker
        fileData.append(syncMarker)
        
        // Write initial file
        try fileData.write(to: fileURL)
        
        print("📝 Created Avro file: \(fileURL.path)")
    }
    
    private func appendDataBlock(_ recordData: Data) throws {
        let fileHandle = try FileHandle(forWritingTo: fileURL)
        defer { fileHandle.closeFile() }
        
        fileHandle.seekToEndOfFile()
        
        // Create data block
        var blockData = Data()
        
        // Record count (varint) - we're adding 1 record
        blockData.append(encodeVarint(1))
        
        // Block size (varint) - size of the record data
        blockData.append(encodeVarint(Int64(recordData.count)))
        
        // Record data
        blockData.append(recordData)
        
        // Sync marker
        blockData.append(syncMarker)
        
        fileHandle.write(blockData)
        
        print("➕ Appended record to Avro file (size: \(recordData.count) bytes)")
    }
    
    private func encodeMetadata(_ metadata: [String: String]) throws -> Data {
        var data = Data()
        
        // Map count (varint)
        data.append(encodeVarint(Int64(metadata.count)))
        
        for (key, value) in metadata {
            // Key length + key
            let keyData = key.data(using: .utf8)!
            data.append(encodeVarint(Int64(keyData.count)))
            data.append(keyData)
            
            // Value length + value  
            let valueData = value.data(using: .utf8)!
            data.append(encodeVarint(Int64(valueData.count)))
            data.append(valueData)
        }
        
        // End of map marker
        data.append(Data([0x00]))
        
        return data
    }
    
    private func encodeVarint(_ value: Int64) -> Data {
        var data = Data()
        var val = UInt64(bitPattern: value)
        
        while val >= 0x80 {
            data.append(UInt8((val & 0xFF) | 0x80))
            val >>= 7
        }
        data.append(UInt8(val & 0xFF))
        
        return data
    }
}
