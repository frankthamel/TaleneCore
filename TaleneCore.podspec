#
# Be sure to run `pod lib lint TaleneCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TaleneCore'
  s.version          = '1.0.27'
  s.summary          = 'TaleneCore is the core library for all Talene Apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TaleneCore is the core library for all Talene apps. This comes with a structured framework which contains logging, analytics tracking, data handling, network handling, notification handling and so on.
                       DESC

  s.homepage         = 'https://bitbucket.org/frankthamel/talenecore'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'w.frankthamel@gmail.com' => 'w.frankthamel@gmail.com' }
  s.source           = { :git => 'https://frankthamel@bitbucket.org/frankthamel/talenecore.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'Source/**/*.{swift,png,xib,xcassets}'
  s.swift_version = '5.0'
  s.static_framework = true
  
   s.resource_bundles = {
       'TaleneCore' => ['Source/**/**/*.{png,xib,xcassets}']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'

  # Networking
  s.dependency 'Moya', '13.0.1'
  s.dependency 'Kingfisher', '5.12.0'
  s.dependency 'SwiftyJSON', '~> 4.0'
  s.dependency 'ReachabilitySwift', '5.0.0'

  # Database
  s.dependency 'RealmSwift', '4.3.0'

  # Keychain Access
  s.dependency 'Locksmith', '4.0.0'

  # Logger
  s.dependency 'SwiftyBeaver', '1.8.4'

  # Alerts and Progress
  s.dependency 'SwiftMessages', '7.0.1'
  s.dependency 'SVProgressHUD', '2.2.5'
  s.dependency 'Malert', '4.0'

  # File Manager
  s.dependency 'FCFileManager', '1.0.20'

  # Firebase
  s.dependency 'Firebase/Core', '6.14.0'
  s.dependency 'Firebase/Auth', '6.14.0'
  s.dependency 'Firebase/Analytics', '6.14.0'
  s.dependency 'Firebase/Messaging', '6.14.0'
  s.dependency 'Firebase/RemoteConfig', '6.14.0'
  s.dependency 'Google-Mobile-Ads-SDK', '7.59.0'
  s.dependency 'Firebase/Firestore', '6.14.0'
  s.dependency 'FirebaseFirestoreSwift'

  # Loading
  s.dependency 'ARSLineProgress', '3.1.0'

  # Format phone number
  s.dependency 'PhoneNumberKit', '3.2.0'

  # Loading custom views
  s.dependency 'LoadableViews', '3.4.0'

  # File Handling
  s.dependency 'SSZipArchive', '2.2.3'

  # Facebook
  s.dependency 'FBSDKCoreKit/Swift', '6.5.2'
  s.dependency 'FBSDKLoginKit/Swift', '6.5.2'
  s.dependency 'FBSDKShareKit/Swift', '6.5.2'

  # LICENSE
  s.dependency 'LicensesViewController', '~> 0.9.0'

  # UI
  s.dependency 'Popover', '1.3.0'
  
end
