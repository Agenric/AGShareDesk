//
//  WeChatPlatform.h
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "ShareMessageObject.h"

@interface WeChatPlatform : NSObject

/*!
 * @brief 分享一条消息到微信
 *
 * @param message 消息Model
 * @param scene   分享到的微信通道
 *
 * @return 分享结果
 */
+ (BOOL)shareWithMessage:(ShareMessageObject *)message toScene:(enum WXScene)scene;

/*! @brief 检查微信是否已被用户安装
 *
 * @return 微信已安装返回YES，未安装返回NO。
 */
+ (BOOL)isWXAppInstalled;

/*! @brief 判断当前微信的版本是否支持OpenApi
 *
 * @return 支持返回YES，不支持返回NO。
 */
+ (BOOL)isWXAppSupportApi;

@end
