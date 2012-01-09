//
//  EtaoPAHttpRequest.m
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPAHttpRequest.h"

@implementation EtaoPAHttpRequest
@synthesize PA_item_list;
@synthesize PA_delegate;
@synthesize query;
@synthesize gmt_update;
@synthesize update_number;
@synthesize request = _request;

- (id)init
{
    self = [super init];
    if (self) {
        pageNum = 30;
        curPage = 0;
        
        _request = [[EtaoHttpRequest alloc]init];
        _request.delegate = self;
        _request.requestDidFailedSelector = @selector(PA_requestFailed:);
        _request.requestDidFinishSelector = @selector(PA_requestFinished:);
        PA_item_list = [[NSMutableArray alloc]init];
        query = [[NSMutableDictionary alloc]init];
        [self.query setObject:@"price_mtime" forKey:@"_ps"];
        [self.query setObject:@"priceCutratio" forKey:@"_ss"];
        
        _test = 0;
        return self;
    }
    return nil;
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
     _request.delegate = nil ;
    [_request release];
    PA_delegate = nil;
    [PA_item_list release];
    [query release];
    [super dealloc];
}

//翻页，自定义
- (void)PA_load:(int)page
{
    [self.query setObject:[NSString stringWithFormat:@"%d",page*pageNum] forKey:@"s"];
    [self.query setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"n"];
    NSString* data = [self.query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&v=*&data=%@",HOST,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url=%@",url);
    [_request load:url];
}

//翻页，第一页
- (void)PA_first
{
    curPage = 0;
    [PA_item_list removeAllObjects];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    
    [self.query setObject:[NSString stringWithFormat:@"first",0] forKey:@"type"];
    [self.query setObject:[NSString stringWithFormat:@"%d",curPage] forKey:@"s"];
    [self.query setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"n"];
    [self.query setObject:[NSString stringWithFormat:@"price_mtime[0,%@]",nowTime] forKey:@"filter"];

    NSString* data = [self.query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&v=*&data=%@",HOST,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
    

}

// 获取更新数据
- (void)PA_update:(NSString*)time
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    
    NSString* lastTime = time;
    if(lastTime == nil){
        lastTime = @"0";
    } 
    
    [self SaveLastUpdate:nowTime];
    NSLog(@"lastTime=%@,NowTime=%@",lastTime,nowTime);
    [self.query setObject:[NSString stringWithFormat:@"update",0] forKey:@"type"];
    [self.query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"s"];
    [self.query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"n"];
    [self.query setObject:[NSString stringWithFormat:@"price_mtime[%@,%@]",lastTime,nowTime] forKey:@"filter"];
 
    NSString* data = [self.query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&v=*&data=%@",HOST,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
    NSLog(@"%@",url);
    [self.query removeObjectForKey:@"filter"];
    
}

// 获取更新数据
- (void)PA_Just_update:(NSString*)time
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    NSString* lastTime = time ; 
     
    NSLog(@"lastTime=%@,NowTime=%@",lastTime,nowTime);
    [self.query setObject:[NSString stringWithFormat:@"update",0] forKey:@"type"];
    [self.query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"s"];
    [self.query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"n"];
    [self.query setObject:[NSString stringWithFormat:@"price_mtime[%@,%@]",lastTime,nowTime] forKey:@"filter"];
    
    NSString* data = [self.query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&v=*&data=%@",HOST,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url]; 
    
    [self.query removeObjectForKey:@"filter"];
    
}

//翻页，后一页
- (void)PA_next
{
    curPage++;
    [self.query setObject:[NSString stringWithFormat:@"next",0] forKey:@"type"];
    [self.query setObject:[NSString stringWithFormat:@"%d",curPage*pageNum] forKey:@"s"];
    [self.query setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"n"];
    NSString* data = [self.query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&v=*&data=%@",HOST,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
}

- (void)PA_requestFinished:(EtaoHttpRequest*)sender
{
    NSLog(@"%@",sender.url);
    NSData* data = sender.data;

    BOOL ret = [self jsonParser:data];
    if (PA_delegate) {
        if(ret){
            if([_request.url rangeOfString:@"update"].location != NSNotFound){ 
                
                SEL sel = @selector(requestFinishedUpdate:);
                if (self.PA_delegate && sel && [self.PA_delegate respondsToSelector:sel]) {  
                    [PA_delegate requestFinishedUpdate:self];
                }
                
            }
            else if([_request.url rangeOfString:@"first"].location != NSNotFound){
                SEL sel = @selector(requestFinishedSuccess);
                if (self.PA_delegate && sel && [self.PA_delegate respondsToSelector:sel]) {  
                    [PA_delegate requestFinishedSuccess];
                }
            }
            else if([_request.url rangeOfString:@"next"].location != NSNotFound){
                SEL sel = @selector(requestFinishedSuccess);
                if (self.PA_delegate && sel && [self.PA_delegate respondsToSelector:sel]) {  
                    [PA_delegate requestFinishedSuccess];
                }
            }
        }
        else
        {
            SEL sel = @selector(requestFinishedFailed);
            if (self.PA_delegate && sel && [self.PA_delegate respondsToSelector:sel]) {  
                [PA_delegate requestFinishedFailed];
            }
        }
            
    }
}

- (void)PA_requestFailed:(EtaoHttpRequest*)sender
{
    if(PA_delegate){
        [PA_delegate requestFailed];
    }
}

- (BOOL)jsonParser:(NSData *)data
{
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease]; //#autorelease
    NSDictionary* PA_dict = [jsonParser objectWithData:data]; //#autorelease
    NSArray* PA_ret = [PA_dict objectForKey:@"ret"];
    NSString* status = [PA_ret objectAtIndex:0];
    if([status hasPrefix:@"FAIL"]){
        return NO;
    }
    NSDictionary* PA_data = [PA_dict objectForKey:@"data"];
    NSDictionary* PA_result = [PA_data objectForKey:@"result"];
    NSArray* PA_result_list = [PA_result objectForKey:@"resultList"];
    update_number = [PA_result objectForKey:@"totalCount"];
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
        [self.PA_item_list addObject:item];
        [item release];
    }
    return YES;
}

- (void)SaveLastUpdate:(NSString *)time
{
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:time];
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:@"last_update_time"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (NSString*)LoadLastUpdate
{
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:@"last_update_time"];
    NSString *strTime = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    return strTime;
}


@end
