# AGShareDesk

[![CI Status](http://img.shields.io/travis/agenric/AGShareDesk.svg?style=flat)](https://travis-ci.org/agenric/AGShareDesk)
[![Version](https://img.shields.io/cocoapods/v/AGShareDesk.svg?style=flat)](http://cocoapods.org/pods/AGShareDesk)
[![License](https://img.shields.io/cocoapods/l/AGShareDesk.svg?style=flat)](http://cocoapods.org/pods/AGShareDesk)
[![Platform](https://img.shields.io/cocoapods/p/AGShareDesk.svg?style=flat)](http://cocoapods.org/pods/AGShareDesk)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AGShareDesk is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AGShareDesk"
```

## Author

Agenric, AgenricWon@gmail.com

## License

AGShareDesk is available under the MIT license. See the LICENSE file for more info.

## Notice

> 目前仅对自有业务需求做了简单定制，支持分享普通的文本消息以及附带网址的分享、支持分享到QQ、QQ空间、新浪微博、微信朋友以及微信朋友圈。
>
> 其中，需要在info.plist文件中添加对应平台的Scheme以及白名单，如果你不了解，可以去看AGShareDesk-Info.plist中`LSApplicationQueriesSchemes`对应的键值。
>
> 如果你发现不能正常调起第三方App，那有可能是申请的key失效，换成你自己的即可。



* 两行代码配置完成：

```objective-c
@implementation AGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[AGShareDesk shareInstance] registerWithWeiboAppKey:@"1818950315" weChatAppKey:@"wx42e8d6a9776ab49c" tencentAppId:@"1105318793"];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [[AGShareDesk shareInstance] handleApplication:app withOpenURL:url options:options];
    return YES;
}
```

* 随意调用：

```objective-c
// buttonIndex为选中的分享平台
[[AGShareDesk shareInstance] shareToChannel:buttonIndex withMessgaeObject:[ShareMessageObject messageWithTitle:@"分享标题" content:@"分享内容" link:@"http://www.baidu.com" logoIcon:[UIImage imageNamed:@"shareIcon"]] afterDelegate:self];
```
