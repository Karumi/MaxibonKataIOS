target 'MaxibonKataIOS' do
  use_frameworks!

  target 'MaxibonKataIOSTests' do
    inherit! :search_paths
    pod 'SwiftCheck', :git => 'https://github.com/typelift/SwiftCheck.git', :commit => 'df82fb889864945c64458f38846702af729b3ee4'
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
  end
