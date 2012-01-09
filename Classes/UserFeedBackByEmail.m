//
//  UserFeedBackController.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserFeedBackByEmail.h"

@implementation UserFeedBackByEmail

@synthesize controllerID;

//
//MFMailComposeViewController: 类提供了一个标准接口，它管理的编辑和发送电子邮件。您可以使用此视图控制器显示在您的应用程序标准的电子邮件意见，并填充与初始值，如主题，电子邮件收件人，正文和附件，查看字段。用户可以编辑您所指定的初始内容，并选择发送电子邮件或取消操作。
//
//实现:
//1、添加类库{Frameworks}：MessageUI.framework；
//2、实现代码：
/*
 * @DO 发送邮件
 * @param sender
 */
- (void) sendEmail:(id)sender
{
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
//    
//    mailCompose.navigationBar.backgroundColor = [UIColor clearColor];
//    
//    [mailCompose.navigationController.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"navLeftButton.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    [mailCompose.navigationController.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"navLeftButton.png"]];
//    
    if(mailCompose)
    {
        //设置代理
        [mailCompose setMailComposeDelegate:self];
        NSArray *toAddress = [NSArray arrayWithObject:@"fk-yt@taobao.com"];
//        NSArray *ccAddress = [NSArray arrayWithObject:@"fk-yt@taobao.com"];
        NSString *emailBody = @"<H1>反馈内容!</H1>";
        //设置收件人
        [mailCompose setToRecipients:toAddress];
        //设置抄送人
//        [mailCompose setCcRecipients:ccAddress];
        //设置邮件内容	
        [mailCompose setMessageBody:emailBody isHTML:YES];
        //设置邮件主题
        [mailCompose setSubject:@"用户反馈"];
        //设置邮件附件{mimeType:文件格式|fileName:文件名}
        //[mailCompose addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"1.png"];
        //设置邮件视图在当前视图上显示方式
        
        controllerID = sender;
        
        [controllerID retain];
        [sender presentModalViewController:mailCompose animated:YES];
    }
    
    [mailCompose release];
}


- (void) alertWithTitle:(NSString *)_title_ msg:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_ 
                                                    message:msg 
                                                   delegate:nil 
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller 
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    NSString *msg;
    
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
    
    NSLog(@"发送结果：%@", msg);
    [controllerID dismissModalViewControllerAnimated:YES];
    [controllerID release];
}

@end
