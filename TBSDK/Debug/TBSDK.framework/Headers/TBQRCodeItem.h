//
//  TBQRCodeItem.h
//  TBSDK
//
//  Created by chenyan on 11-8-8.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBModel.h"

@interface TBQRCodeItem : TBModel{
    NSString    *resultType;
    NSString    *content;
    NSString    *actionType;
    NSString    *targetUrl;
    NSString    *sellerId;
    NSString    *sellerNick;
}

@property (nonatomic, retain) NSString  *resultType;
@property (nonatomic, retain) NSString  *content;
@property (nonatomic, retain) NSString  *actionType;
@property (nonatomic, retain) NSString  *targetUrl;
@property (nonatomic, retain) NSString  *sellerId;
@property (nonatomic, retain) NSString  *sellerNick;

@end
