//
//  NSString+QueryString.m
//  taobao4iphone
//
//  Created by Xu Jiwei on 10-10-14.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import "NSString+QueryString.h"


@implementation NSString (QueryString)

+ (NSDictionary *)queryParamsFromString:(NSString *)str {
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:str];
    str = [url query];
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSArray *arr = [str componentsSeparatedByString:@"&"];
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    
    for (NSString *str in arr) {
        NSArray *pair = [str componentsSeparatedByString:@"="];
        if ([pair count] == 2) {
            NSString *val = [[pair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *key = [[pair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (val != nil && key != nil) {
                [ret setObject:val forKey:key];
            }
        }
    }
    
    return ret;
}

+ (NSString *)queryStringFromParams:(NSDictionary *)dict {
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[[dict allKeys] count]];
    for (NSString *key in [dict allKeys]) {
//        [ret addObject:[NSString stringWithFormat:@"%@=%@",
//                        [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                        [[dict objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
     
        NSString * encodedKey = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                    NULL,
                                                                                    (CFStringRef)key,
                                                                                    NULL,
                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                    kCFStringEncodingUTF8 );
        NSString *encodedParaVal = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                       NULL,
                                                                                       (CFStringRef)[dict objectForKey:key],
                                                                                       NULL,
                                                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                       kCFStringEncodingUTF8 );
        NSString *str = [[NSString alloc] initWithFormat:@"%@=%@",encodedKey,encodedParaVal];
        [ret addObject:str];
        CFRelease(encodedKey);
        CFRelease(encodedParaVal);
        [str release];
        
    }
    
    return [ret componentsJoinedByString:@"&"];
}


- (NSString*)stringForHttpRequest {
    NSString * encodedStr= (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                NULL,
                                                                                (CFStringRef)self,
                                                                                NULL,
                                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                kCFStringEncodingUTF8 );
    return [encodedStr autorelease];
}


- (NSString *)trimString {
	NSMutableString *mStr = [self mutableCopy];
	CFStringTrimWhitespace((CFMutableStringRef)mStr);   
	NSString *result = [mStr copy];   
	[mStr release];
	return [result autorelease];
}

@end
