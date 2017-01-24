
Pod::Spec.new do |s|
  s.name         = "SIHTMLParser"
  s.version      = "1.1"
  s.summary      = "HTMLParser"
  s.description  = <<-DESC
                    An Objective-C wrapper to parse HTML
                   DESC

  s.homepage     = "https://github.com/silence0201/HTMLParser"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Silence" => "374619540@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/silence0201/HTMLParser.git", :tag => "1.1" }
  s.source_files  = "HTMLParser", "HTMLParser/**/*.{h,m}"
  s.exclude_files = "HTMLParser/Exclude"
  s.library   = "xml2"
  s.xcconfig    = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
end
