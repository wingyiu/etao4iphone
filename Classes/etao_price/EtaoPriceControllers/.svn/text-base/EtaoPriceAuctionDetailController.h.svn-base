//
//  EtaoPriceAuctionDetailController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETDetailSwipeController.h"
#import "EtaoPriceAuctionItem.h"
#import "ETPageSwipeController.h"
@interface EtaoPriceAuctionDetailController : ETUIViewController<UITableViewDelegate,UITableViewDataSource,ETPageSwipeDetailDelegate>
{
    UITableView *_tableView; 
    EtaoPriceAuctionItem* _item;

}
@property (nonatomic, retain) UITableView *tableView; 
@property (nonatomic, retain) EtaoPriceAuctionItem* item; 

- (void)item2cell:(EtaoPriceAuctionItem *)item toCell:(UITableViewCell *)cell inPath: (NSIndexPath *)indexPath;
- (void)loadFoot;

@end
