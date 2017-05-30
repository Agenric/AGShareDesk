//
//  TencentPlatform.m
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import "TencentPlatform.h"

@implementation TencentPlatform

+ (BOOL)shareWithMessage:(ShareMessageObject *)message toScene:(TencentScene)scene{
    NSData *imgData = UIImagePNGRepresentation(message.logoIcon);
    QQApiURLObject *urlObj = [QQApiURLObject objectWithURL:[NSURL URLWithString:message.link] title:message.title description:message.content previewImageData:imgData targetContentType:QQApiURLTargetTypeNews];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:urlObj];
    
    if (scene == TecnentScene_QQ) {
        return [QQApiInterface sendReq:req];
    } else {
        return [QQApiInterface SendReqToQZone:req];
    }
}

+ (BOOL)isQQInstalled {
    return [QQApiInterface isQQInstalled];
}

+ (BOOL)isQQSupportApi {
    return [QQApiInterface isQQSupportApi];
}

@end
