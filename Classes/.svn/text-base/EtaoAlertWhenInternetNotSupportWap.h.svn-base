//
//  EtaoAlertWhenInternetNotSupportWap.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoUIViewWithBackgroundController.h"

@protocol EtaoAlertWhenInternetNotSupportWapDelegate<NSObject> 

- (void) JumpToInternet;

@end;

@interface EtaoAlertWhenInternetNotSupportWap : UIViewController {
  
    NSString* _internetUrl;
    NSString* _internetTitle;
    
    id<EtaoAlertWhenInternetNotSupportWapDelegate> delegate;
}

- (id)initWithURL:(NSString *)url title:(NSString*)title;

@property (nonatomic, retain) NSString* internetUrl;
@property (nonatomic, retain) NSString* internetTitle;

@property (nonatomic, assign ) id<EtaoAlertWhenInternetNotSupportWapDelegate> delegate;

@end
