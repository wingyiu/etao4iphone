//
//  EtaoTuanAuctionDataSource.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanAuctionDataSource.h"
#import "EtaoTuanCityController.h"
#import "EtaoGroupBuyMapViewController.h"

@implementation EtaoTuanAuctionDataSource
@synthesize delegate = _delegate;
@synthesize items = _items;
@synthesize query = _query;
@synthesize delegateForMap = _delegateForMap;
@synthesize delegateForCity = _delegateForCity;
@synthesize delegateForDetail = _delegateForDetail;
@synthesize updateNum = _updateNum;
- (id)init{
    self = [super init];
    if(self){
        pageNum = 15;
        curPage = 0;
        
        _request = [[EtaoHttpRequest alloc] init];
        _request.delegate = self;
        
        _items = [[NSMutableArray alloc]init];
        _waitingGPS = NO;
        _query = [[NSMutableDictionary alloc]init];
        [_query setObject:@"renqi" forKey:@"sort"];
        [_query setObject:@"y" forKey:@"lbs"];
        return self;
    }
    return nil;
    
}

- (id)initWithSettingItem:(EtaoTuanSettingItem*)item withCity:(NSString *)city{
    self = [self init];
    _settingItem = [item retain];
    if(city!=nil && city != @"" && ![city isEqualToString:@"选择城市"])
        [_query setObject:city forKey:@"city"];
    
    [_query setObject:item.catid  forKey:@"tags"];
    [_query setObject:item.siteid forKey:@"domain"];
    return  self;
}


- (void)setDelegate:(id<EtaoTuanAuctionDataSourceDelegate>)delegate 
             andMap:(id<EtaoTuanAuctionDataSourceDelegate>)delegateForMap
             andCity:(id<EtaoTuanAuctionDataSourceDelegate>)delegateForCity
{
    

    if([delegate respondsToSelector:@selector(setDatasource:)] && [delegate respondsToSelector:@selector(setTitle:)]){
        if(self.delegate != delegate){
            if ([self.delegate respondsToSelector:@selector(stopRefresh)]){
                [self.delegate performSelector:@selector(stopRefresh) withObject:nil];
            }
        }
        [delegate performSelector:@selector(setDatasource:) withObject:self];
        [delegate performSelector:@selector(setTitle:) withObject:_settingItem.tag];
    }
    
    if([delegateForMap respondsToSelector:@selector(setDatasource:)]){
        [delegateForMap performSelector:@selector(setDatasource:) withObject:self];
    }
    
    if([delegateForCity respondsToSelector:@selector(setDatasource:)]){
        [delegateForCity performSelector:@selector(setDatasource:) withObject:self];
    }
    
    self.delegate = delegate;
    self.delegateForMap = delegateForMap;
    self.delegateForCity = delegateForCity;
}


- (void)dealloc{
    if (_request != nil) {
        _request.delegate = nil;
        [_request release];        
    }
    if (_items != nil) {
        [_items removeAllObjects];
        [_items release];
    }
    self.updateNum = nil ;
    [_settingItem release];
    [super dealloc];
}

#pragma mark -v APIs

//本地获取数据
- (void)getLocalAuctions{
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:
                         [NSString stringWithFormat:@"%@_tuan_last_item_list",_settingItem.tag]];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    [_items setArray:array]; 
    if(_delegate && [_delegate respondsToSelector:@selector(showFirstAuctions)]){
        [_delegate showFirstAuctions];
    }
}

//获取第一页数据
- (void)getFirstAuctions{
    if(!_waitingGPS && ![self checkGPSReady]){
        _waitingGPS = YES;
        return;
    }
    else{
        _waitingGPS = NO;
    }
    
    //获取gps信息
    EtaoGroupBuyMapViewController* map = (EtaoGroupBuyMapViewController*)_delegateForMap;
    CLLocationCoordinate2D coordinate = [map getUserGPS];
    NSString *latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    NSString *longtitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    if (![latitude isEqualToString:@""] && ![longtitude isEqualToString:@""]) {
        [_query setObject:latitude forKey:@"dist_y"];
        [_query setObject:longtitude forKey:@"dist_x"];
    }
    
    curPage = 0;
    [_items removeAllObjects];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];
    [_query setObject:[NSString stringWithFormat:@"%d",curPage] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"n"];
    [_query setObject:[NSString stringWithFormat:@"price_mtime[0,%@]",nowTime] forKey:@"filter"];
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.groupbuy&type=first&v=*&data=%@",AUCTION_URL,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_request load:url];
}

