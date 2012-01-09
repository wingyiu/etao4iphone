//
//  EtaoPricePubuliuController.h
//  etao4iphone
//
//  Created by 左 昱昊 on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETDataCenter.h"
#import "ETHttpImageView.h"
#import "ETPageSwipeDelegate.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableTailerView.h"
#import "EtaoPriceCommonAnimations.h"
#import "EtaoPriceBuyAuctionDataSource.h"
#import "EtaoPriceBuySettingDataSource.h"
#import "ETPageSwipeController.h"
#import "EtaoPriceAuctionDetailController.h"
#import "EtaoPriceMainViewController.h"


//每一行展示的个数,依赖这个数来定位图片缩放比例
#ifndef DISPLAY_IMAGE
#define DISPLAY_IMAGE
#define DISPLAY_IMAGE_COUNT_EACH_ROW 3 //一行展示的个数
#define DISPLAY_IMAGE_BORDER 1         //图片边框大小
#define DISPLAY_IMAGE_WIDTH 94         //图片宽度
#define DISPLAY_IMAGE_GAP 8            //图片间隔
#endif



//可以响应点击事件的有独立数据结构的类
@interface PubuliuImageView:ETHttpImageView
{
    EtaoPriceAuctionItem* _item;
    CGPoint _origin;
    BOOL _readyForDisplay;
}
@property(nonatomic,retain) EtaoPriceAuctionItem* item;
@property(nonatomic,assign) CGPoint origin;
@property(nonatomic,assign) BOOL readyForDisplay; 
@end

@interface EtaoPricePubuliuController : UIViewController <UIScrollViewDelegate , EGORefreshTableHeaderDelegate , 
EGORefreshTableTailerDelegate, UIGestureRecognizerDelegate,ETPageSwipeDelegate,EtaoHttpImageViewDelegate>{
    
    NSString* _datasourceKey;
    
    BOOL _header_reloading;
    BOOL _tailer_reloading;
    BOOL _update_lock;
    
    EGORefreshTableHeaderView *_refreshHeaderView; //View 下拉刷新
    EGORefreshTableTailerView *_refreshTailerView; //View 下拉刷新
    
    UIScrollView* _mainView;                       //View 主滑动窗口
    NSMutableArray* _items;                        //宝贝数组
    
    CGFloat _rowPos[DISPLAY_IMAGE_COUNT_EACH_ROW]; //Data 每一列图片的展示
    NSMutableDictionary* _loadingImageTable;       //loading表
    ASINetworkQueue *networkQueue;                 //controller的并发队列

    
}

@property(nonatomic,retain) NSString* datasourceKey;

/* 这里声明所有的公有变量，实现property，供外部访问 */

/* 监视函数 */
- (void)watchWithDatasource:(id)datasource;
- (void)watchWithKey:(NSString*)key;

/* 所有的回调函数会在这里声明，私有函数不在这里声明 */
- (void)stopRefresh;
- (void)pullDownLikeManDoes;
- (void)pullDown; //下拉
- (void)pullUp;   //上拉
- (void)refreshTableViewDataSource;

- (void)SingleTouch:(id)sender;
- (void)scaleWithWidth:(PubuliuImageView*)imgView withLength:(CGFloat)length;
- (void)items2items:(NSMutableArray*)items1 toItems:(NSMutableArray*)items2;
- (void)autoDisplay;
- (void)beginLoad:(EtaoPriceAuctionItem*)item;

@end
