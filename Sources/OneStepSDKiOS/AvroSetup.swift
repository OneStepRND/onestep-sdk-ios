import Foundation
import OneStepSDK
import SwiftAvroCore

class AvroSetup {
    static func initialize() {
        setupAvroEncoder()
    }
    
    private static func setupAvroEncoder() {
        OSTSDKCore.customDataEncoder = { sensorData, metadata in
            let avroData = try encodeToAvro(sensorData, metadata: metadata)
            return (data: avroData, format: "avro")
        }
    }
    
    private static func encodeToAvro(_ sensorData: SDKSensorData, metadata: EncodingMetadata) throws -> Data {
        // Create PerceptionDataChunk record with real metadata + flattened sensor arrays
        let retentionMicros = metadata.retentionExpiresAt.map { Int64($0.timeIntervalSince1970 * 1_000_000) }
        
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
            recording_start: Int64(metadata.recordingStart.timeIntervalSince1970 * 1_000_000), // Convert to microseconds
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
        
        let jsonSchema = createPerceptionSchema()
        let avro = Avro()
        _ = avro.decodeSchema(schema: jsonSchema)
        return try avro.encode(perception)
    }
    
    private static func calculateRecordingLength(_ sensorData: SDKSensorData) -> Int {
        // Calculate from first to last timestamp
        guard let firstAccel = sensorData.accelerationData.first,
              let lastAccel = sensorData.accelerationData.last else {
            return 0
        }
        return (lastAccel.t - firstAccel.t) / 1000 // Convert to seconds
    }
    
    private static func createPerceptionSchema() -> String {
        return """
        {
          "protocol" : "PerceptionProtocol",
          "types" : [ {
            "type" : "enum",
            "name" : "Platform",
            "symbols" : [ "ANDROID", "IOS" ]
          }, {
            "type" : "enum",
            "name" : "Context",
            "symbols" : [ "INAPP", "BACKGROUND" ]
          }, {
            "type" : "enum",
            "name" : "Activities",
            "symbols" : [ "balance_test", "dual_task_walk_subtract", "rom_hip_abd", "rom_hip_add", "rom_hip_ext", "rom_hip_flex", "rom_knee_ext", "rom_knee_flex", "rom_knee_flexion_passive", "running", "short_walk", "stairs", "sts", "tug", "walk", "walk_6_min_test" ]
          }, {
            "type" : "record",
            "name" : "PerceptionDataChunk",
            "fields" : [ {
              "name" : "id",
              "type" : {
                "type" : "string",
                "logicalType" : "uuid"
              }
            }, {
              "name" : "context",
              "type" : "Context"
            }, {
              "name" : "patient",
              "type" : {
                "type" : "string",
                "logicalType" : "uuid"
              }
            }, {
              "name" : "agent",
              "type" : {
                "type" : "string",
                "logicalType" : "uuid"
              }
            }, {
              "name" : "retention_expires_at",
              "type" : [ "null", {
                "type" : "long",
                "logicalType" : "timestamp-micros"
              } ]
            }, {
              "name" : "device_model",
              "type" : "string"
            }, {
              "name" : "sdk_version",
              "type" : "string"
            }, {
              "name" : "platform",
              "type" : "Platform"
            }, {
              "name" : "activity_name",
              "type" : "Activities"
            }, {
              "name" : "recording_start",
              "type" : {
                "type" : "long",
                "logicalType" : "timestamp-micros"
              }
            }, {
              "name" : "timezone",
              "type" : "string"
            }, {
              "name" : "len_seconds",
              "type" : "float"
            }, {
              "name" : "acceleration_t",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "acceleration_x",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "acceleration_y",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "acceleration_z",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "rotation_t",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "rotation_x",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "rotation_y",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "rotation_z",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "rotation_w",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "gyroscope_t",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "gyroscope_x",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "gyroscope_y",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "gyroscope_z",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "magnetometer_t",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "magnetometer_x",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "magnetometer_y",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "magnetometer_z",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "magnetometer_w",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "step_counter_t",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "step_counter_value",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "pressure_t",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            }, {
              "name" : "pressure_value",
              "type" : {
                "type" : "array",
                "items" : "float"
              },
              "default" : [ ]
            } ]
          } ],
          "messages" : { }
        }
        """
    }
}

import UIKit

private struct PerceptionDataChunk: Codable {
    let id: String
    let context: String
    let patient: String
    let agent: String
    let retention_expires_at: Int64?
    let device_model: String
    let sdk_version: String
    let platform: String
    let activity_name: String
    let recording_start: Int64
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
