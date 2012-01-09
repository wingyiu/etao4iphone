//
//  EtoMoreViewController.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoMoreViewController.h"
#import "UserFeedBackByEmail.h"

//add testcode
#import "LiboratoryController.h"
//restcode end

@interface EtaoMoreViewController()
    -(void)showUserFeedBack;
@end

@implementation EtaoMoreViewController

@synthesize userFeedBuEmail = _userFeedBuEmail;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES]; 
}


- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES]; 
}


- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTitle:@"关于我们"];
    
    UIImageView *backLogoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"morebackLogo.png"]];
    [backLogoImgView setFrame:CGRectMake(101, 65, 118, 68)];
    [self.view addSubview:backLogoImgView];
    //add test demo code
   // backLogoImgView.userInteractionEnabled = YES;
   // UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLiboratoryView)];
   // [backLogoImgView addGestureRecognizer:singleTap];
    //[singleTap release];
    //test demo code end
    [backLogoImgView release];
    
    
    UIButton *userFeedBack = [[UIButton alloc]initWithFrame:CGRectMake(51, 150, 218, 40)];
    [userFeedBack setBackgroundImage:[UIImage imageNamed:@"moreUserfeedback.png"] forState:UIControlStateNormal];
    [self.view addSubview:userFeedBack];
    [userFeedBack addTarget:self action:@selector(showUserFeedBack) forControlEvents:UIControlEventTouchUpInside];
    [userFeedBack release];
    
    UILabel *versionNum = [[UILabel alloc] initWithFrame:CGRectMake(20, 360, 280, 20)];
//    versionNum.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    versionNum.backgroundColor = [UIColor clearColor];
    versionNum.font = [UIFont systemFontOfSize:12];
//    versionNum.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    versionNum.numberOfLines = 1;
    versionNum.textColor = [UIColor grayColor]; 
    versionNum.textAlignment = UITextAlignmentCenter;
    versionNum.text = @"版本1.2.0";
    [self.view addSubview:versionNum];
    [versionNum release];

    UILabel *copyRight = [[UILabel alloc] initWithFrame:CGRectMake(20, 380, 280, 20)];
//    copyRight.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    copyRight.backgroundColor = [UIColor clearColor];
    copyRight.font = [UIFont systemFontOfSize:11];
//    copyRight.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    copyRight.numberOfLines = 1;
    copyRight.textColor = [UIColor grayColor]; 
    copyRight.textAlignment = UITextAlignmentCenter;
    copyRight.text = @"一淘网Copyright © 2010-2011 ETAO.COM 版权所有";
    [self.view addSubview:copyRight];
    [copyRight release];

}


-(void)showUserFeedBack {
    
    if (nil == _userFeedBuEmail) {
        _userFeedBuEmail = [[UserFeedBackByEmail alloc] init];
    }
    
    [_userFeedBuEmail sendEmail:self];
}


-(void)showLiboratoryView {
    LiboratoryController *webv = [[[LiboratoryController alloc] init]autorelease];     
    [self.navigationController pushViewController:webv animated:YES];    
}


-(void) dealloc {
    [_userFeedBuEmail release];
    [super dealloc];
}
@end
