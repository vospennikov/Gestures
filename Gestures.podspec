Pod::Spec.new do |spec|
  spec.name                  = 'SUIGestures'
  spec.version               = '1.0.6'
  spec.license               = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage              = 'https://github.com/vospennikov/Gestures'
  spec.authors               = { 'Mikhail Vospennikov' => 'm.vospennikov@gmail.com' }
  spec.summary               = 'SwiftUI gesture extensions'
  spec.description           = <<-DESC
Before iOS 16 and macOS 13, SwiftUI didn't return the gesture location. It is a lightweight open-source extension to SwiftUI's gesture API.
                               DESC
  spec.source                = { :git => 'https://github.com/vospennikov/Gestures.git', :tag => spec.version.to_s }
  spec.source_files          = 'Sources/Gestures/**/*'
  
  spec.swift_versions        = '5.7.1'
  spec.ios.deployment_target = '13.0'
  spec.osx.deployment_target = '11.0'

  spec.frameworks            = 'Foundation'
  spec.ios.frameworks        = 'UIKit'
  spec.osx.frameworks        = 'AppKit'
end
