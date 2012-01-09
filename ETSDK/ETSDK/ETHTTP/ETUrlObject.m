//
//  ETUrlObject.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETUrlObject.h"
#import "NSObject+SBJson.h"
@implementation ETUrlObject

@synthesize parameters = _parameters;
@synthesize urlprefix = _urlprefix ;

- (void) dealloc {
    [_urlprefix release];
    [_parameters release];
    [super dealloc];
}

-(id) init {
    self = [super init];
#ifdef __WAP_TEST__
    self.urlprefix = @"http://api.waptest.taobao.com/rest/api2.do?";
#elif  defined __WAP_A__
    self.urlprefix = @"http://wapa.taobao.com/rest/api2.do?";
#else
    self.urlprefix = @"http://m.taobao.com/rest/api2.do?";
#endif
    self.parameters = [NSMutableDictionary dictionaryWithCapacity:10];
    
    return self;
}

- (void) reset {
    [_parameters removeAllObjects];
}
- (void)addParam:(NSObject *)param forKey:(NSString *)key{
	[_parameters setObject:param forKey:key];
}

- (void)removeParam:(NSString *)key{
	[_parameters removeObjectForKey:key];
}


- (NSString *)_dictToQueryString:(NSDictionary *)dict {
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:[[dict allKeys] count]];
    
    for (NSString *key in [dict keyEnumerator]) {
        NSObject *val = [dict objectForKey:key];
        NSString *paramVal;
        
        if ([val isKindOfClass:[NSString class]]) {
            paramVal = (NSString *)val;
        } else {
            paramVal = [val JSONRepresentation];
        } 
        
        [dataArr addObject:[NSString stringWithFormat:@"%@=%@",
                            [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                            [[paramVal stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"]
                            ]];
        
    }
    
    return [dataArr componentsJoinedByString:@"&"];
}

- (NSString*)getRequesrUrl{
	NSString *url = [NSString stringWithFormat:@"%@%@",_urlprefix,[self _dictToQueryString:_parameters]];
	return url;
}


@end
