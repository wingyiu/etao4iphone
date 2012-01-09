//
//  ETDataCenterProtocal.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ETDataCenterProtocal <NSObject>
@required
- (void)serializing:(NSString*)key;
- (void)deserializing:(NSString*)key;
- (NSString*)className;
+ (NSString*)keyName:(NSString*)str;
@end
