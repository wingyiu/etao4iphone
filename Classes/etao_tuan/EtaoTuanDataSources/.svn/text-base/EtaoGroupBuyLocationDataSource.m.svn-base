//
//  EtaoGroupBuyLocationDataSource.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoGroupBuyLocationDataSource.h"

@implementation EtaoGroupBuyLocationDataSource
@synthesize status = _status;
@synthesize currentCity = _currentCity;
@synthesize currentLocation = _currentLocation;
@synthesize currentPosition = _currentPosition;
@synthesize realityCity = _realityCity;

- (id)init{
    self = [super init];
    if(self){
        _isCheck = NO;
        [[ETLocation location] addObserver:self 
                                forKeyPath:@"status" 
                                   options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                                   context:nil];
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
    [[ETLocation location] removeObserver:self forKeyPath:@"status"];
    
    [_currentPosition release];
    [_currentLocation release];
    [_currentCity release];
}

#pragma mark -V events respond callback
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isKindOfClass:[ETLocation class]]){
        ET_LOCATION_STATUS status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case ET_LOCATION_LOADING: //加载中
                self.status = ET_DS_GROUPBUY_LOCATION_LOCAL;
                break;
            case ET_LOCATION_OK: //数据加载完成
                if (!_isCheck){
                    _isCheck = YES;
                    self.status = ET_DS_GROUPBUY_LOCATION_OK;
                    self.realityCity = [ETLocation location].currentCity;
                    if(![[ETLocation location].currentCity isEqualToString:_currentCity]){
                        [self changeCityCallBack:[ETLocation location].currentCity];
                    }
                    else{
                        self.status= ET_DS_GROUPBUY_LOCATION_CHANGE; //状态有改变
                    }
                } 
                
                break;
            case ET_LOCATION_ONLYGPSOK: //加载城市数据中
                self.status = ET_DS_GROUPBUY_LOCATION_GPSOK;
                [self  changeLocation:[ETLocation location].currentLocation 
                              andCity:nil 
                          andPosition:nil];
                break;
            case ET_LOCATION_FAIL:
            case ET_LOCATION_DISABLE:
            case ET_LOCATION_STOP_DISABLE:
                self.status = ET_DS_GROUPBUY_LOCATION_GPSFAIL;
                break;
            default:
                break;
        }
    }
}

#pragma mark -V APIs

- (void)changeLocation:(CLLocation*)location 
               andCity:(NSString*)city 
           andPosition:(NSString *)position{
    
    if([location isEqual:self.currentCity] && [city isEqual:self.currentCity] && [city isEqualToString:@""])return;
    
    if(nil!=location)self.currentLocation = location;
    if(nil!=city){
        self.currentCity = city;
    }
    if(nil!=position){
        self.currentPosition = position;
    }
    self.status= ET_DS_GROUPBUY_LOCATION_CHANGE; //状态有改变
}

- (void)check{
    _isCheck = NO;
    ET_LOCATION_STATUS status =  [ETLocation location].status;
    if(status == ET_LOCATION_DISABLE || 
       status == ET_LOCATION_FAIL){
        self.status = ET_DS_GROUPBUY_LOCATION_GPSFAIL;
    }
}


-(void) changeCityCallBack:(NSString*) cityName {
    _isCheck = YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"城市切换" 
                                                    message:[NSString stringWithFormat:@"是否切换您当前所在城市：%@",cityName]
                                                   delegate:self cancelButtonTitle:@"继续浏览" otherButtonTitles:@"立即切换", nil];
    alert.delegate = self;
    [alert show];
    [alert release];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView buttonTitleAtIndex:buttonIndex] == @"立即切换") {
       [self  changeLocation:[ETLocation location].currentLocation andCity:[ETLocation location].currentCity andPosition:[ETLocation location].currentPosition];
    }
    else{
        self.status= ET_DS_GROUPBUY_LOCATION_CHANGE; //状态有改变
    }
}

#pragma mark -V Serializing
/* 序列化接口 */
- (void)serializing:(NSString *)key{
    NSString* latitude = [NSString stringWithFormat:@"%f",_currentLocation.coordinate.latitude];
    NSString* longitude = [NSString stringWithFormat:@"%f",_currentLocation.coordinate.longitude];
    
    if(latitude == nil){
        latitude = @"0.0";
    }
    if(longitude == nil){
        longitude = @"0.0";
    }
    if(_currentCity ==nil){
        _currentCity = @"选择城市";
    }
    if(_currentPosition ==nil){
        _currentPosition = @"未知";
    }
    
    
    NSArray* array = [[[NSArray alloc]initWithObjects:_currentCity,_currentPosition,latitude,longitude,nil]autorelease];
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)deserializing:(NSString *)key{

    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSMutableArray* array = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    self.currentCity = [array objectAtIndex:0];
    self.currentPosition = [array objectAtIndex:1];
    NSString* str2 = [array objectAtIndex:2];
    NSString* str3 = [array objectAtIndex:3];
    
    CLLocationDegrees latitude = [str2 floatValue];
    CLLocationDegrees longitude = [str3 floatValue];
    CLLocation* location = [[[CLLocation alloc]initWithLatitude:latitude longitude:longitude]autorelease];
    self.currentLocation = location;

    self.status = ET_DS_GROUPBUY_LOCATION_LOCAL; //本地状态
    
}

- (NSString*)className{
    return @"EtaoGroupBuyLocationDataSource";
}

+ (NSString*)keyName:(NSString *)str{
    return [NSString stringWithFormat:@"groupbuy_location"];
}


@end
