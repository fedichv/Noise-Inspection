platform :ios, '17.0'

target 'DBLevel' do
  use_frameworks! :linkage => :static

  pod 'LMGaugeViewSwift'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
      end
    end
  end
end
