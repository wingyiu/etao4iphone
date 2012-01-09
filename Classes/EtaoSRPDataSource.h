//
//  EtaoSRPDataSource.h
//  etao4iphone
//
//  Created by guanyuhong on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EtaoAuctionItem.h"
#import "EtaoProductItem.h"

@interface EtaoSRPDataSource : NSObject {

	// 存储搜索宝贝或者产品结果
	NSMutableArray * _items ;
	
	// 子类目
	NSMutableArray * _catList ;
	
	// 类目路径，面包屑
	NSMutableArray * _catPath ;
	
	// 属性筛选
	NSMutableArray * _propList ;
	
	NSMutableArray * _forDisplay ;	
	
	NSString *_searchType;
	
	int _totalCount ;
}

@property (nonatomic,retain) NSMutableArray * items ;
@property (nonatomic,retain) NSMutableArray * catList ;
@property (nonatomic,retain) NSMutableArray * _catPath ;
@property (nonatomic,retain) NSMutableArray * _propList ;
@property (nonatomic,retain) NSMutableArray * _forDisplay ;
@property (nonatomic,assign) int _totalCount ;
@property (nonatomic,assign) NSString *_searchType;

- (id) init ;

- (NSUInteger)count ;

- (BOOL) emptyForCategory;

- (id)objectAtIndex:(NSUInteger)index;
 
- (void) clear ;

- (void)addItemsByJSON:(NSString*)json ;

- (void)setItemsByJSON:(NSString*)json ;


@end
