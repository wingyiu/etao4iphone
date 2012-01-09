//
//  EtaoTimerController.m
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 11-12-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTimerController.h"
#import "EtaoTimeLabel.h"

@implementation EtaoTimerController

-(void)dealloc{
    [super dealloc];
}

+(NSMutableArray *)sharedTimeLabelPointerArray{
    
    static  NSMutableArray *timeLabelPointerArray = nil;
    
    if (timeLabelPointerArray == nil) {
        timeLabelPointerArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    return timeLabelPointerArray;
}
-(id)init{
    self = [super init];
    if (self) {
        
    }
    return  self;
}

- (void)startTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}

-(void)timerFireMethod:(NSTimer *)theTimer{
    
    NSEnumerator *e = [[EtaoTimerController sharedTimeLabelPointerArray] objectEnumerator];
    id label;
    while (label = [e nextObject]) {
        [label updateLabelText];
    }
}

-(void)stopTimer{
    [_timer invalidate];
}

@end
