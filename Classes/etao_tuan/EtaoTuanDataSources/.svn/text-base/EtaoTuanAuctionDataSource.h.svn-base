//
//  EtaoTuanAuctionDataSource.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EtaoHttpRequest.h"
#import "ETaoNetWorkAlert.h"
#import "EtaoTuanAuctionItem.h"
#import "EtaoTuanSettingItem.h"
#import "SBJson.h"
#import "EtaoLocalPositonSessionDelegate.h"

#ifndef AUCTION_URL
#define AUCTION_URL "http://api.waptest.taobao.com"
//#define AUCTION_URL "http://m.taobao.com"
#endif


@protocol EtaoTuanAuctionDataSourceDelegate <NSObject>

@optional
- (void)showFirstAuctions;                                        //展现第一页宝贝
- (void)showNextAuctions;                                         //展现下一页宝贝
- (void)showNoMoreAuctions;                                       //展现没有更多宝贝 或 没有宝贝
- (void)showUpdateInformation:(NSString*)updateNum;               //展现更新信息
- (void)showImageSize:(NSString*)imgUrl withSize:(CGSize)imgSize; //展现图片大小 for 瀑布流

- (void)showGPSLoading:(id)sender;                                //展现gps信息，加载中
- (void)showGPSFinished:(id)sender;                               //展现gps信息，加载完成
- (void)showGPSFailed:(id)sender;                                 //展现gps信息，但是加载失败
- (void)showCityFinished:(id)sender;
- (void)showCityFailed:(id)sender;
 
- (void)showFirstMapAuctions;                                     //展示地图宝贝
- (void)showNextMapAuctions;                                      //展示地图宝贝

- (void)autoMoveWhenSelect:(int)index;                            //关联移动

@end


@interface EtaoTuanAuctionDataSource : NSObject <EtaoHttpRequstDelegate,EtaoLocalPositonSessionDelegate>{
    id <EtaoTuanAuctionDataSourceDelegate> _delegate;
    id <EtaoTuanAuctionDataSourceDelegate> _delegateForMap;
    id <EtaoTuanAuctionDataSourceDelegate> _delegateForCity;
    id <EtaoTuanAuctionDataSourceDelegate> _delegateForDetail;
    EtaoHttpRequest* _request;
    NSMutableArray* _items;
    NSMutableDictionary* _query;
    EtaoTuanSettingItem* _settingItem;
    
    int curPage;
    int pageNum;
    NSString* _updateNum;
    
    BOOL _waitingGPS;
    
}

@property (nonatomic,retain)id <EtaoTuanAuctionDataSourceDelegate> delegate;
@property (nonatomic,retain)id <EtaoTuanAuctionDataSourceDelegate> delegateForMap;
@property (nonatomic,retain)id <EtaoTuanAuctionDataSourceDelegate> delegateForCity;
@property (nonatomic,retain)id <EtaoTuanAuctionDataSourceDelegate> delegateForDetail;
@property (nonatomic,retain) NSMutableArray* items;
@property (nonatomic,retain) NSMutableDictionary* query;
@property (nonatomic,retain) NSString *updateNum;


#pragma mark -APIs
- (id)initWithSettingItem:(EtaoTuanSettingItem*)item withCity:(NSString *)city;
- (void)setDelegate:(id<EtaoTuanAuctionDataSourceDelegate>)delegate
             andMap:(id<EtaoTuanAuctionDataSourceDelegate>)delegateForMap
            andCity:(id<EtaoTuanAuctionDataSourceDelegate>)delegateForCity;

- (void)getLocalAuctions;                     //请求本地存储的宝贝
- (void)getFirstAuctions;                     //请求第一页宝贝
- (void)getNextAuctions;                      //请求下一页宝贝
- (void)getUpdateInformation:(NSString*)time; //请求更新信息

- (void)getUserPositionName;

- (NSString*)LoadLastUpdate;                  //加载最后更新时间
- (void)SaveLastUpdate:(NSString*)time;       //保存最后更新时间

// logic function

- (BOOL)jsonParser:(NSData *)data;
- (NSString*)filterUrlType:(NSString*)url;
- (BOOL)checkGPSReady;
 
@end
