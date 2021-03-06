Pod::Spec.new do |s|
  s.name     = 'BBZVideoEngine'
  s.version  = '0.0.1'
  s.license  = 'Private and Confidencial'
  s.summary  = 'Edit and Export Videos'
  s.homepage = 'https://github.com/guolai/BBZVideoEngine'
  s.author   = { "bob" => "zhuhaibobb@gmail.com"  }
  s.source   = { :git => 'https://github.com/guolai/BBZVideoEngine.git', :tag => "#{s.version}" }
#   s.resource_bundles = {
#     'BBZVideoEngineFrameworkBundle' => ['BBZVideoEngine/Resource/*'],
# }
  s.source_files = 'BBZVideoEngine/VideoEngine/**/*.{h,m}','BBZVideoEngine/GPUImage/**/*.{h,m}'
  s.public_header_files = 'BBZVideoEngine/VideoEngine/**/*.{h}','BBZVideoEngine/GPUImage/**/*.{h,m}'
  s.xcconfig = { 'CLANG_MODULES_AUTOLINK' => 'YES' }
  s.prefix_header_file = 'BBZVideoEngine/BBZVideoEngine/BBZVEHeader.h'
  s.ios.deployment_target = '5.0'
  s.ios.frameworks   = ['OpenGLES', 'CoreMedia', 'QuartzCore', 'AVFoundation']
  s.dependency "JRSwizzle"
end
