#
# Be sure to run `pod lib lint StToast.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StToast'
  s.version          = '0.1.2'
  s.summary          = 'Custom toast message with 3 default types'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Toast message with plenty of customizations three position options on screen, three default types'

  s.homepage         = 'https://github.com/sahilshaligram/StToast'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sahilshaligram' => '126651068+sahilshaligram@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/sahilshaligram/StToast.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'

  s.source_files = 'StToast/Classes/**/*'
  s.exclude_files  = 'StToast/Classes/*.plist'
  
  s.resource_bundles = {
    'StToast' => ['StToast/Assets/*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