//获取下一页数据
- (void)getNextAuctions{
    curPage++;
    [_query setObject:[NSString stringWithFormat:@"%d",curPage*pageNum] forKey:@"s"];
    [_query setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"n"];
    NSString* data = [_query JSONRepresentation];
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.groupbuy&type=next&v=*&data=%@",AUCTION_URL,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
    NSString* url = [NSString stringWithFormat:@"%s/rest/api2.do?api=mtop.etao.search.groupbuy&type=update&v=*&data=%@",AUCTION_URL,[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
            if (_delegateForMap) {
                if ([_delegateForMap respondsToSelector:@selector(showFirstMapAuctions)]) {
                    [_delegateForMap showFirstMapAuctions];
                }
            }
            //保存宝贝信息
            NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:_items];
            [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:
             [NSString stringWithFormat:@"%@_tuan_last_item_list",_settingItem.tag]];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //保存第一个宝贝的更新时间
   /*         if(_items.count>0){
                EtaoTuanAuctionItem* item  = [_items objectAtIndex:0];
                int nTime = [item.priceMtime intValue]+1;
                NSString* lastTime = [NSString stringWithFormat:@"%d",nTime];
                [self SaveLastUpdate:lastTime];
            }*/
        }
        //请求下一页回调
        else if([type isEqualToString:@"next"]){
            if([_delegate respondsToSelector:@selector(showNextAuctions)]){
                [_delegate showNextAuctions];
            }
            if (_delegateForMap) {
                if ([_delegateForMap respondsToSelector:@selector(showNextMapAuctions)]) {
                    [_delegateForMap showNextMapAuctions];
                }
            }
            if (_delegateForDetail) {
                if ([_delegateForDetail respondsToSelector:@selector(showNextAuctions)]) {
                    [_delegateForDetail showNextAuctions];
                }
            }
        }
        //请求更新回调
        else if([type isEqualToString:@"update"]){
            if([_delegate respondsToSelector:@selector(showUpdateInformation:)]){
                [_delegate showUpdateInformation:self.updateNum];
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
#pragma mark -v GPS request delegate
- (void)positonSessionRequestDidFailed:(id)sender{
    if(_waitingGPS)[self getFirstAuctions];
    [_delegateForCity showGPSFailed:sender];
    [_delegate showGPSFailed:sender];
}

- (void)positonSessionRequestDidFinish:(id)sender{

    if(_waitingGPS)[self getFirstAuctions];
    [_delegateForCity showGPSFinished:sender];
    [_delegate showGPSFinished:sender];
}

- (void) userLocationInfoRequestDidFinish:(id)sender{
    [_delegateForCity showCityFinished:sender];
    
}
- (void) userLocationInfoRequestDidFailed:(id)sender{
    [_delegateForCity showCityFailed:sender];
}


#pragma mark -v logic functions

- (BOOL)checkGPSReady{
    //获取GPS
    EtaoTuanCityController* city = (EtaoTuanCityController*)_delegateForCity;
    EtaoGroupBuyMapViewController* map = (EtaoGroupBuyMapViewController*)_delegateForMap;
    
    if([city needGetGPS] ==YES){
        [map upDateGps];
        [_delegate showGPSLoading:nil];
        return NO;
    }
    else{
        [_delegate showGPSFinished:nil];
        CLLocationCoordinate2D coordinate = [map getUserGPS];
        NSString *latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
         NSString *longtitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        if (![latitude isEqualToString:@""] && ![longtitude isEqualToString:@""]) {
            [_query setObject:latitude forKey:@"dist_x"];
            [_query setObject:longtitude forKey:@"dist_y"];
        }
        return YES;
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
    self.updateNum = [TA_result objectForKey:@"totalCount"]; 
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
        //[item setFromDictionary:TA_auction];
        [self.items addObject:item]; 
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
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:[NSString stringWithFormat:@"%@_tuan_last_item_time",_settingItem.tag]];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
- (NSString*)LoadLastUpdate
{
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:
                         [NSString stringWithFormat:@"%@_tuan_last_item_time",_settingItem.tag]];
    NSString *strTime = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    return strTime;
}
 
@end
