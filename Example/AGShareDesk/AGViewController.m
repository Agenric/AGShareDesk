//
//  AGViewController.m
//  AGShareDesk
//
//  Created by agenric on 05/31/2017.
//  Copyright (c) 2017 agenric. All rights reserved.
//

#import "AGViewController.h"
#import "AGShareDesk.h"

@interface AGViewController ()<AGShareDeskDelegate>

@end

@implementation AGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareButtonAction:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信好友",@"微信朋友圈",@"新浪微博",@"QQ好友",@"QQ空间", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", buttonIndex);
    
    [[AGShareDesk shareInstance] shareToChannel:buttonIndex withMessgaeObject:[ShareMessageObject messageWithTitle:@"分享标题" content:@"分享内容" link:@"http://www.baidu.com" logoIcon:[UIImage imageNamed:@"shareIcon"]] afterDelegate:self];
}

-(void)afterShareFromPlatform:(SharePlatfrom)platform resultStatus:(ShareAfterStatus)status {
    NSLog(@"分享到%@平台，分享结果状态(ShareAfterStatus):-%ld",[[AGShareDesk shareInstance] shareNameWithPlatform:platform], status);
}

@end
