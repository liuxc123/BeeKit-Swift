Pod::Spec.new do |s|
  s.name             = 'BeeKit-Swift'
  s.version          = '1.1.0'
  s.summary          = 'A tool of BeeKit.'
  s.homepage         = 'https://github.com/liuxc123/BeeKit-Swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/BeeKit-Swift.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.frameworks = 'UIKit', 'Foundation'
  
  s.subspec 'Core' do |ss|
    ss.source_files = 'Source/Core/Source/**/*'
    ss.resources = 'Source/Core/Assets/**/*'
    ss.dependency 'CocoaLumberjack/Swift'
    ss.dependency 'SwifterSwift'
    ss.dependency 'SwiftValidators'
    ss.dependency 'SwiftyAttributes'
    ss.dependency 'MJRefresh'
    ss.dependency 'MBProgressHUD'
    ss.dependency 'Schedule'
  end
  
  s.subspec 'LimitInput' do |ss|
    ss.source_files = 'Source/LimitInput/Source/**/*'
    ss.dependency 'BeeKit-Swift/Core'
  end

end
