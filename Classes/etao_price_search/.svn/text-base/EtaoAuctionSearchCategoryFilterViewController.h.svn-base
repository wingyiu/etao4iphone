//
//  EtaoAuctionSearchCategoryFilterViewController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETUIViewController.h"
#import "ETaoModel.h"
#import "EtaoAuctionSRPTableViewCell.h"
#import "EtaoSliderView.h"

typedef enum {
    ETCategory,
    ETProperty,
    ETB2C,
    ETOther
} ETFilterType;

@interface ETFiterItem : ETaoModel <NSCopying>{
    ETFilterType ftype ;
	NSString * key;
	NSString * name; 
	BOOL _selected ; 
}
@property (nonatomic, assign) ETFilterType ftype;
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, assign) BOOL selected ; 
@end

@class EtaoAuctionSearchCategoryFilterViewController;
@protocol EtaoAuctionSearchCategoryFilterDelegate <NSObject>

@optional
- (void)  EtaoAuctionSearchCategoryFilterBack:(EtaoAuctionSearchCategoryFilterViewController *)v ;
- (void)  EtaoAuctionSearchCategoryFilterDone:(EtaoAuctionSearchCategoryFilterViewController *)v ;
@end

@interface UINavigationBar (CustomImage)
@end

@interface EtaoAuctionSearchCategoryFilterViewController : ETUIViewController<UITableViewDelegate,UITableViewDataSource,EtaoSliderDelegate>{
    NSMutableDictionary *_itemDicts; 
    NSMutableArray *_itemKeys;
    UITableView *_tableView;
    ETFilterType _ftype;
    id _delegate;

    NSMutableDictionary *_standDic;
    
    NSMutableDictionary *_choosedCategory;
    NSMutableDictionary *_choosedProp;
    NSMutableSet *_choosedSeller;
    NSString *_start_price;
    NSString *_end_price;
    
    int lastIndexPathRow;
}

@property (nonatomic, retain) NSMutableDictionary *itemDicts; 
@property (nonatomic, retain) NSMutableArray *itemKeys; 
@property (nonatomic, assign) id delegate;  
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) ETFilterType ftype;
@property (nonatomic, retain) NSMutableDictionary *choosedCategory;
@property (nonatomic, retain) NSMutableDictionary *choosedProp;
@property (nonatomic, retain) NSMutableSet *choosedSeller;
@property (nonatomic, retain) NSString *start_price;
@property (nonatomic, retain) NSString *end_price;

- (NSMutableDictionary *)standardizationArray;
@end
