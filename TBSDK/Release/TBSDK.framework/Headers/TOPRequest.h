//
//  TOPRequest.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-11.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "ASIHTTPRequest.h"

@class ASIHTTPRequest;
@class ASIFormDataRequest;
@class TBErrorResponse;
@protocol TOPRequestDelegate;
@protocol ASIHTTPRequestDelegate;

//! TOP请求
@interface TOPRequest : NSObject < ASIHTTPRequestDelegate, NSCopying > {
    NSString            *apiMethod;
    NSMutableDictionary *params;
    
    ASIFormDataRequest  *httpRequest;
    BOOL                isRequesting;
    id                  delegate;
    BOOL                usePOST;
    BOOL                needsUserSession;
    int                 delegateRetainedCount;

    SEL                 requestDidFinishSelector;
    SEL                 requestDidFailedSelector;
    
    NSDictionary        *userInfo;
    
    NSDictionary        *responseJSON;
    NSString            *responseString;
    NSData              *responseData;
    TBErrorResponse     *responseError;
    
    NSString            *sentData;
    double              requestStartTime;
}

/*!
 创建一个指定方法的请求
 @param method 方法名称，例如 com.taobao.items.search
 */
+ (id)requestWithMethod:(NSString *)method;

/*!
 创建一个指定方法的请求
 @param method 方法名称，例如 com.taobao.items.search
 */
- (id)initWithMethod:(NSString *)method;

/*!
 添加请求参数
 @param param 参数值
 @param key 参数名称
 */
- (void)addParam:(NSObject *)param forKey:(NSString*)key;

/*!
 删除一个请求参数
 @param key 参数名称
 */
- (void)removeParam:(NSString *)key;

//! 给请求签名
- (NSString *)sign;

//! 获取数据的MD5字符串
- (NSString *)md5:(NSData *)data;

//! 获取数据的MD5 Hash数据
- (NSData *)md5Data:(NSData *)data;

//! 发送请求
- (void)sendRequest;

//! 取消请求
- (void)cancel;

//! 自定义请求对象，用于在子类中修改请求行为
- (void)customizeRequest:(ASIHTTPRequest *)request;

//! 响应指定的 selector
- (void)responseSelector:(SEL)selector;

//! 调用成功的 selector
- (void)responseSuccess;

//! 调用失败的 selector
- (void)responseFailed;

//! 添加一条跟踪记录
- (void)addTraceRecord;

//! 将 NSDictionary 转换为查询字符串
- (NSString *)dictToQueryString:(NSDictionary *)dict;

//! 获取请求所用的数据
- (NSDictionary *)dataForRequest;

//! 获取请求的目标 URL
- (NSString *)urlForRequest;

//! 获取使用 GET 方式时的请求 URL
- (NSString *)urlForGetRequest;

//!在发送请求时，retain delegate
- (void)retainDelegate;

//!请求完成后，release delegate
- (void)releaseDelegate;


//! API 请求的方法
@property (nonatomic, copy)   NSString *apiMethod;

/*! 是否使用 POST 方式发送请求 */
@property (nonatomic, assign) BOOL usePOST;

//! 是否需要用户的session
@property (nonatomic, assign) BOOL needsUserSession;

/*! 回调 delegate 对象 */
@property (nonatomic, assign) id delegate;

/*! 请求的参数 */
@property (nonatomic, readonly) NSMutableDictionary *params;

/*! 请求失败时的 selector，默认为 tbRequestFailed: */
@property (nonatomic, assign) SEL requestDidFailedSelector;

/*! 请求成功时的 selector，默认为 tbRequestSuccess: */
@property (nonatomic, assign) SEL requestDidFinishSelector;

/*! 自定义用户数据 */
@property (nonatomic, retain) NSDictionary *userInfo;

/*! JSON 格式的请求响应数据 */
@property (nonatomic, retain) NSDictionary *responseJSON;

/*! NSData 对象的请求响应数据 */
@property (nonatomic, retain) NSData *responseData;

/*! NSString 对象的请求响应数据 */
@property (nonatomic, retain) NSString *responseString;

/*! 请求的错误 */
@property (nonatomic, retain) TBErrorResponse *responseError;

/*! 发送请求时的数据 */
@property (nonatomic, retain) NSString *sentData;

@end
