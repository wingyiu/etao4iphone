//
//  ETLocation.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETLocation.h"

static CLLocationManager* shareLocationManager = nil; //静态全局变量
static MKReverseGeocoder* shareReverseGeocoder = nil;
static ETLocation* shareLocation = nil;
static NSThread* locationWorkThread = nil;

@implementation ETLocation
@synthesize currentCity = _currentCity;
@synthesize currentLocation = _currentLocation;
@synthesize currentPosition = _currentPosition;
@synthesize isStart = isStart;
@synthesize status = status;

+ (void)initialize{
    if( self == [ETLocation class]){
        shareLocationManager = [[CLLocationManager alloc]init];
        shareLocationManager.desiredAccuracy = 10.0f;  //定位间隔，10米
    }
}

+ (ETLocation*)location{
    if(shareLocation == nil){
        shareLocation =  [[self alloc]init];
        shareLocation.isStart = NO;
        shareLocation.status = ET_LOCATION_STOP;
        shareLocationManager.delegate = shareLocation;
    }
    return shareLocation;
}

+ (NSThread *)threadForLocation{
	if (locationWorkThread == nil) {
		@synchronized(self) {
			if (locationWorkThread == nil) {
				locationWorkThread = [[NSThread alloc] initWithTarget:self selector:@selector(runLocation) object:nil];
				[locationWorkThread start];
			}
		}
	}
	return locationWorkThread;
}

+ (void)runLocation
{
	CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
	CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
	CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    
    BOOL runAlways = YES;
	while (runAlways) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		CFRunLoopRun();
		[pool drain];
	}

	CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
	CFRelease(source);
}

- (void)on{
    if(!isStart){
        isStart = YES;
        [self performSelector:@selector(main) 
                     onThread:[[self class] threadForLocation] 
                   withObject:nil 
                waitUntilDone:NO];
    }
}

- (void)off{
    isStart = NO;
    //停止定位
    [shareLocationManager stopUpdatingLocation];
    //结束线程循环
    CFRunLoopStop(CFRunLoopGetCurrent());
    
//  //清空单例对象
//    [shareLocation release];
//    shareLocation = nil;
    
    //清空地理信息
    [shareReverseGeocoder release];
    shareReverseGeocoder = nil;
    
    if(self.status == ET_LOCATION_OK)self.status = ET_LOCATION_STOP_ENABLE;
    else self.status = ET_LOCATION_STOP_DISABLE;
}

#pragma mark -v Thread
/*线程主函数*/
//- (void)start{
//    isStart = YES;
//    [self performSelector:@selector(main) 
//                 onThread:[[self class] threadForLocation] 
//               withObject:nil 
//            waitUntilDone:NO];
//}
//
//- (BOOL)isFinished{
//    return isStart;
//}
//
//- (BOOL)isConcurrent{
//    return  YES;
//}

- (void)main{
    [shareLocationManager startUpdatingLocation];
    self.status = ET_LOCATION_LOADING;
}

#pragma mark -v Location
/*代理函数*/
//一次成功定位
- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation{
    
#if TARGET_IPHONE_SIMULATOR
    CLLocation* emulocation = [[[CLLocation alloc]initWithLatitude:31.230381 longitude:121.473727]autorelease];
    self.currentLocation = emulocation ;

#elif TARGET_OS_IPHONE

    self.currentLocation = newLocation;
    
#endif
    if(self.status == ET_LOCATION_OK){
        self.status = ET_LOCATION_OK;
    }
    
#ifdef ETLOCATION_DEBUG
    NSLog(@"%f,%f",self.currentLocation.coordinate.latitude,self.currentLocation.coordinate.longitude);
#endif
    
    //如果这次定位是成功的，发起一次城市请求
    if (nil == shareReverseGeocoder){
        shareReverseGeocoder =[[MKReverseGeocoder alloc] initWithCoordinate:_currentLocation.coordinate];  
        shareReverseGeocoder.delegate = self; 
        [shareReverseGeocoder performSelector:@selector(start) 
                                     onThread:[[self class] threadForLocation] 
                                   withObject:nil 
                                waitUntilDone:NO];
        self.status = ET_LOCATION_ONLYGPSOK;
    }
}
//一次失败定位
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    self.currentLocation = nil;
    self.currentCity = nil;
    self.currentPosition = nil;
    self.status = ET_LOCATION_FAIL;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)stat{
    switch (stat) {
        case kCLAuthorizationStatusNotDetermined: //用户正在抉择是否打开
            self.status = ET_LOCATION_STOP;
            break;
        case kCLAuthorizationStatusRestricted: //oh，no，用户无法打开定位,权限控制
        case kCLAuthorizationStatusDenied: //oh，no，用户拒绝打开定位
            self.currentLocation = nil;
            self.currentCity = nil;
            self.currentPosition = nil;
            self.status = ET_LOCATION_DISABLE;
            break;
        case kCLAuthorizationStatusAuthorized: //用户允许打开定位
            break;
        default:
            break;
    }
}

#pragma mark -v Position
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
    
    //如果有杭州市，需要把"市"干掉～
    if([[placemark.locality substringWithRange:NSMakeRange(placemark.locality.length-1, 1)] isEqualToString:@"市"]){
        NSString* tmp = [placemark.locality substringWithRange:NSMakeRange(0, placemark.locality.length-1)];
        self.currentCity = tmp;
    }
    else{
        self.currentCity = placemark.locality;
    }
    
    self.currentPosition = [NSString stringWithFormat:@"%@%@%@%@", 
                          placemark.administrativeArea,
                          placemark.locality,
                          placemark.subLocality,
                          placemark.thoroughfare];
    
    self.status = ET_LOCATION_OK;
}
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
    //如果失败，继续在另一个线程发起阻塞请求
    [shareReverseGeocoder performSelector:@selector(start) 
                                 onThread:[[self class] threadForLocation] 
                               withObject:nil 
                            waitUntilDone:NO];  
}

@end
