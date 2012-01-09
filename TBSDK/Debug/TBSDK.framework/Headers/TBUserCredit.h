//
//  TBUserCredit.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-7-16.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"


//! TOP 中的实体，请参考 TOP 文档
@interface TBUserCredit : TBModel {
    int     level;
    int     score;
    int     total_num;
    int     good_num;
    
}


/*!
 获取对应等级的图片名称
 @param grade   信用等级
 @param isBuyer 是否为买家
 */
+ (NSString *)gradeImage:(int)grade isBuyer:(BOOL)isBuyer;

//! 根据信用分数获取等级
+ (int)gradeOfScore:(int)score;

//! 获取等级图片名称
- (NSString *)gradeImage:(BOOL)isBuyer;

//! 获取好评率
- (float)goodScoreRadio;

@property (assign) int level, score, total_num, good_num;

@end
