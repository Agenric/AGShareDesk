#
# Be sure to run `pod lib lint AGShareDesk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AGShareDesk'
    s.version          = '0.1.0'
    s.summary          = 'AGShareDesk is a unified sharing desk for QQ、Wechat and WeiBo.'

    s.description      = <<-DESC
                        AGShareDesk is a unified sharing desk whit QQ、QQZone、WeChatSession、WeChatTimeline、Weibo.
                        DESC

    s.homepage         = 'https://github.com/agenric/AGShareDesk'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Agenric' => 'AgenricWon@gmail.com' }
    s.source           = { :git => 'https://github.com/agenric/AGShareDesk.git', :tag => s.version.to_s }

    s.ios.deployment_target = '8.0'
    s.requires_arc = true

    s.source_files = 'AGShareDesk/Classes/**/*'

    s.dependency 'WechatOpenSDK'
    s.dependency 'WeiboSDK'
    s.dependency 'AGTencentOpenAPI', '~> 3.2.1'
end
