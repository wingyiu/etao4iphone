//
//  TBLocation.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-22.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"


//! TOP 中的实体，请参考 TOP 文档
@interface TBLocation : TBModel {
    NSString	*zip;
    NSString	*address;
    NSString	*city;
    NSString	*state;
    NSString	*country;
    NSString	*district;
}

@property (nonatomic, copy)	NSString	*zip;
@property (nonatomic, copy)	NSString	*address;
@property (nonatomic, copy)	NSString	*city;
@property (nonatomic, copy)	NSString	*state;
@property (nonatomic, copy)	NSString	*country;
@property (nonatomic, copy)	NSString	*district;

@end
