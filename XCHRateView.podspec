Pod::Spec.new do |s|
  s.name             = 'XCHRateView'
  s.version          = '1.0'
  s.summary          = 'By far the most rate view I have seen. My joke.'
 
  s.description      = <<-DESC
This rate view can help you give your app a score ,its more convenient!
                       DESC
 
  s.homepage         = 'https://github.com/xuech/XCHRateView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xuech' => 'xuech_love@126.com' }
  s.source           = { :git => 'https://github.com/xuech/XCHRateView.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'XCHRateView/*'
 
end