//
//  ETLocationDataSource.m
//  etao4iphone
//
//  Created by 左 昱昊 on 12-1-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ETLocationDataSource.h"

@implementation ETLocationDataSource
@synthesize currentLocation = _currentLocation;

static ETLocationDataSource* shareLocationDataSource = nil;
static BOOL ImOpen = NO;


+ (CLLocation*)getLocation{
    if(shareLocationDataSource ==nil){
        //如果在数据中心直接取上次保存的数据
        ETLocationDataSource* datasource = [[ETDataCenter dataCenter] getDataSourceWithKey:[ETLocationDataSource keyName:nil]];
        if(datasource == nil){
            shareLocationDataSource = [[ETLocationDataSource alloc]init];
            [[ETDataCenter dataCenter] addDataSource:shareLocationDataSource withKey:[ETLocationDataSource keyName:nil]];
        }
        else{
            shareLocationDataSource = datasource;
        }
        
        switch ([ETLocation location].status) {
            case ET_LOCATION_STOP://打开定位
                [[ETLocation location] on];
                ImOpen = YES;
                break;
            case ET_LOCATION_STOP_ENABLE://定位曾经被打开过，直接取数据
                [ETLocation location].currentLocation;
            default://其他情况都是直接监视
                break;
        }
        //添加监视
        [[ETLocation location] addObserver:shareLocationDataSource 
                                forKeyPath:@"status" 
                                   options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                                   context:nil];
    }
    
    return shareLocationDataSource.currentLocation;
}

- (void)dealloc{
    //移出监视
    [[ETLocation location] removeObserver:self forKeyPath:@"status"];
    shareLocationDataSource = nil;
    [super dealloc];
}

#pragma mark -V events respond callback
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isKindOfClass:[ETLocation class]]){
        ET_LOCATION_STATUS status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case ET_LOCATION_OK: //数据加载完成
                self.currentLocation = [[ETLocation location].currentLocation copy];
                if(ImOpen){
                    ImOpen=NO;
                    [[ETLocation location] off];
                }
                break;
            default:
                break;
        }
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
    
    NSArray* array = [[[NSArray alloc]initWithObjects:latitude,longitude,nil]autorelease];
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)deserializing:(NSString *)key{
    
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSMutableArray* array = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];

    NSString* str0 = [array objectAtIndex:0];
    NSString* str1 = [array objectAtIndex:1];
    
    CLLocationDegrees latitude = [str0 floatValue];
    CLLocationDegrees longitude = [str1 floatValue];
    CLLocation* location = [[[CLLocation alloc]initWithLatitude:latitude longitude:longitude]autorelease];
    self.currentLocation = location;
    
}

- (NSString*)className{
    return @"ETLocationDataSource";
}

+ (NSString*)keyName:(NSString*)str{
    return @"current_location";
}
@end