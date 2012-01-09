//
//  LiboratoryController.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LiboratoryController.h"
#import "EtaoShowAlert.h"
#import "UpdateSession.h"

#import "TBWebViewControll.h"


@interface LiboratoryController() 
-(void)isVersionIsLatest;
-(void)showAlert:(NSString*) msg;
-(void)doLogin;
@end

@implementation LiboratoryController

@synthesize updateSession = _updateSession;


- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)loadView {
    [super loadView];
    
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(100, 100, 100, 50)];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
    [loginButton addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self isVersionIsLatest];
}


-(void)isVersionIsLatest {
    if(nil == _updateSession) {
        _updateSession = [[UpdateSession alloc] init];
        _updateSession.sessionDelegate = self;
    }
    
    [self retain];
    [_updateSession requestUpdateDate];
}


- (void) UpdateRequestDidFinish:(NSObject *)obj {
    [self release];
    
    if (_updateSession.UpdateProtocal.isHaveNewVersion == YES) {
        [self showAlert:_updateSession.UpdateProtocal.versionDesc];
    }
    else {
        [self showAlert:@"您已经是最新的版本了，亲！"];
    }
}


- (void) UpdateRequestDidFailed:(NSObject *)obg {
    [self release];
    
    [EtaoShowAlert showAlert];
    
    [self showAlert:@"FAILED"];
}


-(void) showAlert:(NSString*) msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:msg
                                                   delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
    alert.delegate = self;
	[alert show];
	[alert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView buttonTitleAtIndex:buttonIndex] == @"马上升级") {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id451400917?mt=8"]];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateSession.UpdateProtocal.updateUrl]];
    }
}


- (void)alertViewCancel:(UIAlertView *)alertView {
     NSLog(@"url == ...alertViewCancel..alertViewCancel..alertViewCancel..");
}


- (void)doLogin {
//    Login2TaobaoController *loginController = [[[Login2TaobaoController alloc] init]autorelease];
//    [loginController setDelegate:self];
//    [self.navigationController pushViewController:loginController animated:YES];    
}


- (void)didLoginFinish:(BOOL)success {
    [EtaoShowAlert showAlert];
    
    if(success == YES) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录成功了。。。欧耶欧耶。"
                                                        message:@"没什么说第"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        //我的淘宝网址
        //http://m.taobao.com/my_taobao.htm?sid=5f6da8efd380f7684671df59fafd8682
        //NSString* str = [NSString stringWithFormat:@"%@",@"Hello World"] 
        
        NSString *url = [NSString stringWithFormat:@"http://m.taobao.com/my_taobao.htm?sid=%@", [TOP wapSID]];
        
        TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURL:url title:@"我的淘宝"]autorelease]; 
        
        webv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webv animated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败。。。哇嘎哇嘎"
                                                        message:@"没什么说第"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

@end
