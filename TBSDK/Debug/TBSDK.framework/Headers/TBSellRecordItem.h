//
//  TBSellRecordItem.h
//  taobao4iphone
//
//  Created by chenyan on 11-7-5.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

@interface TBSellRecordItem : TBModel {
    NSString    *buyer;
    NSString    *rank;
    NSString    *vipImg;
    NSString    *title;
    NSString    *skuInfo;
    NSString    *price;
    NSString    *quantity;
    NSString    *time;
    NSString    *status;
}

@property (nonatomic, retain) NSString  *buyer;
@property (nonatomic, retain) NSString  *rank;
@property (nonatomic, retain) NSString  *vipImg;
@property (nonatomic, retain) NSString  *title;
@property (nonatomic, retain) NSString  *skuInfo;
@property (nonatomic, retain) NSString  *price;
@property (nonatomic, retain) NSString  *quantity;
@property (nonatomic, retain) NSString  *time;
@property (nonatomic, retain) NSString  *status;

@end
