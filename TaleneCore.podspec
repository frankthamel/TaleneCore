#
# Be sure to run `pod lib lint TaleneCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TaleneCore'
  s.version          = '0.1.0'
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

  s.source_files = 'Source/**/*.swift'
  
  # s.resource_bundles = {
  #   'TaleneCore' => ['TaleneCore/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
