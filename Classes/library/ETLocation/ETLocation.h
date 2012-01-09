//
//  ETLocation.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//#define ETLOCATION_DEBUG
/*
 * 订阅模式，单例模式，使用者遵循以下几步
 * 1.使用 [ETLocation location]获得一个实例
 * 2.添加observe方法到监听的字段status
 * 3.判断当前状态,根据需要获取数据。
 * 4.使用stop方法终止
 */

//定位状态列表
typedef enum {
    ET_LOCATION_STOP = 0,   //最初状态
    ET_LOCATION_LOADING,    //GPS加载中，这时候没有数据可用
    ET_LOCATION_ONLYGPSOK,  //经纬度坐标可用，地理信息不可用状态，这时候可以去取经纬度
    ET_LOCATION_OK,         //经纬度和地理信息都可用的一个状态
    ET_LOCATION_FAIL,       //定位失败
    ET_LOCATION_DISABLE,    //定位功能被用户关闭
    ET_LOCATION_STOP_ENABLE,//定位被停止，但数据可用
    ET_LOCATION_STOP_DISABLE//定位被停止，数据不可用
}ET_LOCATION_STATUS;

//主类
@interface ETLocation : NSObject
<NSCopying ,CLLocationManagerDelegate ,MKReverseGeocoderDelegate> {
    
    CLLocation* _currentLocation;
    NSString* _currentCity;
    NSString* _currentPosition;
    
    NSString* _locationCity;
    
    BOOL isStart;
    ET_LOCATION_STATUS status;
    
}
@property (atomic,retain) CLLocation* currentLocation;
@property (atomic,retain) NSString* currentCity;
@property (atomic,retain) NSString* currentPosition;
@property (atomic,assign) BOOL isStart;
@property (atomic,assign) ET_LOCATION_STATUS status;

+ (ETLocation*)location;  //获取一个实例
- (void)on;               //开始定位,并释放单例对象
- (void)off;              //终止定位,并释放单例对象

@end

