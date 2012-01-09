//
//  EtaoLocalDiscountRequest.h
//  etao4iphone
//
//  Created by iTeam on 11-8-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"

@interface EtaoLocalDiscountRequest : HttpRequest {
	NSMutableDictionary *_parameters;
	
	NSString *_urlprefix ; 

}

@property (nonatomic, assign) NSMutableDictionary *_parameters; 
@property (nonatomic, assign) NSString *_urlprefix ;

- (void)addParam:(NSObject *)param forKey:(NSString *)key;

- (void)removeParam:(NSString *)key;

- (void)start;

- (NSString *)_dictToQueryString:(NSDictionary *)dict;
@end
