#
 Pod::Spec.new do |s|
  s.name         = 'YKLineChartView'
  s.summary      = 'chart framework for iOS.'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'chenyk0317' => 'chenyk0317@163.com' }
  s.social_media_url = 'http://chenyk.com'
  s.homepage     = 'https://github.com/chenyk0317/YKLineChartView'
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.source       = { :git => 'https://github.com/chenyk0317/YKLineChartView.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'YKLineChartView/*.{h,m}'
  s.public_header_files = 'YKLineChartView/*.{h}'
  s.frameworks = 'UIKit', 'CoreFoundation'

end
