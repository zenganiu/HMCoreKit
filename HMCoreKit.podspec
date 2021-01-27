
Pod::Spec.new do |spec|
  spec.name         = "HMCoreKit"
  spec.version      = "0.0.1"
  spec.summary      = "基础核心库"
  spec.description  = <<-DESC
                    基础核心库
                   DESC

  spec.homepage     = "https://gitee.com/HuiMin18/HMCoreKit"
  spec.license      = "MIT"
  spec.author       = { "xuhuimin" => "1126981418@qq.com" }
  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://gitee.com/HuiMin18/HMCoreKit.git",:tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.swift"

end
