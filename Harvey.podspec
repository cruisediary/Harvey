Pod::Spec.new do |s|
  s.name         = "Harvey"
  s.version      = "0.1.0"
  s.summary      = "Harvey is a delightful network stubbing library in Swift."
  s.description  = <<-DESC
  Harvey is a delightful network stubbing library in Swift. It's still a work in progress.
                   DESC
  s.homepage     = "https://github.com/Moya/Harvey"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors            = { 
    "Łukasz Mróz" => "thesunshinejr@gmail.com",
    "Ash Furrow" => "ash@ashfurrow.com" 
  }
  s.ios.deployment_target = "10.0"
  s.osx.deployment_target = "10.12"
  s.watchos.deployment_target = "3.0"
  s.tvos.deployment_target = "10.0"

  s.source       = { :git => "https://github.com/Moya/Harvey.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/**/*.swift"
end
