//
//  AGShareDesk.m
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import "AGShareDesk.h"

@interface AGShareDesk ()

@end

@implementation AGShareDesk

+ (instancetype)shareInstance {
    static AGShareDesk *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AGShareDesk alloc] init];
    });
    return instance;
}

- (void)registerWithWeiboAppKey:(NSString *)weiboAppKey weChatAppKey:(NSString *)weChatAppKey tencentAppId:(NSString *)tencentAppId {
    // Weibo
    [WeiboSDK registerApp:weiboAppKey];
    
    // WeChat
    [WXApi registerApp:weChatAppKey];
    
    // QQ
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
    [[TencentOAuth alloc] initWithAppId:tencentAppId andDelegate:nil];
#pragma clang diagnostic pop
}

- (void)handleApplication:(UIApplication *)application withOpenURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [QQApiInterface handleOpenURL:url delegate:self];
    [WeiboSDK handleOpenURL:url delegate:self];
    [WXApi handleOpenURL:url delegate:self];
}

- (void)shareToChannel:(ShareChannel)shareChannel withMessgaeObject:(ShareMessageObject *)message afterDelegate:(id)afterDelegate {
    self.delegate = afterDelegate;
    
    switch (shareChannel) {
        case ShareChannel_WeChatSession: //微信好友
        {
            if (![WeChatPlatform isWXAppInstalled]) {
                if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
                    [self.delegate afterShareFromPlatform:SharePlatfrom_WeChat resultStatus:ShareAfterStatus_NotInstalled];
                }
                
            } else if (![WeChatPlatform isWXAppSupportApi]) {
                if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
                    [self.delegate afterShareFromPlatform:SharePlatfrom_WeChat resultStatus:ShareAfterStatus_NotSupport];
                }
            } else {
                [WeChatPlatform shareWithMessage:message toScene:WXSceneSession];
            }
        }
            break;
        case ShareChannel_WeChatTimeline: // 微信朋友圈
        {
            if (![WeChatPlatform isWXAppInstalled]) {
                if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
                    [self.delegate afterShareFromPlatform:SharePlatfrom_WeChat resultStatus:ShareAfterStatus_NotInstalled];
                }
            } else if (![WeChatPlatform isWXAppSupportApi]) {
                if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
                    [self.delegate afterShareFromPlatform:SharePlatfrom_WeChat resultStatus:ShareAfterStatus_NotSupport];
                }
            } else {
                [WeChatPlatform shareWithMessage:message toScene:WXSceneTimeline];
            }
        }
            break;
        case ShareChannel_Weibo: // 新浪微博
        {
            [WeiboPlatform shareWithMessage:message];
        }
            break;
        case ShareChannel_TencentQQ: // QQ好友
        {
            if (![TencentPlatform isQQInstalled]) {
                if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
                    [self.delegate afterShareFromPlatform:SharePlatfrom_Tencent resultStatus:ShareAfterStatus_NotInstalled];
                }
            } else if (![TencentPlatform isQQSupportApi]) {
                if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
                    [self.delegate afterShareFromPlatform:SharePlatfrom_Tencent resultStatus:ShareAfterStatus_NotSupport];
                }
            } else {
                [TencentPlatform shareWithMessage:message toScene:TecnentScene_QQ];
            }
        }
            break;
        case ShareChannel_TencentQZone: // QQ空间
        {
            if (![TencentPlatform isQQInstalled]) {
                if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
                    [self.delegate afterShareFromPlatform:SharePlatfrom_Tencent resultStatus:ShareAfterStatus_NotInstalled];
                }
            } else if (![TencentPlatform isQQSupportApi]) {
                if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
                    [self.delegate afterShareFromPlatform:SharePlatfrom_Tencent resultStatus:ShareAfterStatus_NotSupport];
                }
            } else {
                [TencentPlatform shareWithMessage:message toScene:TecnentScene_QZone];
            }
        }
            break;
    }
}

#pragma mark - Delegate & DetaSouse
#pragma mark 微信回调方法 && Tencent回调方法
- (void)onResp:(BaseResp*)resp{
    //微信支付
    if ([resp isKindOfClass:[PayResp class]]){
        return;
    }
    //微信消息
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        [self weChatShareResultAfter:response];
    }
    //QQ消息
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        SendMessageToQQResp *response = (SendMessageToQQResp *)resp;
        [self tencentShareResultAfter:response];
    }
}

