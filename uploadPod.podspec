#
#  Be sure to run `pod spec lint uploadPod.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|



spec.name         = "uploadPod"
spec.version      = "0.0.4"
spec.summary      = "练习一下，仅此而已"


spec.description  = <<-DESC
练习一下，仅此而已 WTModule是工具类

DESC

spec.homepage     = "https://github.com/ZT28TZ/uploadPod"

spec.license      = "MIT"

spec.author             = { "ZT" => "3193152800@qq.com" }

spec.source       = { :git => "https://github.com/ZT28TZ/uploadPod.git", :tag => "v0.0.4" }

  spec.source_files = 'one/one/two/**/*'

end
