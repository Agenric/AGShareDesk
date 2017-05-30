//
//  WeiboPlatform.h
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "ShareMessageObject.h"

@interface WeiboPlatform : NSObject

/*!
 * @brief 分享一条消息到微博
 *
 * @param message 消息Model
 *
 * @return 分享结果
 */
+ (BOOL)shareWithMessage:(ShareMessageObject *)message;

@end
