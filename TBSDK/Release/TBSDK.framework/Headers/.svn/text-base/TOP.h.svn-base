//
//  TOP.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-10.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif
    /*!
     设置TOP以及MTOP所用的 App Key 和 App Secret
     @param key         App Key
     @param secret      未加密的 App Secret
     */
    void TBSetTOPAppKeyAndAppSecret(NSString *key, NSString *secret);
    
    /*!
     设置TOP以及MTOP所用的 App Key 和 App Secret
     @param key         App Key
     @param secret1     使用 AES_ENCRYPT 加密后的 App Secret 前半部分
     @param secret1     使用 AES_ENCRYPT 加密后的 App Secret 后半部分
    */
    void TBSetTOPAppKeyAndSecret(NSString *key, NSData *secret1, NSData *secret2);
#ifdef __cplusplus
}
#endif

//! TOP设置以及会话相关信息
@interface TOP : NSObject {

}

/*! 获取本地时间与服务器的时间差 */
+ (void)fetchServerTimeInterval;

/*! 获取当然的时间戳 */
+ (NSDate *)timestamp;

/*! 获取当前是否已经有用户登录 */
+ (BOOL)isLoggedIn;

/*! 清除会话 */
+ (void)clearSession;

/*! 获取当前会话的 TOP sesssion id */
+ (NSString *)session;

/*! 设置会话的 TOP session id */
+ (void)setSession:(NSString *)s;

/*! 获取当前会话的无线 session id */
+ (NSString *)wapSID;

/*! 设置会话的无线 session id */
+ (void)setWapSID:(NSString *)sid;

/*! 获取当前登录用户的 userNick */
+ (NSString *)userNick;

/*! 设置登录用户的 userNick */
+ (void)setUserNick:(NSString *)nick;

/*! 获取无线埋点的 ttid */
+ (NSString *)wapTTID;

/*! 设置无线埋点的 ttid */
+ (void)setWapTTID:(NSString *)ttid;

/*! 获取 TOP API 的请求地址 */
+ (NSString *)topAPIURL;

/*! 获取无线 MTOP API 的请求地址 */
+ (NSString *)wapAPIURL;

/*! 获取程序的 TOP App Key */
+ (NSString *)appKey;

/*!
 获取程序的 TOP App Secretcode
 这里返回的 secretCode 没有用处，真正的 secretCode 由 TOPSecret.h 中的 GET_APP_SECRET 宏获得
 */
+ (NSString *)secretCode;

/*! 获取支付宝无线的 host */
+ (NSString *)alipayHost;

//! 无线站点的host
+ (NSString *)wapSiteHost;

//! 无线搜索的host
+ (NSString *)wapSearchHost;

//! 设置支付宝客户端标识
+ (void)setAlipayClientSignature:(NSString *)sign;

//! 获取当前的支付宝客户端标识
+ (NSString *)alipayClientSignature;

/*! 根据支付宝交易号获取支付页面的URL */
+ (NSString *)tradePayURL:(NSString *)alipay_no;

/*! 根据支付宝晩号获取确认付款页面的URL */
+ (NSString *)confirmGoodsURL:(NSString *)alipay_no;

//! 获取购物车批量付款链接
+ (NSString *)batchPayURL:(NSArray *)tradeIds;

@end
