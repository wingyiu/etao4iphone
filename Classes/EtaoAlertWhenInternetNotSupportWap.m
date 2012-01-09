//
//  EtaoAlertWhenInternetNotSupportWap.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoAlertWhenInternetNotSupportWap.h"
#import "TBWebViewControll.h"

@interface EtaoAlertWhenInternetNotSupportWap()
-(void)showJumpToInternet;
@end

@implementation EtaoAlertWhenInternetNotSupportWap

@synthesize internetUrl = _internetUrl;
@synthesize internetTitle = _internetTitle;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithURL:(NSString *)url title:(NSString*)title
{
    self = [super init];
    if (self) {
        // Initialization code here.
  
        _internetUrl = url;
        _internetTitle = title;
    }  
    return self;
}


- (void)loadView {
    [super loadView];
    
    [self setTitle:@"跳转提示"];
    
//    UIImageView *backLogoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"etaoJumpToInternetAlert.png"]];
//    [backLogoImgView setFrame:CGRectMake(121, 50, 77, 70)];
//    [self.view addSubview:backLogoImgView];
//    [backLogoImgView release];
        
    NSString* tempStr = _internetUrl;
    if(tempStr.length > 30) {
        tempStr = [_internetUrl substringToIndex:30];
        tempStr = [tempStr stringByAppendingString:@"..."];
    }
    
    UILabel* laber = [[UILabel alloc]initWithFrame:CGRectMake(25, 60, 275, 60 )];
    [laber setTextAlignment:UITextAlignmentLeft];
    [laber setText:[NSString stringWithFormat:@"您将访问的商品页面%@还没有手机版，将直接跳转到网页版",tempStr]];
    laber.numberOfLines = 3;
    laber.lineBreakMode = UILineBreakModeCharacterWrap;
    laber.font = [UIFont systemFontOfSize:16];
    laber.textColor = [UIColor grayColor];
    [self.view addSubview:laber];
    [laber release];
    
    UIButton *userFeedBack = [[UIButton alloc]initWithFrame:CGRectMake(52, 150, 215, 30)];
    [userFeedBack setBackgroundImage:[UIImage imageNamed:@"etaoJumpToInternetButton.png"] forState:UIControlStateNormal];
    [self.view addSubview:userFeedBack ];
    [userFeedBack addTarget:self action:@selector(showJumpToInternet) forControlEvents:UIControlEventTouchUpInside];    
    [userFeedBack release];
}


-(void)showJumpToInternet {
    
    if (delegate != nil) {
        [delegate JumpToInternet];
    }
}


-(void) dealloc {
    [super dealloc];
}

@end
