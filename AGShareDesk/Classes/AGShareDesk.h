//
//  AGShareDesk.h
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import <Foundation/Foundation.h>
#import "ShareMessageObject.h"

#import "WeChatPlatform.h"
#import "WeiboPlatform.h"
#import "TencentPlatform.h"

typedef NS_ENUM(NSInteger, SharePlatfrom) {
    SharePlatfrom_Tencent = 0,
    SharePlatfrom_WeChat,
    SharePlatfrom_Sina,
};

typedef NS_ENUM(NSInteger, ShareChannel) {
    ShareChannel_WeChatSession = 0,
    ShareChannel_WeChatTimeline,
    ShareChannel_Weibo,
    ShareChannel_TencentQQ,
    ShareChannel_TencentQZone,
};

typedef NS_ENUM(NSInteger, ShareAfterStatus) {
    ShareAfterStatus_Success = 0,
    ShareAfterStatus_Failure,
    ShareAfterStatus_NotInstalled,
    ShareAfterStatus_NotSupport,
    ShareAfterStatus_Cancel,
    ShareAfterStatus_Other,
};

@protocol AGShareDeskDelegate <NSObject>

- (void)afterShareFromPlatform:(SharePlatfrom)platform resultStatus:(ShareAfterStatus)status;

@end

@interface AGShareDesk : NSObject
<
WXApiDelegate,
WeiboSDKDelegate,
QQApiInterfaceDelegate
>

@property (weak, nonatomic) id<AGShareDeskDelegate> delegate;

/*!
 * @brief 获取分享平台的单例
 *
 * @return LEShareDesk
 */
+ (instancetype)shareInstance;

/**
 注册第三方分享平台

 @param weiboAppKey 微博开放平台第三方应用appKey
 @param weChatAppKey 微信开发者ID
 @param tencentAppId 第三方应用在互联开放平台申请的唯一标识
 */
- (void)registerWithWeiboAppKey:(NSString *)weiboAppKey weChatAppKey:(NSString *)weChatAppKey tencentAppId:(NSString *)tencentAppId;

/**
 处理Scheme调起结果
 注：在Appdelegate的OpenURL回调中调用此方法，并且必须在主线程中执行。

 @param application 当前的应用单例
 @param url 调起当前应用的url
 @param options 处理方式的字典UIApplicationOpenURLOptionsKey
 */
- (void)handleApplication:(UIApplication *)application withOpenURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

/*!
 * @brief 分享到某一个渠道
 *
 * @param shareChannel  渠道代号
 * @param message       分享消息体
 * @param afterDelegate 结果回调代理
 */
- (void)shareToChannel:(ShareChannel)shareChannel withMessgaeObject:(ShareMessageObject *)message afterDelegate:(id<AGShareDeskDelegate>)afterDelegate ;

/*!
 * @brief 获取平台名字
 *
 * @param platform 平台标示
 *
 * @return 返回平台的文字显示
 */
- (NSString *)shareNameWithPlatform:(SharePlatfrom)platform;

@end
