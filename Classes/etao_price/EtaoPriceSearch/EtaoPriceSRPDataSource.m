//
//  EtaoPriceSRPDataSource.m
//  etao4iphone
//
//  Created by GuanYuhong on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceSRPDataSource.h"
#import "EtaoPriceAuctionItem.h"
#import "NSObject+SBJson.h"
@implementation EtaoPriceSRPDataSource


// 子类必须实现setRequestUrl
- (BOOL) parse:(NSString*)json {
    NSDictionary *jsonValue = [json JSONValue]; 
	
	if (jsonValue == nil) { 
		// error
		return NO;
	} 
     
    NSArray* PA_ret = [jsonValue objectForKey:@"ret"];
    NSString* status = [PA_ret objectAtIndex:0];
    if([status hasPrefix:@"FAIL"]){
        return NO;
    }
    NSDictionary* PA_data = [jsonValue objectForKey:@"data"];
    NSDictionary* PA_result = [PA_data objectForKey:@"result"];
    NSArray* PA_result_list = [PA_result objectForKey:@"resultList"];
    self.totalCount  = [[PA_result objectForKey:@"totalCount"]intValue];
    NSDictionary* PA_auction;
    for (PA_auction in PA_result_list){
        EtaoPriceAuctionItem* item = [[EtaoPriceAuctionItem alloc] init];
        item.catIdPath = [PA_auction objectForKey:@"catIdPath"];
        item.category = [PA_auction objectForKey:@"category"];
        item.categoryp = [PA_auction objectForKey:@"categoryp"];
        item.comUrl = [PA_auction objectForKey:@"comUrl"];
        item.epid = [PA_auction objectForKey:@"epid"];
        item.image = [PA_auction objectForKey:@"image"];
        item.link = [PA_auction objectForKey:@"link"];
        item.logo = [PA_auction objectForKey:@"logo"];
        item.lowestPrice = [PA_auction objectForKey:@"lowestPrice"];
        item.nickName = [PA_auction objectForKey:@"nickName"];
        item.nid = [PA_auction objectForKey:@"nid"];
        item.priceCutratio = [PA_auction objectForKey:@"priceCutratio"];
        item.priceHistory = [PA_auction objectForKey:@"priceHistory"];
        item.priceMtime = [PA_auction objectForKey:@"priceMtime"];
        item.priceType = [PA_auction objectForKey:@"priceType"];
        item.productPrice = [PA_auction objectForKey:@"productPrice"];
        item.sellerType = [PA_auction objectForKey:@"sellerType"];
        item.siteName = [PA_auction objectForKey:@"siteName"];
        item.smallLogo = [PA_auction objectForKey:@"smallLogo"];
        item.tagLogo = [PA_auction objectForKey:@"tagLogo"];
        item.title = [PA_auction objectForKey:@"title"];
        item.wapLink = [PA_auction objectForKey:@"wapLink"];
        [_items addObject:item];
        [item release];
    }
    return YES;
      
}

@end
