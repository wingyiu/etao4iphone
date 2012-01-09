//
//  EtaoLabel.m
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 11-12-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTimeLabel.h"
#import "EtaoTimerController.h"

@implementation EtaoTimeLabel

@synthesize item = _item;

- (void)dealloc{
    
    if (_item != nil) {
        [_item release];
        _item = nil;
    }

    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)showLabelText{
    
    NSTimeInterval currentTime = [[NSDate date]timeIntervalSince1970];
    NSTimeInterval endTime = [_item.endTime doubleValue];
    timeRest = endTime - currentTime;
    
    NSInteger subTime = endTime-currentTime;
    int days = (((int)subTime)/(3600*24))>0?(((int)subTime)/(3600*24)):0;
    int hours = (((int)subTime%(3600*24))/3600)>0?(((int)subTime%(3600*24))/3600):0;
    int minutes = (((int)subTime%(3600*24)%3600)/60)>0?(((int)subTime%(3600*24)%3600)/60):0;
    int seconds = ((int)subTime%(3600*24)%3600%60)>0?((int)subTime%(3600*24)%3600%60):0;
    NSString *time = [[NSString alloc]initWithFormat:@"%d天%d时%d分%d秒",days,hours,minutes,seconds];            
    self.text = time;
    
    /*     
     NSCalendar *cal = [NSCalendar currentCalendar];
     NSDateComponents *deadTime = [[NSDateComponents alloc]init];
     
     NSInteger endTime = [_item.endTime integerValue];
     int days = (((int)endTime)/(3600*24))>0?(((int)endTime)/(3600*24)):0;
     int hours = (((int)endTime%(3600*24))/3600)>0?(((int)endTime%(3600*24))/3600):0;
     int minutes = (((int)endTime%(3600*24)%3600)/60)>0?(((int)endTime%(3600*24)%3600)/60):0;
     int seconds = ((int)endTime%(3600*24)%3600%60)>0?((int)endTime%(3600*24)%3600%60):0;
     
     [deadTime setDay:days ];
     [deadTime setHour:hours];
     [deadTime setMinute:minutes];
     [deadTime setSecond:seconds];
     
     NSDate *todate = [cal dateFromComponents:deadTime];
     [deadTime release];
     
     NSDate *today = [NSDate date];
     unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
     NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
     _timeL.text = [NSString stringWithFormat:@"%d天%d时%d分%d秒", [d day], [d hour], [d minute], [d second]];     
*/
}

-(void)updateLabelText{
    timeRest = timeRest - 1;
    int days = (((int)timeRest)/(3600*24))>0?(((int)timeRest)/(3600*24)):0;
    int hours = (((int)timeRest%(3600*24))/3600)>0?(((int)timeRest%(3600*24))/3600):0;
    int minutes = (((int)timeRest%(3600*24)%3600)/60)>0?(((int)timeRest%(3600*24)%3600)/60):0;
    int seconds = ((int)timeRest%(3600*24)%3600%60)>0?((int)timeRest%(3600*24)%3600%60):0;
    NSString *time = [[NSString alloc]initWithFormat:@"%d天%d时%d分%d秒",days,hours,minutes,seconds];            
    self.text = time;
}
@end
