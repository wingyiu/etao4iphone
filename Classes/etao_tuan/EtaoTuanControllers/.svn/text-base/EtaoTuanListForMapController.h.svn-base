//
//  EtaoTuanListController.h
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETaoUITableViewController.h"
#import "EtaoTuanListDetailController.h"
#import "HTTPImageView.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableTailerView.h"
#import "EtaoTuanCommonAnimations.h"
#import "EtaoTuanHomeViewController.h"
#import "EtaoGroupBuyAuctionDataSource.h"
#import "ETLocation.h"
#import "ETDataCenter.h"
#import "ETSRPTableViewController.h"
#import "EtaoGroupBuyListForMapCell.h"
#import "ETPageSwipeController.h"

#ifndef MAP_HEIGHT
#define MAP_HEIGHT 252
#endif

@interface EtaoTuanListForMapController : ETSRPTableViewController 
<EGORefreshTableHeaderDelegate,EGORefreshTableTailerDelegate,ETPageTouchDelegate,ETPageSwipeDelegate> 
{    
    BOOL _header_reloading;
    BOOL _tailer_reloading;

    NSMutableArray* _items;
    
    NSMutableDictionary *_catPic;
    
    EGORefreshTableHeaderView* _refreshHeaderView; //View 下拉刷新
    EGORefreshTableTailerView* _refreshTailerView; //View 上拉更新

    NSString* _datasourceKey;
    
    NSInteger rowClick;
    int _cellAtTop;
    
}

@property (nonatomic,retain) NSString* datasourceKey;

/* 监视函数 */
- (void)watchWithDatasource:(id)datasource;
- (void)watchWithKey:(NSString*)key;


/* 事件触发 */
- (void)stopRefresh;
- (void)refreshTableViewDataSource;
- (void)pullUp;
- (void)pullDown;
- (void)pullDownLikeManDoes;
- (void)reloadTableViewDataSource;

/* 图片相关 */
//重新排列图片数组，分组显示
- (void)items2items:(NSMutableArray*)items1 toItems:(NSMutableArray*)items2;
//宝贝图片应设到cell上
- (void)item2cell_small:(EtaoTuanAuctionItem*)item toCell:(UITableViewCell*)cell inRow:(NSInteger)row;
- (void)item2cell_large:(EtaoTuanAuctionItem*)item toCell:(UITableViewCell*)cell inRow:(NSInteger)row;
- (void)reloadData;

@end
