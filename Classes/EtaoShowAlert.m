//
//  EtaoShowAleartView.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoShowAlert.h"
#import "EtaoAlertView.h"

@implementation EtaoShowAlert

@synthesize etaoAlertView;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


+ (void)showAlert{
    EtaoAlertView *alert = [[EtaoAlertView alloc] initBackGroundImage:[UIImage imageNamed:@"netnotwork.png"] delegate:self title:@" " message:@" " buttons:nil  buttonimage:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
    [alert release];
}

@end
