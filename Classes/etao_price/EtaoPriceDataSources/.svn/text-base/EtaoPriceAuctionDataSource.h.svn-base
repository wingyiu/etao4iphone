//
//  EtaoPriceAuctionDataSource.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EtaoHttpRequest.h"
#import "ETaoNetWorkAlert.h"
#import "EtaoPriceAuctionItem.h"
#import "EtaoPriceSettingItem.h"

@protocol EtaoPriceAuctionDataSourceDelegate <NSObject>

@optional
- (void)showFirstAuctions;                                        //展现第一页宝贝
- (void)showNextAuctions;                                         //展现下一页宝贝
- (void)showNoMoreAuctions;                                       //展现没有更多宝贝 或 没有宝贝
- (void)showUpdateInformation:(NSString*)updateNum;               //展现更新信息
- (void)showImageSize:(NSString*)imgUrl withSize:(CGSize)imgSize; //展现图片大小 for 瀑布流

@end


@interface EtaoPriceAuctionDataSource : NSObject <EtaoHttpRequstDelegate>{
    id <EtaoPriceAuctionDataSourceDelegate> _delegate;
    id <EtaoPriceAuctionDataSourceDelegate> _delegateForDetail;
    EtaoHttpRequest* _request;
    NSMutableArray* _items;
    NSMutableDictionary* _query;
    EtaoPriceSettingItem* _settingItem;
    
    int curPage;
    int pageNum;
    NSString* _updateNum;
    
}
@property (nonatomic,retain)id <EtaoPriceAuctionDataSourceDelegate> delegate;
@property (nonatomic,assign)id <EtaoPriceAuctionDataSourceDelegate> delegateForDetail;
@property (nonatomic,retain) NSMutableArray* items;
@property (nonatomic,retain) NSMutableDictionary* query;
@property (nonatomic,retain) NSString *updateNum;

#pragma mark -APIs
- (id)initWithSettingItem:(EtaoPriceSettingItem*)item;

- (void)getLocalAuctions;                     //请求本地存储的宝贝
- (void)getFirstAuctions;                     //请求第一页宝贝
- (void)getNextAuctions;                      //请求下一页宝贝
- (void)getUpdateInformation:(NSString*)time; //请求更新信息

- (NSString*)LoadLastUpdate;                  //加载最后更新时间
- (void)SaveLastUpdate:(NSString*)time;       //保存最后更新时间

// logic function
- (BOOL)jsonParser:(NSData *)data;
- (NSString*)filterUrlType:(NSString*)url;

@end
