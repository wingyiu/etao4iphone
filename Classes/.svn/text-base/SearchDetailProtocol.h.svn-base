//
//  SearchDetailProtocol.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EtaoAuctionItem.h"
#import "EtaoProductItem.h"

@interface SearchDetailProtocol : NSObject {
    
    NSMutableArray *_items ;
    EtaoProductItem *_ProductItem;
    
    int _totalCount ;
    int _offset;
}


@property (nonatomic,retain) NSMutableArray *_items;

@property (nonatomic,retain) EtaoProductItem *_ProductItem;

@property (nonatomic,assign) int _totalCount;

@property (nonatomic,assign) int _offset;

- (id) init ;

- (NSUInteger)count ;

- (id)objectAtIndex:(NSUInteger)index;


- (void)addItemsByJSON:(NSString*)json ;

- (void)setItemsByJSON:(NSString*)json ;


@end