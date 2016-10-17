# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

target 'Look Around' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Look Around
  pod 'Alamofire', '~> 3.5'
  pod 'ObjectMapper', '~> 1.2.0'
  pod 'MBProgressHUD', '~> 0.9'
  pod 'SwiftyJSON', '~> 2.3'
  pod 'SDWebImage', '~>3.7'
  pod 'GoogleMaps'

  target 'Look AroundTests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end
