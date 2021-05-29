Pod::Spec.new do |s|
  s.name             = 'DKDropDownView'
  s.version          = '0.1.1'
  s.summary          = 'A Simple Date Picker and Custom Picker using UITextField.'
  s.homepage         = 'https://github.com/dharmesh304/DKDropDownView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JDB Techs' => 'jdbtechs@gmail.com' }
  s.source           = { :git => 'https://github.com/dharmesh304/DKDropDownView.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '11.0'
  s.swift_versions = ['5.1', '5.2', '5.3']
  s.source_files = 'DKDropDownView/Classes/**/*'
  
  s.resource_bundles = {
    'DKDropDownView' => ['DKDropDownView/Assets/*.xib','Pod/**/*.xib'] 
  }
  s.frameworks = 'UIKit'
end
