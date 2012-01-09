//
//  EtaoCategoryProtocol.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EtaoCategoryProtocol : NSObject {
    
    NSMutableArray *_categoryArray;
    int categoryCount;
}

@property (nonatomic, retain) NSMutableArray *categoryArray;
@property (nonatomic, assign)int categoryCount;

- (id) init ;

- (id)objectAtIndex:(NSUInteger)index;

- (void)addItemsByJSON:(NSString*)json ;

- (void)setItemsByJSON:(NSString*)json ;

@end
