//
//  EtaoTAHttpRequest.h
//  etao4iphone
//
//  Created by  on 11-11-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoHttpRequest.h"
#import "EtaoTuanAuctionItem.h"

@class EtaoTAHttpRequest;
@protocol EtaoTAHttpDelegate <NSObject>
- (void)requestFinishedSuccess;   //http请求成功，返回成功
- (void)requestFinishedFailed;    //http请求成功，返回失败
- (void)requestFinishedUpdate:(EtaoTAHttpRequest*) http;    //http请求成功，返回更新数量
- (void)requestFailed;            //http请求失败
- (void)requestTimeout;

@end


@interface EtaoTAHttpRequest : EtaoHttpRequest{
    id <EtaoTAHttpDelegate> _TA_delegate;
    NSMutableArray* _TA_item_list;
    int _curPage; //当前翻页
    int _pageNum; //一页宝贝数
    NSString* _sort;//排序方式
    NSString* _city;
    NSMutableDictionary* _query;
    
    NSString* _update_number;
}

@property (nonatomic,retain) NSMutableArray* TA_item_list;
@property (nonatomic,retain) NSMutableDictionary* query;
@property (nonatomic,assign) id <EtaoTAHttpDelegate> TA_delegate;
@property (nonatomic,assign) NSString* update_number;

- (id)init;
- (void)TA_load:(int)page;                             //指定页数
- (void)TA_first;
- (void)TA_update:(NSString*)time;
//- (void)TA_Just_update:(NSString*)time;
- (void)TA_next;
- (void)TA_requestFinished:(EtaoHttpRequest*)sender;
- (void)TA_requestFailed:(EtaoHttpRequest*)sender;
- (BOOL)jsonParser:(NSData*)data;

- (NSString*)LoadLastUpdate;
- (void)SaveLastUpdate:(NSString*)time;

@end