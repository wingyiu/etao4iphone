//
//  EtaoPriceWaterfallController.h
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableTailerView.h"
#import "EtaoPriceDetailController.h"
#import "HTTPImageView.h"
#import "TBMemoryCache.h"
#import "EtaoPriceAuctionDataSource.h"
#import "ETPageSwipeController.h"

//内存自动释放机制
#define ACTIVE_VIEW_COUNT 30
#define STACK_SIZE 100

#ifndef DISPLAY_IMAGE
#define DISPLAY_IMAGE
#define DISPLAY_IMAGE_COUNT_EACH_ROW 3
#define DISPLAY_IMAGE_BORDER 1
#define DISPLAY_IMAGE_WIDTH 94
#define DISPLAY_IMAGE_GAP 8
#endif

/*
@interface WaterfallScrollView : UIScrollView
@end
 
 typedef struct view_frame{
 NSMutableArray* views;
 CGFloat top;
 CGFloat bottom;
 } SViewFrame;
 
 typedef struct stack_frame{
 int count;
 NSString* url[ACTIVE_VIEW_COUNT];
 CGPoint point[ACTIVE_VIEW_COUNT];
 }SStackFrame;
 
 typedef struct stack_frames{
 int frame_count;
 SStackFrame stack_frame[STACK_SIZE];
 }SStackFrames;
*/


//可以响应点击事件的有独立数据结构的类
@interface WaterfallHTTPImageView:HTTPImageView
{
    int _index;
    id _delegate;
    SEL _action;
    EtaoPriceAuctionItem* _item;
    UIView* _greyLayer;
}
@property(nonatomic,retain) EtaoPriceAuctionItem* item;
@property(nonatomic,assign) int index;
@property(nonatomic,assign) id delegate;
@property(nonatomic,assign) SEL action;
@end



@interface EtaoPriceWaterfallController : ETaoUIViewController 
<UIScrollViewDelegate , EGORefreshTableHeaderDelegate , 
EGORefreshTableTailerDelegate , EtaoPriceAuctionDataSourceDelegate , 
UIGestureRecognizerDelegate,ETPageSwipeDelegate>
{   
    UInt32 _num_of_col;                //每一列显示的个数
    UInt32 _pix_of_height;             //高度
    UInt32 _pix_of_width;              //宽度
    
    BOOL _header_reloading;
    BOOL _tailer_reloading;
    BOOL _update_lock;

    EGORefreshTableHeaderView *_refreshHeaderView; //View 下拉刷新
    EGORefreshTableTailerView *_refreshTailerView; //View 下拉刷新
    
    UIScrollView* _mainView;                       //View 主滑动窗口

    NSMutableSet* _display_items;                  //宝贝集合,存储已经展现的宝贝
    NSMutableArray* _items;                        //宝贝数组
    
    NSString* _datasourceKey;
    CGFloat _rowPos[DISPLAY_IMAGE_COUNT_EACH_ROW]; //Data 每一列图片的展示
    

    
    /*
    id _urlMessager;                               //url信使，负责获取url    
    int _mode;                                     //瀑布流还是九宫格
    BOOL _balance_mem_lock;                        //内存优化锁,初始状态锁住，只有超过第三个frame才解锁。
    SViewFrame* _view_frams[3];                    //viewframe内存数组
    SStackFrames _head_stack_frames;               //头部缓存栈
    SStackFrames _tail_stack_frames;               //尾部缓存栈
    
    BOOL _scroll_lock;                             //Status 滚动到底部判断是否锁定
    BOOL _reloading;                               //Status 判断当前是否在下拉刷新状态
    */

    
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

//重新排列图片数组，分组显示
- (void)items2items:(NSMutableArray*)items1 toItems:(NSMutableArray*)items2;
- (void)autoDisplay; //同步request里的item数组到本地，并自动展现
- (NSMutableArray*)dataToImages;
- (NSMutableArray*)imagesToViews:(NSMutableArray*)imgUrls;
- (void)displayViews:(NSMutableArray*)imgViews;
- (void)scaleWithWidth:(UIImageView*)imgView withLength:(CGFloat)length;

/* memory optimus 
- (void)frameAdd:(UIView*)view;
- (void)framesAdjust;
- (void)framesClean;
- (void)frameClean:(SViewFrame*)frame;
- (void)framePop:(SViewFrame*)frame withStack:(SStackFrames*)stack;
- (void)framePush:(SViewFrame*)frame withStack:(SStackFrames*)stack;
- (void)memBalanceStatus;
*/

@end
