target 'MaxibonKataIOS' do
  use_frameworks!

  target 'MaxibonKataIOSTests' do
    inherit! :search_paths
    pod 'SwiftCheck', :git => 'https://github.com/fjfdeztoro/SwiftCheck.git', :branch => 'fix-compilation-issues-xcode9'
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
  end