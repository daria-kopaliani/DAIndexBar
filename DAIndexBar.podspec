Pod::Spec.new do |s|
  s.name         = "DAIndexBar"
  s.version      = "1.0.1"
  s.summary      = "Customizable Index Bar."
  s.homepage     = "https://github.com/daria-kopaliani/DAIndexBar.git"
  s.license      = 'MIT'
  s.author       = { "Daria Kopaliani" => "daria.kopaliani@gmail.com" }
  s.source       = { :git => "https://github.com/daria-kopaliani/DAIndexBar.git", :tag => s.version.to_s }
  s.platform     = :ios, '6.0'
  s.source_files = 'DAIndexBar/*.{h,m}'
  s.requires_arc = true
end
