Pod::Spec.new do |s|
  s.name             = "BackspaceJSON"
  s.version          = "1.0.0"
  s.summary          = "Stupid simple access for unCodable JSON objects."
  s.description      = <<-DESC
                          Codable has made consuming JSON much easier, but there are still cases where
                          it's not suitable, such as a configuration file with arbitrary keys and values.
                          In those cases, you just want type-safe access to values without a lot of fuss.
                          BackspaceJSON is a tiny (single enum, ~100 lines) framework written in Swift.
                       DESC
  s.homepage         = "https://github.com/mjmsmith/backspace-json"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Mark Smith" => "mark@camazotz.com" }
  s.social_media_url = "https://twitter.com/camazotzllc"
  
  s.platform         = :ios, "11.0"
  s.swift_versions   = ["4.0", "5.0"]
  s.source           = { :git => "https://github.com/mjmsmith/backspacejson.git", :tag => "v#{s.version}" }
  s.source_files     = "BackspaceJSON/JSON.swift"
end
