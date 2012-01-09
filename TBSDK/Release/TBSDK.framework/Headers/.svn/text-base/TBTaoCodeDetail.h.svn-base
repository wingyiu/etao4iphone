//
//  TBTaoCodeDetail.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-11-4.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

//! 淘代码类型
typedef enum {
    TBTaoCodeDetailTypeUnknown,     //! 未知淘代码类型
    TBTaoCodeDetailTypeItem = 1,    //! 指向宝贝的淘代码
    TBTaoCodeDetailTypeShop = 2,    //! 指向店铺的淘代码
    TBTaoCodeDetailTypeOther = 9    //! 其他形式的淘代码，有可能是链接
} TBTaoCodeDetailType;


//! 淘代码信息
@interface TBTaoCodeDetail : TBModel {
    NSString            *tao_code;
    NSString            *direct_url;
    NSString            *type;
    NSString            *overdue;
    NSString            *status;
    
    NSString            *item_id;
    NSString            *item_status;
    NSString            *item_keywords;
    NSString            *item_category;
    
    NSString            *shop_id;
    NSString            *shop_category;
}

//! 是否已经过期
- (BOOL)isOverdue;

//! 淘代码类型
- (TBTaoCodeDetailType)taocodeType;

//! 宝贝是否上架
- (BOOL)isItemValid;

@property (nonatomic, copy)     NSString            *tao_code;
@property (nonatomic, copy)     NSString            *direct_url;
@property (nonatomic, copy)     NSString            *type;
@property (nonatomic, copy)     NSString            *overdue;
@property (nonatomic, copy)     NSString            *status;

@property (nonatomic, copy)     NSString            *item_id;
@property (nonatomic, copy)	    NSString            *item_status;
@property (nonatomic, copy)     NSString            *item_keywords;
@property (nonatomic, copy)     NSString            *item_category;

@property (nonatomic, copy)     NSString            *shop_id;
@property (nonatomic, copy)     NSString            *shop_category;

@end
