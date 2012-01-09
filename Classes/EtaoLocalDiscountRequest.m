//
//  EtaoLocalDiscountRequest.m
//  etao4iphone
//
//  Created by iTeam on 11-8-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalDiscountRequest.h"
#import "NSObject+SBJson.h"

@implementation EtaoLocalDiscountRequest

@synthesize _urlprefix;
@synthesize _parameters; 

- (id)init {
	
    self = [super init];
    if (self) {
		self._urlprefix = @"http://s.taobao.com/map/iphone/iphone_interface_4etao.php?";
		self._parameters = [NSMutableDictionary dictionaryWithCapacity:5];
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
	
/* 	UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘" 
													  message:url
													 delegate:nil 
											cancelButtonTitle:@"OK" 
											otherButtonTitles:nil] autorelease];
	[alert show];  */
	NSLog(@"%@",url);
	[self load:url];
}

- (void)dealloc { 
    [super dealloc];
}

@end
