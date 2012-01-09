//
//  ETSRPDataSource.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETSRPDataSource.h"
#import "EtaoAuctionItem.h"
#import "NSObject+SBJson.h"
@implementation ETSRPDataSource
@synthesize items = _items ;
@synthesize request = _request ;
@synthesize url = _url ;
@synthesize delegate = _delegate ;
@synthesize errorMessage = _errorMessage;
@synthesize content = _content ;
@synthesize totalCount = _totalCount,status ,loading,pageCount;
static ETSRPDataSource * sharedDataSource ;
 

+ (id)sharedDataSource
{
	if (!sharedDataSource) {
		@synchronized(self) {
			if (!sharedDataSource) {
				sharedDataSource = [[self alloc] init]; 
			}
		}
	}
	return sharedDataSource;
}


- (void) dealloc {
    self.url = nil ;
    if (_request != nil) {
        [_request cancel];
        [_request release];
    }
    [_items release];
    [_content release];
    self.errorMessage = nil ;
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.items = [NSMutableArray arrayWithCapacity:10];
        status = 0 ;
        loading = NO ;
        pageCount = 10 ;
        return self;
    }
    return nil ;
}

- (void) setRequestUrl:(NSString *)url{
    self.url = url ;
}

- (void) start {
    _request = [[ETHttpRequest alloc]init];
    _request.delegate = self;
    _request.secondsToCache = 60 * 5 ;
    [_request load:_url];
    loading = YES;
}


- (void) requestFinished:(ETHttpRequest *)request {
    
    NSString *json = request.jsonString; 
    self.content = json;
    loading = NO ;
     
    if (![self parse:json]) {
        self.errorMessage = [NSString stringWithFormat:@"服务器返回错误"];
        SEL sel = @selector(ETSRPDataSourceRequestFailed:);
        status = -1 ;
        if (self.delegate && [self.delegate respondsToSelector:sel]) {  
            [self.delegate performSelector:sel withObject:self ];
        } 
    } 
    else
    { 
        status = 1 ;
        SEL sel = @selector(ETSRPDataSourceRequestFinished:);
        if (self.delegate && [self.delegate respondsToSelector:sel]) {  
            [self.delegate performSelector:sel withObject:self ];
        } 
    }
    
    
}
- (void) requestFailed:(ETHttpRequest *)request {
    status = 0 ;
    self.errorMessage = [NSString stringWithFormat:@"网络链接错误"];
    SEL sel = @selector(ETSRPDataSourceRequestFailed:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {  
        [self.delegate performSelector:sel withObject:self ];
    } 
    loading = NO ;
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
    
	NSDictionary *auctions = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"auctionList"];
	for (NSDictionary *item in auctions) {  		
		EtaoAuctionItem * auction = [[EtaoAuctionItem alloc] init ];
		[auction setFromDictionary:item];  
        [_items addObject:auction];
		[auction release]; 
	}
    
    return  YES;
    
}
- (void) requestProgress:(NSNumber *)progress {
    
}

- (void)request:(ETHttpRequest *)request didReceiveData:(NSData *)data{
    
}

- (void) clear {
    return [_items removeAllObjects];
}

- (int) count{
    return [_items count];
}


@end
