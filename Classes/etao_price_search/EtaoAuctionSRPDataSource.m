//
//  EtaoAuctionSRPDataSource.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoAuctionSRPDataSource.h"
#import "NSObject+SBJson.h"
#import "EtaoAuctionItem.h"
#import "EtaoProductItem.h"
@implementation EtaoAuctionSRPDataSource

// 子类必须实现setRequestUrl
- (void) setRequestUrl:(NSString *)url{ 
    self.url = url;
    
}

// 子类必须实现setRequestUrl
- (BOOL) parse:(NSString*)json {
    NSDictionary *jsonValue = [json JSONValue]; 
	
	if (jsonValue == nil) { 
		// error
		return NO;
	} 
    //	NSLog(@"%@",jsonValue);
	self.totalCount = [[[[jsonValue objectForKey:@"data"] objectForKey:@"result"] objectForKey:@"totalCount"] intValue] ; 
	
    if ( self.totalCount < [_items count] ) {
		return NO;
	}
   
    // 设置搜索结果
	NSMutableArray *tmparray = [NSMutableArray arrayWithCapacity:20];
	NSDictionary *products = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"productList"];
	for (NSDictionary *item in products) {
		if ([_items count] + [tmparray count] == self.totalCount ) {
 			break;
		}
		EtaoProductItem * product = [[EtaoProductItem alloc] init];
		[product setFromDictionary:item];  
		[tmparray addObject:product]; 
		[product release]; 		
	}
    
	NSDictionary *auctions = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"auctionList"];
	for (NSDictionary *item in auctions) {  
        if ( [_items count]+[tmparray count] == self.totalCount) {
 			break;
		} 
		
		if ([tmparray count] == self.pageCount ) {
 	 		break;
		} 
		
		EtaoAuctionItem * auction = [[EtaoAuctionItem alloc] init ];
		[auction setFromDictionary:item];
		[tmparray addObject:auction]; 
		[auction release]; 
	} 
         
	[_items addObjectsFromArray:tmparray];
    
    
    return YES;
}
/*
- (void) requestFinished:(ETHttpRequest *)request {
     
    NSString *json = request.jsonString; 
    if (![self parse:json]) {
        self.errorMessage = [NSString stringWithFormat:@"服务器返回错误"];
        SEL sel = @selector(ETSRPDataSourceRequestFailed:);
        if (self.delegate && [self.delegate respondsToSelector:sel]) {  
            [self.delegate performSelector:sel withObject:self ];
        } 
    } 
    else
    { 
        SEL sel = @selector(ETSRPDataSourceRequestFinished:);
        if (self.delegate && [self.delegate respondsToSelector:sel]) {  
            [self.delegate performSelector:sel withObject:self ];
        } 
    }
    
    
}
- (void) requestFailed:(ETHttpRequest *)request {
    self.errorMessage = [NSString stringWithFormat:@"网络链接错误"];
    SEL sel = @selector(ETSRPDataSourceRequestFailed:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {  
        [self.delegate performSelector:sel withObject:self ];
    } 
}
*/
@end
