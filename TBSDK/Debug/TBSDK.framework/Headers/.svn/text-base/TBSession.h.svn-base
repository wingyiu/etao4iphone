//
//  TBSession.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-10-11.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TBNotificationUserLoggedIn      @"TB_NOTIFICATION_USER_LOGGED_IN"
#define TBNotificationUserLoggedOut     @"TB_NOTIFICATION_USER_LOGGED_OUT"


//! 淘宝登录会话相关信息
@interface TBSession : NSObject {
    //! 检查会话是否有效的请求个数
    int         sessionCheckRqeuestCount;
    //! 检查会话是否有效的请求成功个数
    int         sessionCheckSuccessCount;
}

/*! 共享的实例 */
+ (TBSession *)sharedSession;

/*! 清除会话信息，相当于退出登录 */
- (void)clearSession;

/*! 保存会话信息，session 会保存到 Keychain 中 */
- (void)saveSession;

/*! 从 Keychain 中加载会话信息 */
- (void)loadSession;

/*! 重新激活 session，会判断会话有效性，如果已经失效则重新登录，但如果 Keychain 中没有保存用户名密码则直接将清除会话 */
- (void)reactivateSession;

//! 重新激活session，不检查session有效性
- (void)reactivateSessionWithoutCheck;

@end
