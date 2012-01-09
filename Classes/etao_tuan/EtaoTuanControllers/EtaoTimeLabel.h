//
//  EtaoLabel.h
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 11-12-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoTuanAuctionItem.h"

@interface EtaoTimeLabel : UILabel{
    EtaoTuanAuctionItem *_item;
    NSInteger timeRest;
}

@property (nonatomic, retain) EtaoTuanAuctionItem *item;


-(void) showLabelText;
-(void)updateLabelText;

@end