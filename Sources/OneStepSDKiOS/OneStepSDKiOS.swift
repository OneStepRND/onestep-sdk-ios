import Foundation
import OneStepSDK

extension OSTSDKCore {
    public func initialize(appId: String, apiKey: String, distinctId: String, identityVerification: String?, configuration: OSTConfiguration, enableAvro: Bool = false, completion: @escaping (Bool)->()) {
        
        if enableAvro { AvroSetup.initialize() }
        
        OSTSDKCore.shared.initialize(
            appId: appId,
            apiKey: apiKey,
            distinctId: distinctId,
            identityVerification: nil,
            configuration: configuration,
            completion: completion)
        
    }
}
