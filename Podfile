post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5'
	    config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end

use_frameworks!

def utilities_pod
    pod 'Nuke'
end

def realm_pod
    pod 'RealmSwift'
end

# ====== Main App =======

def main_app

    utilities_pod
    realm_pod
  
end

# ====== iOS App =======

target 'SouthGeeksTest' do
  platform :ios, '13.0'
  main_app
end

target 'SouthGeeksTestTests' do
  platform :ios, '13.0'
  main_app
end