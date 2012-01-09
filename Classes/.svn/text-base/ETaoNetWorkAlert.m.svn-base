//
//  ETaoNetWorkAlert.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETaoNetWorkAlert.h"

@implementation ETaoNetWorkAlert
static BOOL g_net_work_alert_show = NO  ;

+ (ETaoNetWorkAlert*) alert {
    return [[[ETaoNetWorkAlert alloc]init] autorelease];
}


- (void) show {
    if ( !g_net_work_alert_show ) {  
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"网络不可用" message:@"无法与服务器通信，请连接到移动数据网络或者wifi." delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]autorelease];
    
        [alert show];
        [self retain];
        
        g_net_work_alert_show = YES;
    }
}


- (void) showLocation {
    if ( !g_net_work_alert_show ) {  
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"定位失败" message:[NSString stringWithFormat:@"请开启“设置->通用->定位服务”中的相关选项。"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]autorelease];
        alert.delegate  = self;
        [alert show]; 
        [self retain];         
        g_net_work_alert_show = YES;
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex { 
    g_net_work_alert_show = NO ;
    [self release];
}


@end
