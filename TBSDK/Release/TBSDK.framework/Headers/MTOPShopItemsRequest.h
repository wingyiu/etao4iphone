//
//  MTOPShopItemsRequest.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-7-24.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "TOPSearchRequest.h"


//! 店内宝贝查询
@interface MTOPShopItemsRequest : TOPSearchRequest {
    NSString            *shopOwnerUserId;
    NSString            *requestMethod;
    
}

@property (nonatomic, retain)  NSString            *shopOwnerUserId;
@property (nonatomic, retain) NSString              *requestMethod;
@end
