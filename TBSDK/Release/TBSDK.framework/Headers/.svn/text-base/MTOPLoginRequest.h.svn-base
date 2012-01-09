//
//  MTOPLoginRequest.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-24.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTOPRequest.h"

//! 登录请求 delegate 的协议
@protocol MTOPLoginDelegate

//! 登录请求结果
- (void)tbLoginRequest:(MTOPRequest *)request isSuccess:(BOOL)isSuccess;

@end


//! 无线MTOP 登录请求，同时登录 MTOP 与 TOP
@interface MTOPLoginRequest : MTOPRequest <ASIHTTPRequestDelegate> {
    NSString    *username;
    NSString    *password;
    BOOL        rememberMe;
    
    NSString    *checkCodeId;
    NSString    *checkCode;
    
    NSString    *pubkey;
    NSString    *token;
    NSString    *autoLoginToken;
}

/*! 从 Keychain 中加载保存的用户名和密码 */
- (BOOL)load;

//! 获取加密用的Token和Public key
- (void)getAppToken;

/*!
 向delegate响应登录是否成功
 @param isLoginSuccess 登录是否成功
 */
- (void)responseToDelegate:(BOOL)isLoginSuccess;


/*! 登录时使用的用户名 */
@property (nonatomic, copy) NSString *username;

/*! 登录时使用的密码 */
@property (nonatomic, copy) NSString *password;

/*! 保存用户名和密码到 Keychain 中，用于自动登录 */
@property (nonatomic, assign) BOOL rememberMe;

//! 验证码ID，如果需要验证码时传入
@property (nonatomic, retain)  NSString    *checkCodeId;

//! 用户输入的验证码
@property (nonatomic, retain)  NSString    *checkCode;

//! 登录第二步中需要用的RSA加密密钥
@property (nonatomic, retain)  NSString    *pubkey;

//! 动态密钥的key,需要在下一步操作中带上
@property (nonatomic, retain)  NSString    *token;

//! 自动登录时用的token
@property (nonatomic, retain)  NSString    *autoLoginToken;

@end
