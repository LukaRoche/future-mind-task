platform :ios, '15.0'

use_frameworks!
inhibit_all_warnings!

target 'LoyaltyRewards' do
  project 'LoyaltyRewards.xcodeproj'

  pod 'SwiftGen'

  target 'LoyaltyRewardsTests' do
    inherit! :complete
  end
end

post_install do |p|
  p.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
