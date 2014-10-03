Pod::Spec.new do |s|
  s.name         = "WTAScrollViewKeyboardManager"
  s.version      = "1.0.0"
  s.summary      = "A class to manage scroll view content and scroll indicator insets when the keyboard appears and disappears."
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = "Andrew Carter", "Matt Yohe", "Joel Garrett", "WillowTree Apps"
  s.homepage     = "https://github.com/willowtreeapps/WTAScrollViewKeyboardManager"
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/willowtreeapps/WTAScrollViewKeyboardManager.git", :tag => s.version }
  s.source_files  = 'WTScrollViewKeyboardManager/WTAKeyboardManager.{h,m}'
  s.requires_arc = true
end
