//
//  EtaoGroupBuyAuctionDataSource.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoGroupBuyAuctionDataSource.h"

@implementation EtaoGroupBuyAuctionDataSource
@synthesize tag = _tag;
@synthesize items = _items;
@synthesize query = _query;
@synthesize status = _status;
@synthesize settingItem = _settingItem;
@synthesize returnCount = _returnCount;

- (id)init{
    self = [super init];
    if(self){
        
        pageNum = 30;
        curPage = 0;

        _request = [[EtaoHttpRequest alloc] init];
        _request.delegate = self;
        
        _items = [[NSMutableArray alloc]init];
        
        _query = [[NSMutableDictionary alloc]init];
        [_query setObject:@"renqi" forKey:@"sort"];
        
        return self;
    }
    return nil;
}

- (id)initWithSettingItem:(EtaoTuanSettingItem*)settingItem{
    self = [self init];
    self.settingItem = settingItem;
    self.tag = _settingItem.tag;
    return self;
}

- (void)setSettingItem:(EtaoTuanSettingItem *)settingItem{
    if(_settingItem !=nil){
        [_settingItem release];
    }
    _settingItem = [settingItem retain];
    [_query setObject:_settingItem.catid forKey:@"tags"];
    [_query setObject:_settingItem.siteid forKey:@"domain"];
}

- (void)dealloc{
    [_request release];
    [_query release];
    [_items release];
    [_tag release];
    [_settingItem release];
    [super dealloc];
}

#pragma mark -V APIs
- (void)reload{
    if(self.status == ET_DS_GROUPBUY_AUCTION_LOADING)return;
    self.status = ET_DS_GROUPBUY_AUCTION_LOADING; //加载中
    curPage = 0;
    [_items removeAllObjects];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    [_query setObject:[NSString stringWithFormat:@"%d",curPage] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"n"];
    [_query setObject:[NSString stringWithFormat:@"price_mtime[0,%@]",nowTime] forKey:@"filter"];
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString 
                     stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.groupbuy&type=first&v=*&data=%@",
                     AUCTION_URL,
                     [data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
    
}

- (void)loadmore{
    curPage++;
    [_query setObject:[NSString stringWithFormat:@"%d",curPage*pageNum] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"n"];
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString 
                     stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.groupbuy&type=next&v=*&data=%@",
                     AUCTION_URL,
                     [data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
    self.status = ET_DS_GROUPBUY_AUCTION_LOADING; //加载中
}

#pragma mark -V HttpRequest
- (void)requestFinished:(EtaoHttpRequest *)request{
    NSData* data = request.data;
    BOOL ret = [self jsonParser:data];
    self.status = ret ? ET_DS_GROUPBUY_AUCTION_OK:ET_DS_GROUPBUY_AUCTION_ERROR; //加载完成
    if([self.returnCount intValue] < pageNum){
        self.status = ET_DS_GROUPBUY_AUCTION_NOMORE; //没有更多宝贝
    }
}

- (void)requestFailed:(EtaoHttpRequest *)request{
    self.status = ET_DS_GROUPBUY_AUCTION_FAIL; //加载失败
}

- (void)requestProgress:(NSNumber *)progress{
    
}

#pragma mark -V Logic

- (BOOL)jsonParser:(NSData *)data
{
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease]; //#autorelease
    NSDictionary* TA_dict = [jsonParser objectWithData:data]; //#autorelease
    NSArray* TA_ret = [TA_dict objectForKey:@"ret"];
    NSString* stat = [TA_ret objectAtIndex:0];
    if([stat hasPrefix:@"FAIL"]){
        return NO;
    }
    NSDictionary* TA_data = [TA_dict objectForKey:@"data"];
    NSDictionary* TA_result = [TA_data objectForKey:@"result"];
    NSArray* TA_result_list = [TA_result objectForKey:@"resultList"];
    self.returnCount = [TA_result objectForKey:@"returnCount"]; 
    for (NSDictionary* TA_auction in TA_result_list){
        EtaoTuanAuctionItem* item = [[EtaoTuanAuctionItem alloc] init]; 
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
        item.type = [TA_auction objectForKey:@"type"];
        item.startTime = [TA_auction objectForKey:@"startTime"];
        item.endTime = [TA_auction objectForKey:@"endTime"];
        item.nid = [TA_auction objectForKey:@"nid"]; 
        [self.items addObject:item]; 
        [item release];
    }
    return YES;
}

#pragma mark -V Serializing
/* 序列化接口 */
- (void)serializing:(NSString *)key{
    NSMutableDictionary* dict = [[[NSMutableDictionary alloc]init]autorelease];
    [dict setObject:_items forKey:@"items"];
    [dict setObject:_tag forKey:@"tag"];
    [dict setObject:_settingItem forKey:@"settingItem"];
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)deserializing:(NSString *)key{
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSMutableDictionary* dict = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    [_items setArray:[dict objectForKey:@"items"]];
    self.tag = [dict objectForKey:@"tag"];
    self.settingItem = [dict objectForKey:@"settingItem"];
    self.status = ET_DS_GROUPBUY_AUCTION_LOCAL; //本地状态
}

- (NSString*)className{ 
    return @"EtaoGroupBuyAuctionDataSource";
}

+ (NSString*)keyName:(NSString *)str{
    return [NSString stringWithFormat:@"groupbuy_%@",str];
}

@end
