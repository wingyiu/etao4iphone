//
//  EtaoTAHttpRequest.m
//  etao4iphone
//
//  Created by  on 11-11-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTAHttpRequest.h"
#import "ETaoTuanAuctionItem.h"
#import "SBJsonParser.h"
#import "NSObject+SBJson.h"

@implementation EtaoTAHttpRequest
@synthesize TA_item_list = _TA_item_list;
@synthesize TA_delegate = _TA_delegate;
@synthesize query = _query;
@synthesize update_number = _update_number;

- (id)init
{
    self = [super init];
    if (self) {
        _pageNum = 30;
        _curPage = 0;
        _sort = @"renqi";
        
        super.delegate = self;
        super.requestDidFailedSelector = @selector(TA_requestFailed:);
        super.requestDidFinishSelector = @selector(TA_requestFinished:);
        self.TA_item_list = [[[NSMutableArray alloc]init]autorelease];
        self.query = [[[NSMutableDictionary alloc]init]autorelease];
        return self;
    }
    return nil;
}

- (void)dealloc
{
    if (_TA_delegate != nil) {
        _TA_delegate = nil;
    }
    if (_TA_item_list != nil) {
        [_TA_item_list removeAllObjects];
        [_TA_item_list release];
        _TA_item_list = nil;
    }
    if (_query != nil) {
        [_query removeAllObjects];
        [_query release];
        _query = nil;
    }
    [_update_number release];
    
    [super dealloc];
}

//翻页，自定义
/*
- (void)TA_load:(int)page
{
    [_query setObject:[NSString stringWithFormat:@"%d",page*_pageNum] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",_pageNum] forKey:@"n"];
    NSString* data = [_query JSONRepresentation];
    //http://api.waptest.taobao.com/rest/api2.do?api=mtop.etao.search.groupbuy&v=*&data={"s":"0","n":"10","sort":"renqi"};
    NSString* url = [NSString stringWithFormat:@"http://m.taobao.com/rest/api2.do?api=mtop.etao.search.cutprice&v=*&data=%@",[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url=%@",url);
    [self load:url];
}
*/
//翻页，第一页
- (void)TA_first
{
    _curPage = 0;
    [_TA_item_list removeAllObjects];
    [_query setObject:[NSString stringWithFormat:@"%d",_curPage] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",_pageNum] forKey:@"n"];
    [_query setObject:[NSString stringWithFormat:@"%@",_sort] forKey:@"sort"];
    
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"http://api.waptest.taobao.com/rest/api2.do?api=mtop.etao.search.groupbuy&v=*&data=%@",[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self load:url];
}

// 获取更新数据
- (void)TA_update:(NSString*)time
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    NSString* lastTime = (time == nil? @"0":[self LoadLastUpdate]);
    if(lastTime == nil){
        lastTime = @"0";
    } 
    
    [self SaveLastUpdate:nowTime];
    
    NSLog(@"lastTime=%@,NowTime=%@",lastTime,nowTime);
    [_query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"n"];
    [_query setObject:[NSString stringWithFormat:@"price_mtime[%@,%@]",lastTime,nowTime] forKey:@"filter"];
    
    NSString* data = [self.query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"http://api.waptest.taobao.com/rest/api2.do?api=mtop.etao.search.groupbuy&v=*&data=%@",[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self load:url];
    NSLog(@"%@",url);
    [_query removeObjectForKey:@"filter"];
    
}

// 获取更新数据
/*- (void)TA_Just_update:(NSString*)time
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    NSString* lastTime = time ; 
    
    NSLog(@"lastTime=%@,NowTime=%@",lastTime,nowTime);
    [_query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"n"];
    [_query setObject:[NSString stringWithFormat:@"price_mtime[%@,%@]",lastTime,nowTime] forKey:@"filter"];
    
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"http://m.taobao.com/rest/api2.do?api=mtop.etao.search.cutprice&v=*&data=%@",[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self load:url]; 
    
    [_query removeObjectForKey:@"filter"];
    
}*/

//翻页，后一页
- (void)TA_next
{
    _curPage++;
    [_query setObject:[NSString stringWithFormat:@"%d",_curPage*_pageNum] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",_pageNum] forKey:@"n"];
    [_query setObject:[NSString stringWithFormat:@"%@",_sort] forKey:@"sort"];
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"http://api.waptest.taobao.com/rest/api2.do?api=mtop.etao.search.groupbuy&v=*&data=%@",[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self load:url];
}

- (void)TA_requestFinished:(EtaoHttpRequest*)sender
{
    NSLog(@"%@",sender.url);
    NSData* data = sender.data;
    
    BOOL ret = [self jsonParser:data];
    if (_TA_delegate) {
        if(ret){
            if([self.url rangeOfString:@"filter"].location != NSNotFound){ 
                
                SEL sel = @selector(requestFinishedUpdate:);
                if (_TA_delegate && sel && [_TA_delegate respondsToSelector:sel]) {  
                    
                    [_TA_delegate requestFinishedUpdate:self];
                }
                
            }
            else{
                [_TA_delegate requestFinishedSuccess];
            }
        }
        else
            [_TA_delegate requestFinishedFailed];
    }
}

- (void)TA_requestFailed:(EtaoHttpRequest*)sender
{
    if(_TA_delegate){
        [_TA_delegate requestFailed];
    }
}

- (BOOL)jsonParser:(NSData *)data
{
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease]; //#autorelease
    NSDictionary* TA_dict = [jsonParser objectWithData:data]; //#autorelease
    NSArray* TA_ret = [TA_dict objectForKey:@"ret"];
    NSString* status = [TA_ret objectAtIndex:0];
    if([status hasPrefix:@"FAIL"]){
        return NO;
    }
    NSDictionary* TA_data = [TA_dict objectForKey:@"data"];
    NSDictionary* TA_result = [TA_data objectForKey:@"result"];
    NSArray* TA_result_list = [TA_result objectForKey:@"resultList"];
    self.update_number = [TA_result objectForKey:@"totalCount"];
    NSDictionary* TA_auction;
    for (TA_auction in TA_result_list){
        ETaoTuanAuctionItem* item = [[ETaoTuanAuctionItem alloc] init];
        item.oriPrice = [TA_auction objectForKey:@"oriPrice"];
        item.price = [TA_auction objectForKey:@"price"];
        item.rate = [TA_auction objectForKey:@"rate"];
        item.webName = [TA_auction objectForKey:@"webName"];
        item.sales = [TA_auction objectForKey:@"sales"];
        item.image = [TA_auction objectForKey:@"image"];
        item.link = [TA_auction objectForKey:@"link"];
        item.title = [TA_auction objectForKey:@"title"];
        item.merchantName = [TA_auction objectForKey:@"merchantName"];
        item.merchantTel = [TA_auction objectForKey:@"merchantTel"];
        item.merchantAddr = [TA_auction objectForKey:@"merchantAddr"];
        item.latitude = [TA_auction objectForKey:@"latitude"];
        item.longitude = [TA_auction objectForKey:@"longitude"];
        item.hasLbs = [TA_auction objectForKey:@"hasLbs"];
        item.extInfo = [TA_auction objectForKey:@"extInfo"];
        item.wapLink = [TA_auction objectForKey:@"wapLink"];
        
        item.nid = [TA_auction objectForKey:@"nid"];
        
        [self.TA_item_list addObject:item];
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
