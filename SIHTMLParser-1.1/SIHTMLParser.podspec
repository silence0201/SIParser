Pod::Spec.new do |s|
  s.name = "SIHTMLParser"
  s.version = "1.1"
  s.summary = "HTMLParser"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Silence"=>"374619540@qq.com"}
  s.homepage = "https://github.com/silence0201/HTMLParser"
  s.description = "An Objective-C wrapper to parse HTML"
  s.libraries = "xml2"
  s.xcconfig = {"HEADER_SEARCH_PATHS"=>"$(SDKROOT)/usr/include/libxml2"}
  s.source = { :path => '.' }

  s.ios.deployment_target    = '7.0'
  s.ios.vendored_framework   = 'ios/SIHTMLParser.framework'
end
