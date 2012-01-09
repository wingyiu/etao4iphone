//
//  NSDateCategories.m
//  macww
//
//  Created by Xu Jiwei on 10-5-25.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import "NSDateCategories.h"


@implementation NSDate (FormatString)

- (NSString*)stringWithFormat:(NSString*)fmt {
    static NSDateFormatter *fmtter;
    
    if (fmtter == nil) {
        fmtter = [[NSDateFormatter alloc] init];
    }
    
    if (fmt == nil || [fmt isEqualToString:@""]) {
        fmt = @"HH:mm:ss";
    }
    
    [fmtter setDateFormat:fmt];
    
    return [fmtter stringFromDate:self];
}


+ (NSDate *)dateFromString:(NSString*)str withFormat:(NSString*)fmt {
    return [self dateFromString:str withFormat:fmt locale:nil];
}


+ (NSDate *)dateFromString:(NSString*)str withFormat:(NSString*)fmt locale:(NSLocale *)locale {
    static NSDateFormatter *fmtter;
    
    if (fmtter == nil) {
        fmtter = [[NSDateFormatter alloc] init];
    }
    
    if (fmt == nil || [fmt isEqualToString:@""]) {
        fmt = @"HH:mm:ss";
    }
    
    [fmtter setDateFormat:fmt];
    if (locale != nil) {
        [fmtter setLocale:locale];
    }
    
    return [fmtter dateFromString:str];
}


@end
