//
//  EtaoLocalListDataSource.m
//  etao4iphone
//
//  Created by iTeam on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalListDataSource.h"
#import "NSObject+SBJson.h"


@implementation EtaoLocalListDataSource

@synthesize items = _items ;
@synthesize _totalCount;

- (id) init {
	self = [super init];
    if (self) { 
		self.items = [NSMutableArray arrayWithCapacity:20];
		_totalCount = -1 ;
	}
    return self; 
	
}
- (void) clear{
	[_items removeAllObjects];
	_totalCount = 0 ;
}


-(void) dealloc{
    [_items release];
    [super dealloc];
}

- (NSUInteger)count {
	return [_items count];
}

- (id)objectAtIndex:(NSUInteger)index{
	return [_items objectAtIndex:index];
}

- (void)addItemsFrom:(NSInteger)begin To:(NSInteger)end {
	for (int i = begin; i < end; i++) {
		EtaoLocalDiscountItem * item = [EtaoLocalDiscountItem alloc] ;
		
		item.itemTitle = [NSString stringWithFormat:@"[%d]\t上海3店通用】仅8.8元！原价20元冰期时代双球冰激凌1份！总限20000份！",i]; 
		item.itemID =  @"978828"; 
		item.itemURL = @"http://www.24quan.com/exchange/PostTuan800UserInfo.html?url=http%3A%2F%2Fwww.24quan.com%2Fteam%2F31590.html";
		item.itemImageURL = @"http://s5.tuanimg.com/deal/deal_image/0097/8828/normal/0db11a9e-1851-4112-8129-20558a57765e.jpg";
		item.itemType =  @"1";
		item.itemRank =  @"2";
		item.itemDiscount =  @"4.4";
		item.itemOriginalPrice =  @"20.0";
		item.itemPresentPrice =  @"8.8";
		item.itemComeFrom =  @"24券";
		item.shopName =  @"冰期时代(迪美店)";
		item.shopDistance =  @"0.18";
		item.shopAddress =  @"人民大道221号迪美购物中心内(近武胜路)";
		item.shopTelephone =  @"021-63582425";
		item.locationLatitude =  @"31.228756";
		item.locationLongitude =  @"121.473434";  
		

		
		[_items addObject:item];
		[item release];
	} 
}

- (void)addItemsByURL:(NSString*)url{
	
	
}

- (void)addItemsByJSON:(NSString*)json{
	NSDictionary *jsonValue = [json JSONValue]; 
	_totalCount = [[jsonValue objectForKey:@"totalResults"] intValue] ;
	if (jsonValue != nil) {
		NSArray *itemarray = [jsonValue objectForKey:@"itemsArray"];
		for (NSDictionary *item in itemarray) {
			EtaoLocalDiscountItem * discount = [EtaoLocalDiscountItem alloc] ;
			[discount setFromDictionary:item];
			[_items addObject:discount];
			[discount release];
			NSLog(@"%@",discount.itemTitle);
		} 	
	}

}

- (void)setItemsByJSON:(NSString*)json {
	[_items removeAllObjects];
	_totalCount = 0 ;
	[self addItemsByJSON:json];
}
@end
