//
//  TBItemManjiusongPromotion.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-1-21.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBItemPromotionBase.h"


//! 满就送优惠信息
@interface TBItemManjiusongPromotion : TBItemPromotionBase {
    NSString            *mjsGiftUrl;
    NSString            *mjsInfo;
}

//! 如果送宝贝，就是宝贝链接地址
@property (nonatomic, copy)		NSString		*mjsGiftUrl;

//! 满就送的内容，通常为“满xxx，送xxx”等
@property (nonatomic, copy)		NSString		*mjsInfo;

@end
