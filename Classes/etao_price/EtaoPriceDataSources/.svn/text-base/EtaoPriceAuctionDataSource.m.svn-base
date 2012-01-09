//
//  EtaoPriceAuctionDataSource.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceAuctionDataSource.h"

@implementation EtaoPriceAuctionDataSource
@synthesize delegate = _delegate;
@synthesize delegateForDetail = _delegateForDetail;
@synthesize items = _items;
@synthesize query = _query;
@synthesize updateNum = _updateNum;


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

- (id)initWithSettingItem:(EtaoPriceSettingItem*)item{
    self = [self init];
    _settingItem = [item retain];
    if(item.catid!=nil)[_query setObject:item.catid  forKey:@"catmap"];
    if(item.siteid!=nil)[_query setObject:item.siteid forKey:@"site_id"];
    return  self;
}

- (void)dealloc{
    [_request release];
    [_items release];
    [_settingItem release];
    self.delegate = nil;
    self.query = nil;
    self.updateNum = nil ;
    [super dealloc];
}

#pragma mark -v APIs

//本地获取数据
- (void)getLocalAuctions{
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:
                         [NSString stringWithFormat:@"%@_price_last_item_list",_settingItem.tag]];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    [_items setArray:array]; 
    if(_delegate && [_delegate respondsToSelector:@selector(showFirstAuctions)]){
        [_delegate showFirstAuctions];
    }
}

//获取第一页数据
- (void)getFirstAuctions{
    curPage = 0;
    [_items removeAllObjects];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    [_query setObject:[NSString stringWithFormat:@"%d",curPage] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"n"];
    [_query setObject:[NSString stringWithFormat:@"price_mtime[0,%@]",nowTime] forKey:@"filter"];
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&type=first&v=*&data=%@",AUCTION_URL,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
}

//获取下一页数据
- (void)getNextAuctions{
    curPage++;
    [_query setObject:[NSString stringWithFormat:@"%d",curPage*pageNum] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"n"];
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&type=next&v=*&data=%@",AUCTION_URL,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
}


//获取更新信息
- (void)getUpdateInformation:(NSString*)time{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    
    NSString* lastTime = time; //尝试以给入参数作为最后更新时间
    if(lastTime == nil){
        lastTime = [self LoadLastUpdate]; //读取本地保存的最后更新时间
        if(lastTime == nil){
            lastTime = @"0";
        }
    } 

    [_query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",0] forKey:@"n"];
    [_query setObject:[NSString stringWithFormat:@"price_mtime[%@,%@]",lastTime,nowTime] forKey:@"filter"];
    
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.cutprice&type=update&v=*&data=%@",AUCTION_URL,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
    [_query removeObjectForKey:@"filter"];
}

#pragma mark -v http request delegate
- (void)requestFinished:(EtaoHttpRequest *)request{
    
    NSData* data = request.data;
    BOOL ret = [self jsonParser:data];
    
    if(_delegate){
        NSString* type = [self filterUrlType:request.url];
        //服务器返回失败
        if(!ret){
            if([_delegate respondsToSelector:@selector(showNoMoreAuctions)]){
                [_delegate showNoMoreAuctions];
            }
        }
        //请求第一页回调
        else if([type isEqualToString:@"first"]){
            if([_delegate respondsToSelector:@selector(showFirstAuctions)]){
                [_delegate showFirstAuctions];
            }
            //保存宝贝信息
            NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:_items];
            [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:
             [NSString stringWithFormat:@"%@_price_last_item_list",_settingItem.tag]];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //保存第一个宝贝的更新时间
            if(_items.count>0){
                EtaoPriceAuctionItem* item  = [_items objectAtIndex:0];
                int nTime = [item.priceMtime intValue]+1;
                NSString* lastTime = [NSString stringWithFormat:@"%d",nTime];
                [self SaveLastUpdate:lastTime];
            }
        }
        //请求下一页回调
        else if([type isEqualToString:@"next"]){
            if([_delegate respondsToSelector:@selector(showNextAuctions)]){
                [_delegate showNextAuctions];
            }
            //add by zhangsuntai
            if (_delegateForDetail) {
                if ([_delegateForDetail respondsToSelector:@selector(showNextAuctions)]) {
                    [_delegateForDetail showNextAuctions];
                }
            }
        }
        //请求更新回调
        else if([type isEqualToString:@"update"]){
            if([_delegate respondsToSelector:@selector(showUpdateInformation:)]){
                [_delegate showUpdateInformation:_updateNum];
            }
        }
    }
}

- (void)requestFailed:(EtaoHttpRequest *)request{
    [[ETaoNetWorkAlert alert]show];
    if([_delegate respondsToSelector:@selector(showNoMoreAuctions)]){
        [_delegate showNoMoreAuctions];
    }
}


#pragma mark -v logic functions

- (BOOL)jsonParser:(NSData *)data{
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
    self.updateNum = [PA_result objectForKey:@"totalCount"];
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

- (void)SaveLastUpdate:(NSString *)time
{
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:time];
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:[NSString stringWithFormat:@"%@_price_last_item_time",_settingItem.tag]];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
- (NSString*)LoadLastUpdate
{
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:
                         [NSString stringWithFormat:@"%@_price_last_item_time",_settingItem.tag]];
    NSString *strTime = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    return strTime;
}


@end
