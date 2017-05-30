//
//  ShareMessageObject.h
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import <Foundation/Foundation.h>

@interface ShareMessageObject : NSObject

/*!
 * @brief 获得分享实例（建议使用此方法获取实例）
 *
 * @param title     标题
 * @param content   内容
 * @param link      链接
 * @param logoIcon  logo图片
 *
 * @return 分享实体
 */
+ (ShareMessageObject *)messageWithTitle:(NSString *)title content:(NSString *)content link:(NSString *)link logoIcon:(UIImage *)logoIcon;

/* 分享标题 */
@property (nonatomic, copy, readonly) NSString *title;

/* 分享内容 */
@property (nonatomic, copy, readonly) NSString *content;

/* 分享链接 */
@property (nonatomic, copy, readonly) NSString *link;

/* 分享logo的Icon */
@property (nonatomic, copy, readonly) UIImage *logoIcon;

@end
