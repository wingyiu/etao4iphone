//
//  TBFavoriteItem.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-9-9.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBWapItem.h"

@class TBShop;

//! 收藏类型
typedef enum {
    TBFavoriteItemTypeAuction,  //! 宝贝收藏
    TBFavoriteItemTypeShop      //! 店铺收藏
} TBFavoriteItemType;


//! 收藏条目
@interface TBFavoriteItem : TBWapItem {
    NSString    *collectInfoId;
    NSString    *collectorcount;
    
    NSString    *itemType;  // 0 是店铺  1 是宝贝
    NSString    *ownernick;
    NSString    *sellerSum;
}

//! 获取对应收藏的店铺信息对象
- (TBShop *)shopItem;

//! 获取收藏的类型
- (TBFavoriteItemType)favoriteType;

@property (nonatomic, copy) NSString    *collectInfoId, *collectorcount;
@property (nonatomic, copy)	NSString    *itemType;
@property (nonatomic, copy)	NSString    *ownernick;
@property (nonatomic, copy)	NSString    *sellerSum;

@end
