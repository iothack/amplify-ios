#
#  Be sure to run `pod spec lint Amplify.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

load 'build-support/dependencies.rb'

Pod::Spec.new do |s|
  s.name         = 'AWSPluginsCore'

  s.version      = $AMPLIFY_VERSION
  s.summary      = 'Amazon Web Services Amplify for iOS.'

  s.description  = 'AWS Amplify for iOS provides a declarative library for application development using cloud services'

  s.homepage     = 'https://github.com/aws-amplify/amplify-ios'
  s.license      = 'Apache License, Version 2.0'
  s.author       = { 'Amazon Web Services' => 'amazonwebservices' }
  s.source       = { :git => 'https://github.com/aws-amplify/amplify-ios.git', :tag => release_tag() }

  s.platform     = :ios, '11.0'
  s.swift_version = '5.0'

  s.source_files = 'AmplifyPlugins/Core/AWSPluginsCore/**/*.swift'

  s.dependency 'Amplify', $AMPLIFY_VERSION
  s.dependency 'AWSMobileClient', optimistic_version($AWS_SDK_VERSION)

  # This is technically redundant, but adding it here allows Xcode to find it
  # during initial indexing and prevent build errors after a fresh install
  s.dependency 'AWSCore', optimistic_version($AWS_SDK_VERSION)

end
