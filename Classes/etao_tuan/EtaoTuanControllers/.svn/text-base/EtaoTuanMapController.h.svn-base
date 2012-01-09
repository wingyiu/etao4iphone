//
//  EtaoTuanMapController.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#ifndef ETAO_TUAN_MAP_CONTROLLER
#define ETAO_TUAN_MAP_CONTROLLER

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "EtaoGroupBuyAuctionDataSource.h"
#import "EtaoGroupBuyLocationDataSource.h"
#import "EtaoTuanDetailSwipeController.h"
#import "EtaoTuanListDetailController.h"
#import "ETPageSwipeController.h"


#ifndef MAP_HEIGHT
#define MAP_HEIGHT 252
#endif

#ifndef DISTANCE
#define DISTANCE 5000
#endif

@interface EtaoTuanMapController : UIViewController <MKMapViewDelegate,ETPageSwipeDelegate>{
    NSMutableArray* _items;
    
    MKMapView *_mapView;
    NSString* _datasourceKey;
    
    BOOL _notification_lock;
    int _last_selected;
}
@property (nonatomic,retain) NSString* datasourceKey;
/* 监视函数 */
- (void)watchWithDatasource:(id)datasource;
- (void)watchWithKey:(NSString*)key;

- (NSString *)imageNameForAnnotaion:(id <MKAnnotation>)annotation;
- (void)items2items:(NSMutableArray*)items1 toItems:(NSMutableArray*)items2;

@end

#endif