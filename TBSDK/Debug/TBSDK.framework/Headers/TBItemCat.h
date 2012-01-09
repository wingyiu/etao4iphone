//
//  TBItemCat.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-21.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBModel.h"

//! TOP 中的实体，请参考 TOP 文档
@interface TBItemCat : TBModel {
    NSUInteger   cid;
    NSUInteger   parent_cid;
    NSString    *name;
    BOOL         is_parent;
    NSString    *status;
    NSUInteger   sort_order;
}

@property (nonatomic, assign) NSUInteger cid, parent_cid, sort_order;
@property (nonatomic, assign) BOOL is_parent;
@property (nonatomic, retain) NSString *name, *status;

@end
