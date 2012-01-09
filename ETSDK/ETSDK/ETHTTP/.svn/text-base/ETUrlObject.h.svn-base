//
//  ETUrlObject.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETUrlObject : NSObject{
    NSMutableDictionary *_parameters;
    
    NSString *_urlprefix ; 
}

@property (nonatomic, retain) NSMutableDictionary *parameters; 
@property (nonatomic, retain) NSString *urlprefix ;

- (void)addParam:(NSObject *)param forKey:(NSString *)key;

- (void)removeParam:(NSString *)key;


- (NSString *)_dictToQueryString:(NSDictionary *)dict;

- (NSString*)getRequesrUrl ;
@end
