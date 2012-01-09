//
//  TBUserTrack.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-9-15.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBUserTrackTypes.h"
#import "TBUserTrackCategories.h"


//! 淘宝无线 UserTrack 服务
@interface TBUserTrack : NSObject {
}

//! 设置是否启用 UserTrack，默认为启用
+ (void)setUserTrackEnabled:(BOOL)enabled;


//! 设置是否启用全局 NavigationController 的 UserTrack，默认为禁用
+ (void)setGlobalNavigationTrackEnabled:(BOOL)enabled;


//! 注册类名与实际页面名称对应关系
+ (void)registerClassName:(NSString *)className toPage:(NSString *)pageName;


//! 注册对象和实际页面名称对应关系
+ (void)registerObject:(id)object toPage:(NSString *)pageName;


//! 注册对应关系
+ (void)registerClassNameToPageMap:(NSDictionary *)map;


/*!
 添加跟踪记录
 @param     page        页面名称，例如 Page_Home
 @param     eventId     事件ID
 @param     arg1        事件参数1
 @param     arg2        事件参数2
 @param     arg3        事件参数3
 @param     args        其余参数，格式为 key1=val1,key2=val2
 */
+ (NSDictionary *)addTraceRecord:(NSString *)page
                         eventId:(NSUInteger)eventId
                            arg1:(NSString *)arg1
                            arg2:(NSString *)arg2
                            arg3:(NSString *)arg3
                            args:(NSString *)args;


/*!
 添加跟踪记录
 @param     page        页面名称，例如 Page_Home
 @param     eventId     事件ID
 */
+ (NSDictionary *)addTraceRecord:(NSString *)page eventId:(NSUInteger)eventId;


/*!
 添加跟踪记录
 @param     page        页面名称，例如 Page_Home
 @param     eventId     事件ID
 @param     arg1        事件参数1
 */
+ (NSDictionary *)addTraceRecord:(NSString *)page eventId:(NSUInteger)eventId arg1:(NSString *)arg1;


/*!
 添加跟踪记录
 @param     page        页面名称，例如 Page_Home
 @param     eventId     事件ID
 @param     arg1        事件参数1
 @param     arg2        事件参数2
 */
+ (NSDictionary *)addTraceRecord:(NSString *)page eventId:(NSUInteger)eventId arg1:(NSString *)arg1 arg2:(NSString *)arg2;


/*!
 添加跟踪记录
 @param     page        发生事件的类，自动取类名字作为跟踪记录的页面名称
 @param     eventId     事件ID
 @param     arg1        事件参数1
 @param     arg2        事件参数2
 @param     arg3        事件参数3
 */
+ (NSDictionary *)trackPage:(id)page eventId:(NSUInteger)eventId arg1:(NSString *)arg1 arg2:(NSString *)arg2 arg3:(NSString *)arg3;


/*!
 添加跟踪记录
 @param     page        发生事件的类，自动取类名字作为跟踪记录的页面名称
 @param     eventId     事件ID
 @param     arg1        事件参数1
 */
+ (NSDictionary *)trackPage:(id)page eventId:(NSUInteger)eventId arg1:(NSString *)arg1;


@end
