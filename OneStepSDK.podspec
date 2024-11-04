Pod::Spec.new do |spec|
  spec.name         = "OneStepSDK"
  spec.version      = "1.1.1"
  spec.summary      = "OneStep iOS SDK"

  spec.description  = <<-DESC
    The OneStep SDK is a comprehensive solution for integrating advanced motion analysis capabilities into your iOS applications. It allows for real-time data collection, analysis, and insightful feedback based on motion data, tailored to your app’s needs.
  DESC

  spec.homepage     = "https://github.com/OneStepRND/onestep-sdk-ios"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { 
    "Shahar Davidson" => "shahar@onestep.co",
    "Ziv Kesten" => "ziv@onestep.co",
    "David" => "david@onestep.co"
  }
  spec.platform     = :ios, "15.0" # Adjust if necessary

  spec.source       = { :http => "https://github.com/OneStepRND/onestep-sdk-ios/releases/download/1.1.1/OneStepSDK.xcframework.zip" }
  spec.vendored_frameworks = "Frameworks/OneStepSDK.xcframework"

  spec.requires_arc = true
end
