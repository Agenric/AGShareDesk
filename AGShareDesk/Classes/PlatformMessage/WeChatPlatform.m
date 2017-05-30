//
//  WeChatPlatform.m
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import "WeChatPlatform.h"

@implementation WeChatPlatform

+ (BOOL)shareWithMessage:(ShareMessageObject *)message toScene:(enum WXScene)scene {
    WXMediaMessage *mediaMessage = [WXMediaMessage message];
    mediaMessage.title = message.title;
    mediaMessage.description = message.content;
    mediaMessage.thumbData = UIImagePNGRepresentation(message.logoIcon);
    
    WXWebpageObject *webpageObj = [WXWebpageObject object];
    webpageObj.webpageUrl = message.link;
    mediaMessage.mediaObject = webpageObj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = mediaMessage;
    req.scene = scene;
    return [WXApi sendReq:req];
}

+ (BOOL)isWXAppInstalled {
    return [WXApi isWXAppInstalled];
}

+ (BOOL)isWXAppSupportApi {
    return [WXApi isWXAppSupportApi];
}

@end
