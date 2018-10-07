source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!
target 'DeliciousBody' do
  
  
  pod 'RangeSeekSlider', :git => 'https://github.com/WorldDownTown/RangeSeekSlider.git', :branch => 'swift_4'
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'Kingfisher', '~> 4.0'
  pod 'Alamofire'
  pod 'Player'
  pod 'SwiftGifOrigin'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'RealmSwift'
  
end


post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

