import Foundation
import OneStepSDK
import SwiftAvroCore

class AvroSetup {
    static func initialize() {
        setupAvroEncoder()
    }
    
    private static func setupAvroEncoder() {
        OSTSDKCore.customDataEncoder = { sensorData in
            let avroData = try encodeToAvro(sensorData)
            return (data: avroData, format: "avro")
        }
    }
    
    private static func encodeToAvro(_ sensorData: SDKSensorData) throws -> Data {
    // Debug: Print data before encoding
        print("DEBUG: startTimeEpoch = \(sensorData.startTimeEpoch) (type: \(type(of: sensorData.startTimeEpoch)))")
        print("DEBUG: accelerationData count = \(sensorData.accelerationData.count)")
        if let firstAccel = sensorData.accelerationData.first {
            print("DEBUG: first accel point - t:\(firstAccel.t), x:\(firstAccel.x), y:\(firstAccel.y), z:\(firstAccel.z), w:\(firstAccel.w)")
        }
        
        // Encode all sensor data
        let avroRecord = MotionSensorRecord(
            startTime: sensorData.startTimeEpoch,
            accelerationData: sensorData.accelerationData.map { 
                DataPoint(t: $0.t, x: $0.x, y: $0.y, z: $0.z, w: $0.w)
            },
            rotationData: sensorData.rotationData.map {
                DataPoint(t: $0.t, x: $0.x, y: $0.y, z: $0.z, w: $0.w)
            },
            altimeterData: sensorData.altimeterData.map {
                DataPoint(t: $0.t, x: $0.x, y: $0.y, z: $0.z, w: $0.w)
            },
            stepsData: sensorData.stepsData.map {
                DataPoint(t: $0.t, x: $0.x, y: $0.y, z: $0.z, w: $0.w)
            }
        )
        
        let jsonSchema = createMotionSensorSchema()
        let avro = Avro()
        let schemaResult = avro.decodeSchema(schema: jsonSchema)
        print("DEBUG: Schema decode result: \(schemaResult)")
        
        print("DEBUG: About to encode Avro record...")
        return try avro.encode(avroRecord)
    }
    
    private static func createMotionSensorSchema() -> String {
        let dataPointSchema = """
        {
            "type": "record",
            "name": "DataPoint",
            "fields": [
                {"name": "t", "type": "int"},
                {"name": "x", "type": ["null", "int"], "default": null},
                {"name": "y", "type": ["null", "int"], "default": null},
                {"name": "z", "type": ["null", "int"], "default": null},
                {"name": "w", "type": ["null", "int"], "default": null}
            ]
        }
        """
        
        return """
        {
            "type": "record",
            "name": "MotionSensorRecord",
            "fields": [
                {"name": "startTime", "type": "int"},
                {"name": "accelerationData", "type": {"type": "array", "items": \(dataPointSchema)}},
                {"name": "rotationData", "type": {"type": "array", "items": \(dataPointSchema)}},
                {"name": "altimeterData", "type": {"type": "array", "items": \(dataPointSchema)}},
                {"name": "stepsData", "type": {"type": "array", "items": \(dataPointSchema)}}
            ]
        }
        """
    }
}

private struct MotionSensorRecord: Codable {
    let startTime: Int
    let accelerationData: [DataPoint]
    let rotationData: [DataPoint]
    let altimeterData: [DataPoint]
    let stepsData: [DataPoint]
}

private struct DataPoint: Codable {
    let t: Int
    let x: Int?
    let y: Int?
    let z: Int?
    let w: Int?
}
