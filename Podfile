target 'DeliciousBody' do
  use_frameworks!
  
  pod 'RangeSeekSlider', :git => 'https://github.com/WorldDownTown/RangeSeekSlider.git', :branch => 'swift_4'
  pod 'SkyFloatingLabelTextField', '~> 3.0'

end


post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

