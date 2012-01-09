//
//  SearchEvaluateProtocol.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchEvaluateProtocol : NSObject{
    
    NSMutableArray *_evaluateArray;
    int _allEvaluateCount;
}

@property (nonatomic, retain) NSMutableArray *_evaluateArray;
@property (nonatomic, assign)int _allEvaluateCount;

- (id) init ;

- (id)objectAtIndex:(NSUInteger)index;

- (void)addItemsByJSON:(NSString*)json ;

- (void)setItemsByJSON:(NSString*)json ;

@end
