//
//  ETBannerItem.h
//  etao4iphone
//
//  Created by 稳 张 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ETBannerItemType {
    
    WebView = 1,
    SRPList = 2,
    SRPDetail = 3
    
};

@interface ETBannerItem : NSObject


/*
 imgurl: "http://img04.taobaocdn.com/tps/i4/T1SBKJXildXXXXXXXX-300-100.jpg",
 title: "棉衣",
 url: "",
 cat: "50080001",
 epid: "",
 seller: "当当网,淘宝商城",
 q: "手机",
 type: "2",
 test: "0"
 */

@property (nonatomic, assign) enum ETBannerItemType type;
@property (nonatomic, retain) NSString* backImgUrl;
@property (nonatomic, retain) NSString* bannerTitle;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString* cat;
@property (nonatomic, retain) NSString* epid;
@property (nonatomic, retain) NSString* seller;
@property (nonatomic, retain) NSString* q;
@property (nonatomic, retain) NSString* test;

@end
