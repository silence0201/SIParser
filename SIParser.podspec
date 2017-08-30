
Pod::Spec.new do |s|
  s.name         = "SIParser"
  s.version      = "1.2"
  s.summary      = "SIParser"
  s.description  = <<-DESC
                    An Objective-C wrapper to parse HTML/XML
                   DESC

  s.homepage     = "https://github.com/silence0201/SIParser"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Silence" => "374619540@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/silence0201/SIParser.git", :tag => "1.2" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.library   = "xml2"
  s.xcconfig    = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
end
