//
//  EtaoPriceListController.h
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoPriceAuctionDataSource.h"
#import "ETaoUITableViewController.h"
#import "EtaoPriceDetailController.h"
#import "HTTPImageView.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableTailerView.h"
#import "EtaoPriceCommonAnimations.h"
#import "EtaoPriceBuyAuctionDataSource.h"
#import "EtaoPriceBuySettingDataSource.h"
#import "ETDataCenter.h"
#import "ETPageSwipeController.h"


@interface EtaoPriceListController : UITableViewController 
<EGORefreshTableHeaderDelegate,EGORefreshTableTailerDelegate,ETPageSwipeDelegate> 
{    
    BOOL _header_reloading;
    BOOL _tailer_reloading;
    BOOL _update_lock;
    
    NSMutableArray* _items;

    NSString* _datasourceKey;
 
    EGORefreshTableHeaderView* _refreshHeaderView; //View 下拉刷新
    EGORefreshTableTailerView* _refreshTailerView; //View 上拉更新
    
}
@property(nonatomic,retain) NSString* datasourceKey;

/* 监视函数 */
- (void)watchWithDatasource:(id)datasource;
- (void)watchWithKey:(NSString*)key;

/* 事件触发 */
- (void)stopRefresh;
- (void)refreshTableViewDataSource;
- (void)pullUp;
- (void)pullDown;
- (void)pullDownLikeManDoes;

/* 图片相关 */
//重新排列图片数组，分组显示
- (void)items2items:(NSMutableArray*)items1 toItems:(NSMutableArray*)items2;
//宝贝图片应设到cell上
- (void)item2cell:(EtaoPriceAuctionItem*)item toCell:(UITableViewCell*)cell;
- (void)reloadData;

@end
