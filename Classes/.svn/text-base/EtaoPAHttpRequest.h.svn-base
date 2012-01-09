//
//  EtaoPAHttpRequest.h
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoHttpRequest.h"
#import "EtaoPriceAuctionItem.h"

//#define HOST "http://api.waptest.taobao.com"
#define HOST "http://m.taobao.com"

@class EtaoPAHttpRequest;
@protocol EtaoPAHttpDelegate <NSObject>
- (void)requestFinishedSuccess;   //http请求成功，返回成功
- (void)requestFinishedFailed;    //http请求成功，返回失败
- (void)requestFinishedUpdate:(EtaoPAHttpRequest*) http;    //http请求成功，返回更新数量
- (void)requestFailed;            //http请求失败
- (void)requestTimeout;           //http请求超时
 
@end


@interface EtaoPAHttpRequest : NSObject{
    EtaoHttpRequest* _request;
    id <EtaoPAHttpDelegate> PA_delegate;
    NSMutableArray* PA_item_list;
    int curPage; //当前翻页
    int pageNum; //一页宝贝数
    NSMutableDictionary* query;
    
    NSString* gmt_update;
    NSString* update_number;
    
    int _test;
}

@property (nonatomic,assign) NSMutableArray* PA_item_list;
@property (nonatomic,assign) NSMutableDictionary* query;
@property (nonatomic,assign) id <EtaoPAHttpDelegate> PA_delegate;
@property (nonatomic,assign) NSString* gmt_update;
@property (nonatomic,retain) NSString* update_number;
@property (nonatomic,retain) EtaoHttpRequest* request;

- (id)init;
- (void)PA_load:(int)page;                             //指定页数
- (void)PA_first;
- (void)PA_update:(NSString*)time;
- (void)PA_Just_update:(NSString*)time;
- (void)PA_next;
- (void)PA_requestFinished:(EtaoHttpRequest*)sender;
- (void)PA_requestFailed:(EtaoHttpRequest*)sender;
- (BOOL)jsonParser:(NSData*)data;

- (NSString*)LoadLastUpdate;
- (void)SaveLastUpdate:(NSString*)time;

@end
