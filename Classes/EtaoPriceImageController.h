//
//  EtaoPriceImageController.h
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoPAHttpRequest.h"
#import "HTTPImageView.h"
#import "ASINetworkQueue.h"
#import "ETaoUITableViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableTailerView.h"
#import "EtaoPriceDetailController.h"

#ifndef DISPLAY_IMAGE
#define DISPLAY_IMAGE
#define DISPLAY_IMAGE_COUNT_EACH_ROW 3
#define DISPLAY_IMAGE_BORDER 1.0f
#define DISPLAY_IMAGE_WIDTH 94.0f
#define DISPLAY_IMAGE_GAP 8.0f
#endif

#ifndef HTTP_IMAGE_VIEW_TOUCH_CONTROLLER
#define HTTP_IMAGE_VIEW_TOUCH_CONTROLLER
@interface HttpimageViewTouchController:UIView
{
    EtaoPriceAuctionItem* _item;
    HTTPImageView* _imgView;
}
@property(nonatomic,retain) EtaoPriceAuctionItem* item;
@property(nonatomic,retain) HTTPImageView* imgView;
@end
#endif

@interface EtaoPriceImageController : ETaoUITableViewController 
<EtaoPAHttpDelegate,EGORefreshTableHeaderDelegate,EGORefreshTableTailerDelegate> 
{
    UInt32 _num_of_col;                //每一列显示的个数
    UInt32 _pix_of_height;             //高度
    UInt32 _pix_of_width;              //宽度
    
    BOOL _header_reloading;
    BOOL _tailer_reloading;
    NSMutableArray* _PA_item_list;
    EtaoPAHttpRequest* _request;
    EGORefreshTableHeaderView* _refreshHeaderView; //View 下拉刷新
    EGORefreshTableTailerView* _refreshTailerView; //View 上拉更新
    
    ASINetworkQueue *_netQueue ;
    
    NSMutableDictionary *_imagecache ;
    
}

@property(nonatomic,retain)  EtaoPAHttpRequest* request;
@property(nonatomic,retain)  ASINetworkQueue *netQueue ;
@property(nonatomic,retain)  NSMutableDictionary *imagecache ;

/* 代理回调 */
- (void)requestFinishedSuccess;
- (void)requestFinishedFailed;
- (void)requestFailed;
- (void)requestTimeout;

/* Query设置 */
- (void)setQuery:(NSString*)value forKey:(NSString*)key;

/* 事件触发 */
- (void)refreshTableViewDataSource;
- (void)pullUp;
- (void)pullDown;

/* 图片相关 */
//重新排列图片数组，分组显示
- (void)items2items:(NSMutableArray*)items1 toItems:(NSMutableArray*)items2;

//宝贝图片映射到cell上
- (void)item2cell:(NSMutableArray*)items toCell:(UITableViewCell*)cell;

- (void)reloadData;

/* DEBUG */
- (void)status;

@end