- (void)onReq:(QQBaseReq *)req {}
- (void)isOnlineResponse:(NSDictionary *)response {}

#pragma mark 微博回调方法
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        WBSendMessageToWeiboResponse *sendMessageResponse = (WBSendMessageToWeiboResponse *)response;
        [self weiboShareResultAfter:sendMessageResponse];
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
    } else if ([response isKindOfClass:WBPaymentResponse.class]) {
    } else if([response isKindOfClass:WBSDKAppRecommendResponse.class]) {
    }
}

- (void)weChatShareResultAfter:(SendMessageToWXResp *)responseResult {
    ShareAfterStatus status = -1;
    switch (responseResult.errCode) {
        case WXSuccess:             //成功
            status = ShareAfterStatus_Success;
            break;
        case WXErrCodeUserCancel:   //用户点击取消并返回
            status = ShareAfterStatus_Cancel;
            break;
        case WXErrCodeCommon:       //普通错误类型
        case WXErrCodeSentFail:     //发送失败
        case WXErrCodeAuthDeny:     //授权失败
        case WXErrCodeUnsupport:    //微信不支持
            status = ShareAfterStatus_Failure;
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
        [self.delegate afterShareFromPlatform:SharePlatfrom_WeChat resultStatus:status];
    }
}

- (void)tencentShareResultAfter:(SendMessageToQQResp *)responseResult {
    ShareAfterStatus status = -1;
    NSInteger errCode = [responseResult.result integerValue];
    switch (errCode) {
        case EQQAPISENDSUCESS:                      // 成功
            status = ShareAfterStatus_Success;
            break;
        case EQQAPIQQNOTINSTALLED:                  // QQ未安装
            status = ShareAfterStatus_NotInstalled;
            break;
        case EQQAPIQQNOTSUPPORTAPI:                 // QQ不支持此Api
        case EQQAPIMESSAGETYPEINVALID:              // 消息类型不支持
        case EQQAPIMESSAGECONTENTNULL:              // 消息内容为空
        case EQQAPIMESSAGECONTENTINVALID:           // 消息内容无效
        case EQQAPIAPPNOTREGISTED:                  // 此App未注册
        case EQQAPIAPPSHAREASYNC:                   // 异步的分享动作(结果未知)
        case EQQAPIQQNOTSUPPORTAPI_WITH_ERRORSHOW:  // QQ不支持的错误
        case EQQAPISENDFAILD:                       // 发送失败
        case EQQAPIQZONENOTSUPPORTTEXT:             //QZone分享不支持text类型分享
        case EQQAPIQZONENOTSUPPORTIMAGE:            //QZone分享不支持image类型分享
            status = ShareAfterStatus_Failure;
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
        [self.delegate afterShareFromPlatform:SharePlatfrom_Tencent resultStatus:status];
    }
}

- (void)weiboShareResultAfter:(WBSendMessageToWeiboResponse *)responseResult {
    ShareAfterStatus status = ShareAfterStatus_Failure;
    switch (responseResult.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:             //成功
            status = ShareAfterStatus_Success;
            break;
        case WeiboSDKResponseStatusCodeUserCancel:          //用户取消发送
            status = ShareAfterStatus_Cancel;
            break;
        case WeiboSDKResponseStatusCodeSentFail:            //发送失败
        case WeiboSDKResponseStatusCodeAuthDeny:            //授权失败
        case WeiboSDKResponseStatusCodeUserCancelInstall:   //用户取消安装微博客户端
        case WeiboSDKResponseStatusCodePayFail:             //支付失败
        case WeiboSDKResponseStatusCodeShareInSDKFailed:    //分享失败 详情见response UserInfo
        case WeiboSDKResponseStatusCodeUnsupport:           //不支持的请求
        case WeiboSDKResponseStatusCodeUnknown:             //未知
            status = ShareAfterStatus_Failure;
            break;
    }
    if ([self.delegate respondsToSelector:@selector(afterShareFromPlatform:resultStatus:)]) {
        [self.delegate afterShareFromPlatform:SharePlatfrom_Sina resultStatus:status];
    }
}

- (NSString *)shareNameWithPlatform:(SharePlatfrom)platform {
    NSString *platformName = nil;
    switch (platform) {
        case SharePlatfrom_WeChat:
            platformName = @"微信";
            break;
        case SharePlatfrom_Sina:
            platformName = @"微博";
            break;
        case SharePlatfrom_Tencent:
            platformName = @"QQ";
            break;
    }
    return platformName;
}

@end
