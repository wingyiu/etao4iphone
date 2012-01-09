//
//  EtaoSearchFilterViewController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoAuctionSearchCategoryFilterViewController.h"
@interface ETaoFilterItem : NSObject {

}
@property (nonatomic,retain) NSString *title ;
@property (nonatomic,retain) UIImage  *image ;
@property int  tag ; 
@property ETFilterType type;
@end

@protocol EtaoSearchFilterDelegate <NSObject>

@optional
- (void) EtaoSearchFilterItemSelected:(ETaoFilterItem *)item ;

@end

@interface EtaoSearchFilterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableSet *_catNameSet;
    NSMutableSet *_propNameSet;
    NSMutableSet *_sellerNameSet;
    NSString *_start_price;
    NSString *_end_price;
}

@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSString *headTitle ;
@property (nonatomic, assign) id delegate;  
@property (nonatomic, retain) NSMutableSet *catNameSet;
@property (nonatomic, retain) NSMutableSet *propNameSet;
@property (nonatomic, retain) NSMutableSet *sellerNameSet;
@property (nonatomic, retain) NSString *start_price;
@property (nonatomic, retain) NSString *end_price;

- (void)item2cell:(UITableViewCell *)cell andindexPath:(NSIndexPath *)path;
@end
