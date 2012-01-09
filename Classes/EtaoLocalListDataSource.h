//
//  EtaoLocalListDataSource.h
//  etao4iphone
//
//  Created by iTeam on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EtaoLocalDiscountItem.h"


@interface EtaoLocalListDataSource : NSObject {

	NSMutableArray * _items ;
	
	int _totalCount ;
	
}

@property (nonatomic,retain) NSMutableArray * items ;
@property (nonatomic,assign) int _totalCount ;

- (id) init ;

- (NSUInteger)count ;

- (void) clear;

- (id)objectAtIndex:(NSUInteger)index;

- (void)addItemsFrom:(NSInteger)begin To:(NSInteger)end ;

- (void)addItemsByURL:(NSString*)url ;

- (void)addItemsByJSON:(NSString*)json ;

- (void)setItemsByJSON:(NSString*)json ;


@end
