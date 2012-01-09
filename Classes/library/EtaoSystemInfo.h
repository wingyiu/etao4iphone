//
//  EtaoSystemInfo.h
//  etao4iphone
//
//  Created by iTeam on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EtaoSystemInfo : NSObject {
	
}
@property(nonatomic,retain) NSString *uuid ;
@property(nonatomic,retain) NSString *version ;
@property(nonatomic,retain) NSMutableDictionary *sysdict ;

@property(nonatomic,retain) NSString *clt_act ;

@property(nonatomic,retain) NSString *userLocation ;
@property(nonatomic,retain) NSString *userLocationDetail ;


+ (EtaoSystemInfo*)sharedInstance;
- (BOOL) save  ;
- (void) setValue:(id)value forKey:(NSString *)key;
 
//启动用户统计
- (void)statUserAction:(NSString *)act;

@end
