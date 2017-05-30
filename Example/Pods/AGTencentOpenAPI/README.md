# AGTencentOpenAPI

[![CI Status](http://img.shields.io/travis/agenric/AGTencentOpenAPI.svg?style=flat)](https://travis-ci.org/agenric/AGTencentOpenAPI)
[![Version](https://img.shields.io/cocoapods/v/AGTencentOpenAPI.svg?style=flat)](http://cocoapods.org/pods/AGTencentOpenAPI)
[![License](https://img.shields.io/cocoapods/l/AGTencentOpenAPI.svg?style=flat)](http://cocoapods.org/pods/AGTencentOpenAPI)
[![Platform](https://img.shields.io/cocoapods/p/AGTencentOpenAPI.svg?style=flat)](http://cocoapods.org/pods/AGTencentOpenAPI)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AGTencentOpenAPI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AGTencentOpenAPI"
```

## Author

Agenric, AgenricWon@foxmail.com

## License

AGTencentOpenAPI is available under the MIT license. See the LICENSE file for more info.

## Notice

> 假设在腾讯开发平台申请的APP ID为：123456789，腾讯需要添加两个Scheme，并且有明确格式：
>
> > 1、"tencent"+腾讯QQ互联应用appID
> >
> > 2、“QQ”+腾讯QQ互联应用appID转换成十六进制（不足8位前面补0）
>
> 所以需要添加 tencent123456789 和 QQ075bcd15，此标识要保证唯一性且不可更改，否则会导致在QQ或QQ空间分享之后，不能正确回到本客户端



* 在info.plist内部要添加如下代码

```xml
<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>QQ</string>
<key>CFBundleURLSchemes</key>
<array>
<string>QQ075bcd15</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>tencent</string>
<key>CFBundleURLSchemes</key>
<array>
<string>tencent123456789</string>
</array>
</dict>
</array>
<key>LSApplicationQueriesSchemes</key>
<array>
<string>mqqapi</string>
<string>mqq</string>
<string>mqqOpensdkSSoLogin</string>
<string>mqqconnect</string>
<string>mqqopensdkdataline</string>
<string>mqqopensdkgrouptribeshare</string>
<string>mqqopensdkfriend</string>
<string>mqqopensdkapi</string>
<string>mqqopensdkapiV2</string>
<string>mqqopensdkapiV3</string>
<string>mqzoneopensdk</string>
<string>mqqopensdkapiV3</string>
<string>mqqopensdkapiV3</string>
<string>wtloginmqq</string>
<string>wtloginmqq2</string>
<string>mqzone</string>
<string>mqzonev2</string>
<string>mqzoneshare</string>
<string>wtloginqzone</string>
<string>mqzonewx</string>
<string>mqzoneopensdkapiV2</string>
<string>mqzoneopensdkapi19</string>
<string>mqzoneopensdkapi</string>
<string>mqzoneopensdk</string>
</array>
```

以上代码为适配iOS 9下可能出现的类似`-canOpenURL: failed for URL: "wtloginmqq2://qzapp" - error: "(null)"`的错误，如遇到其他类似的错误，可通过向`LSApplicationQueriesSchemes`数组中添加对应键值来解决此类问题。



* 若要在appdelegate中区分腾讯家族其他产品的回调可在对应的回调方法中添加以下代码

```objective-c
if ([[url scheme] isEqualToString:@"QQ075bcd15"]) {
[QQApiInterface handleOpenURL:url delegate:self];
return YES;
}
```
