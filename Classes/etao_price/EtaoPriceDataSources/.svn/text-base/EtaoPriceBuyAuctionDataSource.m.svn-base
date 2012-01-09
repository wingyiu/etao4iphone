//
//  EtaoPriceBuyAuctionDataSource.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceBuyAuctionDataSource.h"

@implementation EtaoPriceBuyAuctionDataSource
@synthesize tag = _tag;
@synthesize items = _items;
@synthesize query = _query;
@synthesize status = _status;
@synthesize settingItem = _settingItem;
@synthesize returnCount = _returnCount;
@synthesize updateNumber = _updateNumber;
@synthesize lastUpdateNumber = _lastUpdateNumber;

- (id)init{
    self = [super init];
    if(self){
        
        pageNum = 30;
        curPage = 0;
        
        _request = [[EtaoHttpRequest alloc] init];
        _request.delegate = self;
        
        _items = [[NSMutableArray alloc]init];
        
        _query = [[NSMutableDictionary alloc]init];
        [_query setObject:@"price_mtime" forKey:@"_ps"];
        [_query setObject:@"priceCutratio" forKey:@"_ss"];
        
        return self;
    }
    return nil;
}

- (id)initWithSettingItem:(EtaoPriceSettingItem*)settingItem{
    self = [self init];
    self.settingItem = settingItem;
    self.tag = _settingItem.catid;
    return self;
}

- (void)setSettingItem:(EtaoPriceSettingItem *)settingItem{
    if(_settingItem !=nil){
        [_settingItem release];
    }
    _settingItem = [settingItem retain];
    if(_settingItem.catid!=nil)[_query setObject:_settingItem.catid  forKey:@"catmap"];
    if(_settingItem.siteid!=nil)[_query setObject:_settingItem.siteid forKey:@"site_id"];
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
    if(self.status == ET_DS_PRICEBUY_AUCTION_LOADING)return;
    self.status = ET_DS_PRICEBUY_AUCTION_LOADING; //加载中
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
                     stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&type=first&v=*&data=%@",
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
                     stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&type=next&v=*&data=%@",
                     AUCTION_URL,
                     [data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
    self.status = ET_DS_PRICEBUY_AUCTION_LOADING; //加载中
}

- (void)loadUpdate{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    
    NSString* lastTime = self.lastUpdateNumber; //尝试以给入参数作为最后更新时间
    if(lastTime == nil){
        lastTime = @"0";
    } 
    
    [_query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"n"];
    [_query setObject:[NSString stringWithFormat:@"price_mtime[%@,%@]",lastTime,nowTime] forKey:@"filter"];
    
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString 
                     stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&type=update&v=*&data=%@",
                     AUCTION_URL,
                     [data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
    [_query removeObjectForKey:@"filter"];
    self.status = ET_DS_PRICEBUY_AUCTION_LOADING; //加载中
}

#pragma mark -V HttpRequest
- (void)requestFinished:(EtaoHttpRequest *)request{
    NSData* data = request.data;
    NSString* type = [self filterUrlType:request.url];
    
    if([type isEqualToString:@"update"]){
        BOOL ret = [self jsonParserUpdate:data];
        self.status = ret ? ET_DS_PRICEBUY_AUCTION_UPDATE:ET_DS_PRICEBUY_AUCTION_ERROR; //加载完成
    }
    else{
        BOOL ret = [self jsonParser:data];
        self.status = ret ? ET_DS_PRICEBUY_AUCTION_OK:ET_DS_PRICEBUY_AUCTION_ERROR; //加载完成
        if([self.returnCount intValue] < pageNum){
            self.status = ET_DS_PRICEBUY_AUCTION_NOMORE; //没有更多宝贝
        }
        //更新最后更新时间
        if(_items.count>0){
            EtaoPriceAuctionItem* item  = [_items objectAtIndex:0];
            int nTime = [item.priceMtime intValue]+1;
            self.lastUpdateNumber = [NSString stringWithFormat:@"%d",nTime];
        }
    }
}

- (void)requestFailed:(EtaoHttpRequest *)request{
    self.status = ET_DS_PRICEBUY_AUCTION_FAIL; //加载失败
}

- (void)requestProgress:(NSNumber *)progress{
    
}

#pragma mark -V Logic

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
    //self.updateNumber = [PA_result objectForKey:@"totalCount"];
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

- (BOOL)jsonParserUpdate:(NSData *)data{
    SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease]; //#autorelease
    NSDictionary* PA_dict = [jsonParser objectWithData:data]; //#autorelease
    NSArray* PA_ret = [PA_dict objectForKey:@"ret"];
    NSString* status = [PA_ret objectAtIndex:0];
    if([status hasPrefix:@"FAIL"]){
        return NO;
    }
    NSDictionary* PA_data = [PA_dict objectForKey:@"data"];
    NSDictionary* PA_result = [PA_data objectForKey:@"result"];
    self.updateNumber = [PA_result objectForKey:@"totalCount"];
    return YES;
}

- (NSString*)filterUrlType:(NSString*)url{
    NSRange range1 = [url rangeOfString:@"&type="];
    range1.length = url.length-range1.location-1;
    range1.location ++;
    
    NSRange range2 = [url rangeOfString:@"&" options:0 range:range1];
    range1.location+=5;
    range1.length = range2.location - range1.location;
    NSString* substring = [url substringWithRange:range1];
    return substring;
}

#pragma mark -V Serializing
/* 序列化接口 */
- (void)serializing:(NSString *)key{
    NSMutableDictionary* dict = [[[NSMutableDictionary alloc]init]autorelease];
    [dict setObject:_items forKey:@"items"];
    [dict setObject:_tag forKey:@"tag"];
    [dict setObject:_lastUpdateNumber forKey:@"lastUpdateNumber"];
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
    self.lastUpdateNumber = [dict objectForKey:@"lastUpdateNumber"];
    self.settingItem = [dict objectForKey:@"settingItem"];
    self.status = ET_DS_PRICEBUY_AUCTION_LOCAL; //本地状态
}

- (NSString*)className{ 
    return @"EtaoPriceBuyAuctionDataSource";
}

+ (NSString*)keyName:(NSString *)str{
    return [NSString stringWithFormat:@"pricebuy_%@",str];
}

@end
