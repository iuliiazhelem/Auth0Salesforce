source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

use_frameworks!

target 'AKAuth0TestApp' do
    pod 'Lock', '~> 1.24'
    pod 'SimpleKeychain'
 end

post_install do |installer|
    installer.pods_project.build_configurations.each { |bc|
        bc.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
    }
end
