//
//  TBNavigationDelegateHelper.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-10-20.
//  Copyright (c) 2011年 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 用于接管系统 UINavigationController 的 delegate，实现全局的 UINavigationController 可以向多个 delegate 发送通知
 */
@interface TBNavigationDelegateHelper : NSObject <UINavigationControllerDelegate>

//! 获取 TBNavigationDelegateHelper 实例
+ (TBNavigationDelegateHelper *)sharedHelper;

//! 注册为 UINavigationController 的 delegate
- (void)registerDelegate:(id<UINavigationControllerDelegate>)delegate;

//! 取消注册为 UINavigationController 的 delegate 
- (void)unregisterDelegate:(id<UINavigationControllerDelegate>)delegate;

//! 注册监听 NavigationController 的 delegate 列表
@property (nonatomic, retain) NSMutableArray *delegates;

//! 是否启用全局 NavigationController 的事件捕获
@property (nonatomic, assign) BOOL            enabled;

@end


/*!
 覆盖 UINavigationController 的 delegate 方法，实现全局 UINavigationController delegate 的多播
 */
@interface UINavigationController (TBNavigationDelegateHelper)

- (id<UINavigationControllerDelegate>)originalDelegate;
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated;
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated;

@end