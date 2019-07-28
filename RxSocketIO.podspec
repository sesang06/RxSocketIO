#
# Be sure to run `pod lib lint RxSocketIO.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxSocketIO'
  s.version          = '0.1.0'
  s.summary          = 'RxSwift Wrapper for Socket IO Swift Client'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/sesang06/RxSocketIO'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sesang06' => 'sesang06@naver.com' }
  s.source           = { :git => 'https://github.com/sesang06/RxSocketIO.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RxSocketIO/Classes/**/*.swift'
  s.requires_arc     = true
  # s.resource_bundles = {
  #   'RxSocketIO' => ['RxSocketIO/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'RxSwift', '~> 5'
  s.dependency 'RxCocoa', '~> 5'
  s.dependency 'Socket.IO-Client-Swift', '~> 15.1.0'
  s.ios.deployment_target = '8.0'
end
