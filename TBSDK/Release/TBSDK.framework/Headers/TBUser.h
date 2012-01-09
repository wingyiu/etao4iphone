//
//  TBUser.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-10.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBModel.h"

@class TBUserCredit;
@class TBLocation;

//! TOP 中的实体，请参考 TOP 文档
@interface TBUser : TBModel {
    NSDecimalNumber   *user_id;
    NSString    *nick;
    NSString    *sex;
    
    NSString    *created;
    NSString    *last_visit;
    NSString    *birthday;
    NSString    *type;
    
    BOOL        has_more_pic;
    
    NSString    *alipay_account;
    NSString    *alipay_no;
    
    TBUserCredit    *buyer_credit;
    TBUserCredit    *seller_credit;
    
    TBLocation      *location;
    
    NSString        *uid;
    NSUInteger      item_img_num;
    NSUInteger      item_img_size;
    NSUInteger      prop_img_num;
    NSUInteger      prop_img_size;
    
    NSString        *promoted_type;
    NSString        *auto_repost;
    NSString        *status;
    NSString        *alipay_bind;
    NSString        *consumer_protection;
    NSString        *email;
    BOOL            magazine_subscribe;
    NSString        *vertical_market;
    NSString        *avatar;
}

@property (nonatomic, copy)   NSDecimalNumber  *user_id;
@property (nonatomic, assign)   BOOL        has_more_pic;
@property (nonatomic, copy)     NSString    *nick, *sex, *created, *last_visit, *birthday, *type, *alipay_account, *alipay_no;
@property (nonatomic, retain)   TBUserCredit *buyer_credit, *seller_credit;
@property (nonatomic, retain)   TBLocation   *location;

@property (nonatomic, copy)	NSString        *uid;
@property (nonatomic, assign)	NSUInteger      item_img_num;
@property (nonatomic, assign)	NSUInteger      item_img_size;
@property (nonatomic, assign)	NSUInteger      prop_img_num;
@property (nonatomic, assign)	NSUInteger      prop_img_size;

@property (nonatomic, copy)	NSString        *promoted_type;
@property (nonatomic, copy)	NSString        *auto_repost;
@property (nonatomic, copy)	NSString        *status;
@property (nonatomic, copy)	NSString        *alipay_bind;
@property (nonatomic, copy)	NSString        *consumer_protection;
@property (nonatomic, copy)	NSString        *email;
@property (nonatomic, assign)	BOOL            magazine_subscribe;
@property (nonatomic, copy)	NSString        *vertical_market;
@property (nonatomic, copy)	NSString        *avatar;

@end
