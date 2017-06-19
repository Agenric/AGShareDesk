//
//  TencentPlatform.h
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import <Foundation/Foundation.h>
#import <AGTencentOpenAPI/TencentOpenAPI/QQApiInterface.h>
#import <AGTencentOpenAPI/TencentOpenAPI/TencentOAuth.h>
#import "ShareMessageObject.h"

typedef NS_ENUM(NSInteger, TencentScene) {
    TecnentScene_QQ,
    TecnentScene_QZone,
};

@interface TencentPlatform : NSObject

/*!
 * @brief 分享一条消息到QQ
 *
 * @param message 消息Model
 * @param scene   分享到的通道
 *
 * @return 分享结果
 */
+ (BOOL)shareWithMessage:(ShareMessageObject *)message toScene:(TencentScene)scene;

/**
 检测是否已安装QQ
 \return 如果QQ已安装则返回YES，否则返回NO
 */
+ (BOOL)isQQInstalled;

/**
 检测QQ是否支持API调用
 \return 如果当前安装QQ版本支持API调用则返回YES，否则返回NO
 */
+ (BOOL)isQQSupportApi;

@end
