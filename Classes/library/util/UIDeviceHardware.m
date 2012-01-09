//
//  UIDeviceHardware.m
//  taobao4iphone
//
//  Created by xiewenwei on 10-9-16.
//  Copyright 2010 Taobao.inc. All rights reserved.
//

#import "UIDeviceHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDeviceHardware

- (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

- (NSString *) platformString{
	
	NSString *platform = [self platform];
	
	if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
	if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";	
	if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";	
	if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";	
	if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";	
	if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";	
	if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";	
	if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";	
	if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";	
	if ([platform isEqualToString:@"i386"])         return @"Simulator";	
	return platform;	
}


+ (BOOL)isRetinaDisplay {
    static BOOL isRetina = NO;
    static BOOL isGotResult = NO;
    
    if (!isGotResult) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4) { 
            isRetina = NO;
        } else {
            isRetina = [[UIScreen mainScreen] scale] > 1;
        }
        isGotResult = YES;
    }
    
    return isRetina;
}

@end