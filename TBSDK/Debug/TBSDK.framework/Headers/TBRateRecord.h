//
//  TBRateRecord.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-9-19.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"


//! 评价记录信息
@interface TBRateRecord : TBModel {
    NSDecimalNumber     *_id;
    NSString            *rateContent;
    NSString            *rateDate;
    NSString            *displayRatePic;
    NSString            *displayUserNick;
    NSInteger           dispalyRateLevel1;
    NSInteger           dispalyRateLevel2;
    NSInteger           dispalyRateSum;
    BOOL                anony;
}

//! 获取这个评价记录的用户等级
- (NSUInteger)userGrade;

@property (nonatomic, copy) NSDecimalNumber     *id;
@property (nonatomic, copy)	NSString            *rateContent;
@property (nonatomic, copy)	NSString            *rateDate;
@property (nonatomic, copy)	NSString            *displayRatePic;
@property (nonatomic, copy)	NSString            *displayUserNick;
@property (nonatomic, assign)	NSInteger           dispalyRateSum;
@property (nonatomic, assign)   NSInteger           dispalyRateLevel1, dispalyRateLevel2;
@property (nonatomic, assign)	BOOL                anony;

@end
