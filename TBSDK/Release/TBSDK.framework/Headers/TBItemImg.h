//
//  TBItemImg.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-7-10.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

//! TOP 中的实体，请参考 TOP 文档
@interface TBItemImg : TBModel {
    NSDecimalNumber     *_id;
    NSString            *url;
    NSUInteger           position;
    NSString            *created;
}

@property (copy) NSDecimalNumber *id;
@property (copy) NSString *url, *created;
@property (assign) NSUInteger position;

@end
