//
//  EtaoUserTrackControllerDefine.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-11-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#ifndef etao4iphone_EtaoUserTrackControllerDefine_h
#define etao4iphone_EtaoUserTrackControllerDefine_h


enum PageController{
    Page_Home,              //主界面
    Page_VersionInfo,       //设置说明界面（目前合在一起）
    Page_UserFeedBack,      //用户反馈
    //搜索输入法不占用界面。
    Page_ComparePrice,      //全网比价
    Page_GroupBuy,          //团购
    Page_ReartimePrice,     //实时降价
    Page_CompareHistory,    //比价历史列表
    Page_CategorySearch,    //类目搜索
    Page_SRP,               //搜索商品列表
    Page_CategoryFilter,    //类目筛选
    Page_Buzzword,          //热门词汇
    Page_ItemDetail,        //详情页
    Page_ItemMoreInfo,      //详细参数
    Page_ItemComment,       //用户评论
    Page_WapView,           //内嵌Wap页面
    Page_UpdateNotify,      //升级提示
    Page_GroupBuyListMode,  //团购列表
    Page_GroupBuyMapMode,   //团购地图
    Page_GroupBuyDetail,    //团购详情
    Page_GroupBuyMapMode,   //团购地图页面    
    Page_ReartimePriceWaterfallMode,   //实时降价瀑布流
    Page_ReartimeSetting,   //实时降价设置页面
    Page_ReartimePricePrice9squareMode,       //实时降价九宫格视图（目前暂时没有用到）
    Page_ReartimePriceListMode,    //实时降价列表
    Page_ReartimePriceDetail,      //实时降价详情页
    Page_SearchInputPage,   //搜索输入页面（包含搜索联想）
    //不断增加中
   
    //特殊的定义
    
    //iPhone
    
    //Android
}

enum  PageButton{
    //主页
    Button-Search,          //搜索按钮
    Button-ComparePrice,    //全网比价按钮
    Button-GroupBuy,		//团购按钮
    Button-ReartimePrice,	//实时降价按钮
    
    //搜索联想
    Button-ClearnHistory,   //清除搜索历史
    
    //搜索列表
    Button-Sort,            //排序按钮
    Button-Search,          //搜索按钮
    Button-CategoryFilter,	//筛选按钮
    Button-SelectIndex,     //点击List中的一条
    
    //详情页
    Button-MoreInfo,		//更多参数
    Button-ItemComment,     //用户点评
    Button-SelectIndex,     //点击LIst中的一条
    
    //详情页-评价界面
    Button-Advantage,       //评论优点
    Button-Shortcoming,     //评论缺点
    Button-Experience,      //评论使用心得
    
    //全网比价
    Button-Search,          //搜索条
    Button-CompareHistory,	//比价历史
    Button-CategorySearch,	//类目搜索
    Button-Buzzword,		//热门词汇
    Button-SelectIndex,     //点选某一条
    Button-ClearnCompareHistory,    //清除比价历史
    
    //附近团购
    Button-ChangeMapMode,   //切换地图模式
    Button-ChangeListMode,  //切换列表模式
    Button-StyleAll,        //全部
    Button-StyleFood,       //美食
    Button-StyleLife,       //生活
    Button-StyleFun,        //娱乐
    Button-StylePositioning,//定位
    Button-ChooseRange,     //选择范围
    Button-SelectIndex,     //点选某一条
    Button-Detail,          //团购详情页
    Button-TeleCall,        //拨打电话
    Button-LookMap,         //查看地图
    Button-JumpWebPage,     //去看看
    
    //实时降价
    Button-WaterfallMode,      //瀑布流切换按钮
    Button-ListMode,           //列表页切换按钮
    Button-SettingDone,        //配置完成按钮
    Button-RefreshList,        //更新列表页
    Button-RefreshWaterfall,   //更新瀑布流
    Button-ReloadList,         //加载列表页
    Button-ReloadWaterfall,    //加载瀑布流
    Button-SelectIndexInList,          //列表页点选某一条
    Button-SelectIndexInWaterfall,     //瀑布流点悬某一条
    
    //实时降价详情页
    Button-Detail            //查看详情
    
    };

#endif
