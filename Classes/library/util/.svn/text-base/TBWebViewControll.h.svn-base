//
//  TBWebViewControll.h
//  taofunny
//
//  Created by iTeam on 11-7-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EtaoAlertWhenInternetNotSupportWap.h"
#import "ETaoUIViewController.h"
@interface TBWebViewControll : ETaoUIViewController <UIWebViewDelegate,UIActionSheetDelegate,EtaoAlertWhenInternetNotSupportWapDelegate>{

	UIWebView *_webView;
	NSString * _url ; 
	NSString * _name ; 
	UIActivityIndicatorView *activityIndicator; 
	
	UIBarButtonItem* next;
	UIBarButtonItem* back;
	UIBarButtonItem* refresh;
	UIBarButtonItem* stop;
	UIBarButtonItem* safari;
	UIBarButtonItem* space;
    
    
    UIImageView* _netWorkError;
    
    EtaoAlertWhenInternetNotSupportWap* _alertWhenInternetNotSupportWap;
    
    bool supportWap;
}
- (id)initWithURL:(NSString *)url title:(NSString*)title;

//tp 0 taobao. tp 1 tmall
- (id)initWithURLAndType:(NSString *)url title:(NSString*)title type:(int)tp isSupportWap:(bool)support;

-(void)goSafari;
-(void)refreshWebView;
-(void)goBack;
-(void)goForward;
-(void)Stop;

- (UIBarButtonItem *)backButton;

@property (nonatomic, retain) UIBarButtonItem *back,*next,*refresh,*stop,*safari,*space;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString *_url;
@property (nonatomic, retain) NSString *_name;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator; 
@property (nonatomic, retain) UIToolbar *_toolbar;
@property (nonatomic, assign) bool supportWap;
@property (nonatomic, assign) bool userStopLoading;
@property (nonatomic, retain) UIImageView* netWorkError; 
@property (nonatomic, retain) EtaoAlertWhenInternetNotSupportWap* alertWhenInternetNotSupportWap;

@end
