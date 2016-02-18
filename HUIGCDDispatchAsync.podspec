Pod::Spec.new do |s|
  s.name         = "HUIGCDDispatchAsync"
  s.version      = "1.0.0"
  s.summary      = "A simple wrapper around GCD dispatch_async() function to make easily cancellation."
  s.homepage     = "https://github.com/Tinghui/HUIGCDDispatchAsync"
  s.license      = "MIT"
  s.author       = { "Tinghui" => "tinghui.zhang3@gmail.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/Tinghui/HUIGCDDispatchAsync.git", :tag => s.version }
  s.source_files = "HUIGCDDispatchAsync/HUIGCDDispatchAsync.{h,m}"
  s.requires_arc = true
end
