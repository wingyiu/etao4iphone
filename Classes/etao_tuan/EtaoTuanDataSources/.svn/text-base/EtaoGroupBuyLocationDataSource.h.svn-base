//
//  EtaoGroupBuyLocationDataSource.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETDataCenter.h"
#import "ETLocation.h"

/* 状态迁移图问霜天 */
typedef enum{
    ET_DS_GROUPBUY_LOCATION_LOCAL = 0, //初始状态，本地数据
    ET_DS_GROUPBUY_LOCATION_OK,        //数据有变化，快来读取啊
    ET_DS_GROUPBUY_LOCATION_GPSOK,
    ET_DS_GROUPBUY_LOCATION_GPSFAIL,
    ET_DS_GROUPBUY_LOCATION_CHANGE
}ET_DS_GROUPBUY_LOCATION_STATUS;

@interface EtaoGroupBuyLocationDataSource : NSObject <ETDataCenterProtocal>{
    NSString* _currentCity;
    NSString* _currentPosition;
    CLLocation* _currentLocation;
    NSString* _realityCity;
    
    ET_DS_GROUPBUY_LOCATION_STATUS _status;
    
    BOOL _isCheck;
}
@property (nonatomic,retain) NSString* realityCity;
@property (nonatomic,retain) NSString* currentCity;
@property (nonatomic,retain) NSString* currentPosition;
@property (nonatomic,retain) CLLocation* currentLocation;
@property (nonatomic,assign) ET_DS_GROUPBUY_LOCATION_STATUS status;

- (void)changeLocation:(CLLocation*)location andCity:(NSString*)city andPosition:(NSString*)position;
- (void)changeCityCallBack:(NSString*) cityName;
- (void)check;

@end
