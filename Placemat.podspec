Pod::Spec.new do |s|
  s.name             = "Placemat"
  s.version          = "0.3.0"
  s.summary          = "Dependency of Luncheon. Support library. Provides helper methods for String conversions & pluralization and NSDictionary."
  s.homepage         = "https://github.com/Dan2552/Placemat"
  s.license          = 'MIT'
  s.author           = { "Daniel Inkpen" => "dan2552@gmail.com" }
  s.source           = { :git => "https://github.com/Dan2552/Placemat.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Dan2552'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
