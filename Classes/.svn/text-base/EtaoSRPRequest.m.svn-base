//
//  EtaoSRPRequest.m
//  etao4iphone
//
//  Created by guanyuhong on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoSRPRequest.h"
#import "NSObject+SBJson.h"

@implementation EtaoSRPRequest

@synthesize _urlprefix;
@synthesize _parameters; 

- (id)init {
	
    self = [super init];
    if (self) {
        self.cache = YES;
        //FIX ME,USE Test 
#ifdef __WAP_TEST__
        self._urlprefix = @"http://waptest.taobao.com/rest/api2.do?";
#elif  defined __WAP_A__
        self._urlprefix = @"http://wapa.taobao.com/rest/api2.do?";
#else
		self._urlprefix = @"http://m.taobao.com/rest/api2.do?";
#endif
		self._parameters = [NSMutableDictionary dictionaryWithCapacity:10];
		return self;  
    }
	return nil;
}

- (void)addParam:(NSObject *)param forKey:(NSString *)key{
	[self._parameters setObject:param forKey:key];
}

- (void)removeParam:(NSString *)key{
	[self._parameters removeObjectForKey:key];
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

- (void)start{
	NSString *url = [NSString stringWithFormat:@"%@%@",self._urlprefix,[self _dictToQueryString:self._parameters]];
	NSLog(@"load url %@",url);
	[self load:url];
}

- (void)dealloc { 
    [super dealloc];
}


@end
