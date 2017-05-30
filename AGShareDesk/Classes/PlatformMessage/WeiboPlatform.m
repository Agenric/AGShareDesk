//
//  WeiboPlatform.m
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import "WeiboPlatform.h"

@implementation WeiboPlatform

+ (WBMessageObject *)shareWebpageWith:(ShareMessageObject *)messageObj {
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID  = [self ret32bitString];
    webpage.title = messageObj.title;
    webpage.description = messageObj.content;
    webpage.thumbnailData = UIImagePNGRepresentation(messageObj.logoIcon);
    webpage.webpageUrl = messageObj.link;

    WBMessageObject *message = [WBMessageObject message];
    message.text = messageObj.content;
    message.mediaObject = webpage;
    return message;
}

+ (BOOL)shareWithMessage:(ShareMessageObject *)message {
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[WeiboPlatform shareWebpageWith:message] authInfo:authRequest access_token:nil];
    request.userInfo = nil;

    return [WeiboSDK sendRequest:request];
}

+ (NSString *)ret32bitString {
    char data[32];
    for (int x = 0; x < 32; data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

@end
