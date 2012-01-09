//
//  TOPSearchRequest.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-8-7.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TOPRequest.h"

//! TOP搜索结果排序方式
typedef enum {
    TOPSearchRequestOrderTypeDefault,   /*!< 默认排序，等同于 TOPSearchRequestOrderTypePopularity */
    TOPSearchRequestOrderTypePriceAsc,  /*!< 按价格从低到高 */
    TOPSearchRequestOrderTypePriceDesc, /*!< 按价格从高到低 */
    TOPSearchRequestOrderTypeCredit,    /*!< 按卖家信用从高到低 */
    TOPSearchRequestOrderTypeSales,     /*!< 按销量从高到低 */
    TOPSearchRequestOrderTypeListTime,  /*!< 按上架时间从近到远 */
    TOPSearchRequestOrderTypePopularity /*!< 按人气从高到低 */
} TOPSearchRequestOrderType;

//! TOP搜索请求
@interface TOPSearchRequest : TOPRequest {
    NSString        *keyword;
    NSString        *sellerNick;
    NSString        *productId;
    
    NSString        *categoryId;
    
    NSString        *location;
    
    NSUInteger      pageNo;
    NSUInteger      pageSize;
    
    BOOL            isNew;
    BOOL            isSecond;
    BOOL            isUnused;
    int             stuffStatus;
    NSArray         *stuffStatusArr;
    
    BOOL            isPrepay;
    BOOL            isMall;
    BOOL            isFreeShipping;
    BOOL            isAutoPost;
    BOOL            isWWOnline;
    BOOL            isCod;
    
    BOOL            isGlobal;
    
    NSUInteger      startPrice;
    NSUInteger      endPrice;
    
    NSString        *props;
    
    TOPSearchRequestOrderType   orderBy;
    //NSString        *orderBy;       // 可选 bid, _bid, ratesum，默认为人气
    
    NSString        *ssid;
}

/*!
 重置请求参数
 */
- (void)resetParams;

/*!
 设置请求参数
 @param     param       YES 表示添加参数，NO 表示删除参数
 @param     name        参数名称
 @param     val         参数值
 */
- (void)setParam:(BOOL)param name:(NSString *)name value:(NSString *)val;

//! 根据字符串获取排序类型
- (TOPSearchRequestOrderType)orderTypeFromString:(NSString *)str;

//! 排序参数的字符串值
- (NSString *)orderParamValue;

/*!
 设置搜索宝贝类型为所有类型
 */
- (void)setStuffStatusToAll;

/*!
 从一个字典配置搜索请求
 @param dict 字典的键值对就是搜索请求的参数，名称需要与线上 search.taobao.com 请求参数中的参数名对应
 */
- (void)configureWithDictionary:(NSDictionary *)dict;

/*! 请求的页码 */
@property (nonatomic, assign) NSUInteger pageNo;

/*! 请求的分页大小 */
@property (nonatomic, assign) NSUInteger pageSize;

/*! 搜索的关键字 */
@property (nonatomic, copy)   NSString *keyword;

/*! 搜索的卖家昵称，多个使用英文逗号分隔 */
@property (nonatomic, copy)   NSString *sellerNick;

/*! 搜索的产品ID */
@property (nonatomic, copy)    NSString        *productId;

/*! 在指定分类中搜索 */
@property (nonatomic, copy)   NSString *categoryId;

/*! 宝贝所在地，可以为城市名或省名 */
@property (nonatomic, copy)   NSString *location;

/*! 搜索全新宝贝 */
@property (nonatomic, assign) BOOL isNew;

/*! 搜索二手宝贝 */
@property (nonatomic, assign) BOOL isSecond;

/*! 搜索闲置宝贝 */
@property (nonatomic, assign) BOOL isUnused;
@property (nonatomic, readonly) int stuffStatus;

/*! 是否支持消保 */
@property (nonatomic, assign) BOOL isPrepay;

/*! 是否只搜索商城宝贝 */
@property (nonatomic, assign) BOOL isMall;

/*! 是否免运费 */
@property (nonatomic, assign) BOOL isFreeShipping;

/*! 是否为自动发货 */
@property (nonatomic, assign) BOOL isAutoPost;

/*! 旺旺是否在线 */
@property (nonatomic, assign) BOOL isWWOnline;

/*! 是否支持货到付款 */
@property (nonatomic, assign) BOOL isCod;

/*! 是否为全球购宝贝 */
@property (nonatomic, assign) BOOL isGlobal;

/*! 价格区间的起始价格 */
@property (nonatomic, assign) NSUInteger startPrice;

/*! 价格区间的终止价格 */
@property (nonatomic, assign) NSUInteger endPrice;

/*! 宝贝属性，pid:vid，多个以 ; 分隔 */
@property (nonatomic, copy)   NSString *props;

/*! 搜索排序方式 */
@property (nonatomic, assign) TOPSearchRequestOrderType orderBy;

/*! 跟踪的 ssid */
@property (nonatomic, copy)   NSString *ssid;

@end
