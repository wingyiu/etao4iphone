//
//  TBPropList.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-8-7.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"


//! TOP 中的实体，请参考 TOP 文档
@interface TBPropList : TBModel {
    int   cid;
    int   pid;
    NSString    *name;
    
    NSMutableArray     *props;
}

@property (nonatomic, assign) int cid, pid;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, retain) NSMutableArray  *props;

@end
