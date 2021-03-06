//
//  TBUserTrackTypes.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-9-26.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//! TBUserTrack 事件ID
enum TB_USERTRACK_EVENT {
    TB_USERTRACK_EVENT_ERROR                    = 0,
    TB_USERTRACK_EVENT_ERROR_LOGCAT             = TB_USERTRACK_EVENT_ERROR+1,       // LogCat 错误
    TB_USERTRACK_EVENT_ERROR_API_REQUEST        = TB_USERTRACK_EVENT_ERROR+2,       // API请求失败
    
    TB_USERTRACK_EVENT_SYSTEM                   = 1000,
    TB_USERTRACK_EVENT_SYSTEM_INSTALLED         = TB_USERTRACK_EVENT_SYSTEM+1,      // 安装成功
    TB_USERTRACK_EVENT_SYSTEM_FIRST_START       = TB_USERTRACK_EVENT_SYSTEM+2,      // 第一次启动
    TB_USERTRACK_EVENT_SYSTEM_START             = TB_USERTRACK_EVENT_SYSTEM+3,      // 启动
    TB_USERTRACK_EVENT_SYSTEM_END               = TB_USERTRACK_EVENT_SYSTEM+4,      // 退出
    TB_USERTRACK_EVENT_SYSTEM_LOCATION          = TB_USERTRACK_EVENT_SYSTEM+5,      // 地理位置
    TB_USERTRACK_EVENT_SYSTEM_REGISTER          = TB_USERTRACK_EVENT_SYSTEM+6,      // 用户注册
    TB_USERTRACK_EVENT_SYSTEM_USER_LOGIN        = TB_USERTRACK_EVENT_SYSTEM+7,      // 用户登录
    TB_USERTRACK_EVENT_SYSTEM_USER_LOGOUT       = TB_USERTRACK_EVENT_SYSTEM+8,      // 用户登出
    TB_USERTRACK_EVENT_SYSTEM_BECAME_ACTIVE     = TB_USERTRACK_EVENT_SYSTEM+9,      // 程序激活
    TB_USERTRACK_EVENT_SYSTEM_ENTER_BACKGROUND  = TB_USERTRACK_EVENT_SYSTEM+10,     // 程序进入后台
    
    TB_USERTRACK_EVENT_PAGE                     = 2000,
    TB_USERTRACK_EVENT_PAGE_ENTER               = TB_USERTRACK_EVENT_PAGE+1,        // 进入页面
    TB_USERTRACK_EVENT_PAGE_LEAVE               = TB_USERTRACK_EVENT_PAGE+2,        // 离开页面
    TB_USERTRACK_EVENT_PAGE_CREATE              = TB_USERTRACK_EVENT_PAGE+3,        // 创建页面
    TB_USERTRACK_EVENT_PAGE_DESTROY             = TB_USERTRACK_EVENT_PAGE+4,        // 页面结束
    TB_USERTRACK_EVENT_PAGE_CLICK               = TB_USERTRACK_EVENT_PAGE+5,        // 页面点击
    TB_USERTRACK_EVENT_PAGE_CTL                 = TB_USERTRACK_EVENT_PAGE+100,      // 控件
    TB_USERTRACK_EVENT_PAGE_CTL_CLICKED         = TB_USERTRACK_EVENT_PAGE_CTL+1,    // 控件点击
    TB_USERTRACK_EVENT_PAGE_CTL_ITEM_SELECTED   = TB_USERTRACK_EVENT_PAGE_CTL+2,    // 条目选中
    TB_USERTRACK_EVENT_PAGE_CTL_LONG_CLICKED    = TB_USERTRACK_EVENT_PAGE_CTL+3,    // 长按
    TB_USERTRACK_EVENT_PAGE_CTL_SLIDE           = TB_USERTRACK_EVENT_PAGE_CTL+4,    // 滑动
    TB_USERTRACK_EVENT_PAGE_CTL_ROTATED         = TB_USERTRACK_EVENT_PAGE_CTL+5,    // 旋转
    
    TB_USERTRACK_EVENT_PERFORMANCE              = 3000,
    TB_USERTRACK_EVENT_PERFORMANCE_API_REQ      = TB_USERTRACK_EVENT_PERFORMANCE+1, // API 请求
    
    TB_USERTRACK_EVENT_NETWORK                  = 4000,
    TB_USERTRACK_EVENT_NETWORK_API_REQ          = TB_USERTRACK_EVENT_NETWORK+1,     // API 请求
    TB_USERTRACK_EVENT_NETWORK_PUSH_ARRIVE      = TB_USERTRACK_EVENT_NETWORK+2,     // 收到 Push 消息
    TB_USERTRACK_EVENT_NETWORK_PUSH_DISPLAY     = TB_USERTRACK_EVENT_NETWORK+3,     // Push 消息展现
    TB_USERTRACK_EVENT_NETWORK_PUSH_VIEW        = TB_USERTRACK_EVENT_NETWORK+4,     // 查看 Push 消息
    TB_USERTRACK_EVENT_NETWORK_SEARCH           = TB_USERTRACK_EVENT_NETWORK+5,     // 搜索
    TB_USERTRACK_EVENT_WEBPAGE                  = TB_USERTRACK_EVENT_NETWORK+6,     // WebView事件
    
    TB_USERTRACK_EVENT_SHARE                    = 5000,
    TB_USERTRACK_EVENT_SHARE_SINA_WEIBO         = TB_USERTRACK_EVENT_SHARE+1        // 新浪微博分享
};



