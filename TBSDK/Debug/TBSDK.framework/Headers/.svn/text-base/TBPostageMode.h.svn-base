//
//  TBPostageMode.h
//  TBSDK
//
//  Created by Nowa on 10-6-30.
//  Copyright 2010 nowa.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import	"TBModel.h"

//! 运送方式
typedef enum {
    TBPostageModeTypeSeller,
    TBPostageModeTypePost,
    TBPostageModeTypeExpress,
    TBPostageModeTypeEMS,
    TBPostageModeTypeVirtual,
    TBPostageModeTypeExpressCorp,
    TBPostageModeTypePostFast
} TBPostageModeType;


//! TOP 中的实体，请参考 TOP 文档
@interface TBPostageMode : TBModel {
	NSString				*postage_id;
	NSString				*_id;
	NSString				*type;
	NSString				*dests;
	NSString				*price;
	NSString				*increase;
}


//! TOP 中的运送方式类型ID和Wap中不一样
+ (NSString *)wapModeIdForType:(TBPostageModeType)type;

//! 返回对应运送方式的名称
+ (NSString *)modeNameForType:(NSString *)type;

//! 获取对应Wap中的运送方式ID
- (NSString *)wapModeId;

//! 获取运送方式的名称
- (NSString *)modeName;

//! 获取运送方式的字符串，如 首件10.0元, 加件2.0元
- (NSString *)postageString;

@property (nonatomic, copy) NSString *postage_id, *id, *type, *dests, *price, *increase;

@end
