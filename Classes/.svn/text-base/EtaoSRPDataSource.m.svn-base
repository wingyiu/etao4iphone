//
//  EtaoSRPDataSource.m
//  etao4iphone
//
//  Created by guanyuhong on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoSRPDataSource.h"
#import "NSObject+SBJson.h"


@implementation EtaoSRPDataSource

@synthesize items = _items;
@synthesize _totalCount ,_catPath,_propList,_forDisplay,_searchType;
@synthesize catList = _catList;
- (id) init {
	self = [super init];
    if (self) { 
		self.items = [NSMutableArray arrayWithCapacity:20];
		self.catList = [NSMutableArray arrayWithCapacity:20];
		self._catPath = [NSMutableArray arrayWithCapacity:20];
		self._propList = [NSMutableArray arrayWithCapacity:20];
		self._forDisplay = [NSMutableArray arrayWithCapacity:20];
		self._totalCount = -1 ;
	}
    return self; 
	
}

- (NSUInteger)count {
	return [_items count];
}

- (id)objectAtIndex:(NSUInteger)index{
	return [_items objectAtIndex:index];
}

- (void)addItemsByJSON:(NSString*)json{
	NSDictionary *jsonValue = [json JSONValue]; 
	
	if (jsonValue == nil) { 
		// error
		return ;
	} 
//	NSLog(@"%@",jsonValue);
	self._totalCount = [[[[jsonValue objectForKey:@"data"] objectForKey:@"result"] objectForKey:@"totalCount"] intValue] ;
	self._searchType = [[[jsonValue objectForKey:@"data"] objectForKey:@"result"] objectForKey:@"searchType"] ;
	
    if ( self._totalCount < [_items count] ) {
		return ;
	}
	
	if ([self._searchType isEqualToString:@"detail"]) {
		self._totalCount = 1 ;
		NSDictionary *productdict = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"productDO"];
		EtaoProductItem * product = [[EtaoProductItem alloc] init];
		[product setFromDictionary:productdict]; 
		[_items addObject:product]; 
		
		[product release] ;
		return ;
		
	} 
	
	// 设置搜索结果
	NSMutableArray *tmparray = [NSMutableArray arrayWithCapacity:20];
	NSDictionary *products = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"productList"];
	for (NSDictionary *item in products) {
		if ([_items count]+[tmparray count] == self._totalCount) {
 			break;
		}
		EtaoProductItem * product = [[EtaoProductItem alloc] init];
		[product setFromDictionary:item]; 
        
		[tmparray addObject:product];
		NSLog(@"%@",[product toDictionary]);
		[product release];
		
		
		
	}  
	NSDictionary *auctions = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"auctionList"];
	for (NSDictionary *item in auctions) { 
		if ( [_items count]+[tmparray count] == self._totalCount) {
 			break;
		} 
		
		if ([tmparray count] == 10 ) {
 	 		break;
		} 
		
		EtaoAuctionItem * auction = [[EtaoAuctionItem alloc] init ];
		[auction setFromDictionary:item];
		[tmparray addObject:auction];
		NSLog(@"%@",auction);
		[auction release];
		
 
	}
	 
	[_items addObjectsFromArray:tmparray];
	// 
	NSMutableArray *catBreadCrumb = [NSMutableArray arrayWithCapacity:10];
	NSArray *catPath = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"catPath"];
	int idx = 1;
	NSString *leafCatName = @"全部分类";
	for (NSDictionary *item in catPath) { 
		EtaoCategoryItem * cat = [[EtaoCategoryItem alloc]init ] ;
		cat.count = [item objectForKey:@"count"];
		cat.name = [item objectForKey:@"name"];
		cat.key = [item objectForKey:@"key"];
		cat.catlevel = idx++;
		cat.head = NO ;
		leafCatName = cat.name;
		[catBreadCrumb addObject:cat];
		[cat release]; 
	} 
	
	if ([catBreadCrumb count] > 0 ) {
		EtaoCategoryItem * allcat = [[[EtaoCategoryItem alloc]init ]autorelease] ;
		allcat.key = @"";
		allcat.name = @"全部分类";
		allcat.count = @"0";
		allcat.catlevel = 0;
		allcat.head = YES ;
		[catBreadCrumb insertObject:allcat atIndex:0];
		NSDictionary *catBreadCrumbDict = [NSDictionary dictionaryWithObjectsAndKeys:catBreadCrumb,@"values",allcat,@"key",nil]; 
		[_catPath addObject:catBreadCrumbDict];
	}
	
	// 
	NSMutableArray *childlist = [NSMutableArray arrayWithCapacity:10];
	NSArray *catList = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"catList"];
	for (NSDictionary *item in catList) { 
		EtaoCategoryItem * cat = [[EtaoCategoryItem alloc]init ] ;
		cat.count = [item objectForKey:@"count"];
		cat.name = [item objectForKey:@"name"];
		cat.key = [item objectForKey:@"key"];
		cat.catlevel = 0;
		cat.head = NO ;
		[childlist addObject:cat];
		[cat release]; 
	} 
	if ([childlist count] > 0 ) {
		EtaoCategoryItem * allcat = [[[EtaoCategoryItem alloc]init ]autorelease] ;
		allcat.key = @"";
		allcat.name = leafCatName;
		allcat.count = @"0";
		allcat.catlevel = 0;
		allcat.head = YES ;
		[childlist insertObject:allcat atIndex:0]; 
		NSDictionary *childlistDict = [NSDictionary dictionaryWithObjectsAndKeys:childlist,@"values",allcat,@"key",nil]; 
		[_catList addObject:childlistDict];
	} 


	NSArray *propList = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"propList"];
	for (NSDictionary *item in propList) {
		NSMutableArray *vids = [NSMutableArray arrayWithCapacity:10];
		EtaoPidVidItem * pid = [[EtaoPidVidItem alloc] init];
		[pid setFromDictionary:[item objectForKey:@"key"]];
		pid.head = YES; 
		pid._select = NO;
		[vids addObject:pid];
		for (NSDictionary *vid in [item objectForKey:@"values"]) {
			EtaoPidVidItem * v = [EtaoPidVidItem alloc] ;
			v.name = [vid objectForKey:@"name"];
			v.key = [vid objectForKey:@"key"];
			v._select = NO;
			v.head = NO ;
			//[v setFromDictionary:vid];
			[vids addObject:v];
			[v release];
		}
		
		NSDictionary *pidvid = [NSDictionary dictionaryWithObjectsAndKeys:vids,@"values",pid,@"key",nil]; 
		[pid release]; 
		[_propList addObject:pidvid];
	} 
	 
	// 加上已选择的属性
 	NSArray *propSelectedList = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"propertyPath"];
	for (NSDictionary *item in propSelectedList) {
		NSLog(@"%@",item);
		EtaoPidVidItem * pid = [[EtaoPidVidItem alloc]init ] ;
		EtaoPidVidItem * vid = [[EtaoPidVidItem alloc]init ] ;
		pid.key = [item objectForKey:@"key"];
		pid.name = [item objectForKey:@"keyName"]; 
		vid.key = [item objectForKey:@"valueKey"];
		vid.name = [item objectForKey:@"valueName"];
		vid._select = YES;
		
		for ( NSDictionary *pidvid in _propList) {
			EtaoPidVidItem * k = [pidvid objectForKey:@"key"];
			if ( [ k.key isEqualToString:pid.key] ) {
				NSMutableArray *vids = (NSMutableArray *)[pidvid objectForKey:@"values"] ;
				[vids insertObject:vid atIndex:1];
				break;
			}
		} 
		[pid release];
		[vid release]; 
	}
	[_forDisplay addObjectsFromArray:_catPath];
	[_forDisplay addObjectsFromArray:_catList];
	
	if ([_catList count] == 0 ) { 
		[_forDisplay addObjectsFromArray:_propList];
	}
	
}


- (BOOL) emptyForCategory{
	return [_forDisplay count] == 0 ;
}


- (void)setItemsByJSON:(NSString*)json {
	[_items removeAllObjects];
	[self addItemsByJSON:json];
}


- (void) clear {
	[_items removeAllObjects];
	[_catList removeAllObjects];
	[self._catPath removeAllObjects];
	[self._propList removeAllObjects];
	[self._forDisplay removeAllObjects];
	self._totalCount = 0 ;
}


- (void)dealloc { 
    [_items release];
    [_catList release];
    [_catPath release];
    [_propList release];
    [_forDisplay release];
    [super dealloc];
}


@end
