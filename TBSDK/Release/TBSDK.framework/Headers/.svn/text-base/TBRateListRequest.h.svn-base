//
//  TBRateListRequest.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-9-19.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TOPRequest.h"

//! 宝贝评价详情列表请求
@interface TBRateListRequest : TOPRequest {
    NSDecimalNumber         *userId;
    NSDecimalNumber         *itemId;
    
    BOOL                    showContent;
    BOOL                    isMore;
    int                     page;
}

/*! 卖家ID */
@property (nonatomic, copy) NSDecimalNumber *userId;

/*! 宝贝ID */
@property (nonatomic, copy) NSDecimalNumber *itemId;

/*! 是否只返回有评论的评价 */
@property (nonatomic, assign) BOOL showContent;

/*! 是否为更多里面的评价记录 */
@property (nonatomic, assign) BOOL isMore;

/*! 页码 */
@property (nonatomic, assign) int page;

@end
