//
//  SearchDetailListItemViewCell.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface SearchDetailProductListItem : UIViewController<UITableViewDelegate,UITableViewDataSource> {
#import "EtaoAuctionItem.h"

@interface SearchDetailListItemViewCell : UITableViewCell {
    
}

- (void) set:(EtaoAuctionItem*)item;

+ (int) height;

@end