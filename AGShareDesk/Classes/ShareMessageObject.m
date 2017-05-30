//
//  ShareMessageObject.m
//  Pods
//
//  Created by Agenric on 2017/3/30.
//
//

#import "ShareMessageObject.h"

@interface ShareMessageObject ()

@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *content;
@property (nonatomic, copy, readwrite) NSString *link;
@property (nonatomic, copy, readwrite) UIImage *logoIcon;

@end

@implementation ShareMessageObject

+ (ShareMessageObject *)messageWithTitle:(NSString *)title content:(NSString *)content link:(NSString *)link logoIcon:(UIImage *)logoIcon {
    ShareMessageObject *message = [ShareMessageObject new];
    message.title = title;
    message.content = content;
    message.link = link;
    message.logoIcon = logoIcon;
    
    return message;
}

@end
