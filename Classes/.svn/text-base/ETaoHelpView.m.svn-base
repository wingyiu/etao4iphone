//
//  ETaoHelpView.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETaoHelpView.h"

@implementation ETaoHelpView
@synthesize image = _image ;
@synthesize name = _name;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) dealloc {
    [_image release];
    [_name release];
    [super dealloc];
}
- (id)initWithImage:(UIImage*) image withName:(NSString*) name{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.image = image ;
        self.name = name ;
        UIButton *btn = [[[UIButton alloc]initWithFrame:self.frame]autorelease];
        [btn setImage:_image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside]; 
        self.alpha = 1.0 ;
        [self addSubview:btn];
        // Initialization code
    }
    return self; 
    
}
- (void) buttonClick {
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:__ETAO_VERSION__];
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:[NSString stringWithFormat:@"%@_last_update_time",_name]];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4]; 
    [self removeFromSuperview];
    [UIView commitAnimations]; 
    
 //   NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
 //   NSTimeInterval now = [dat timeIntervalSince1970]; 
 //   NSString* nowTime = [NSString stringWithFormat:@"%.0f",now];

}
- (void) show { 

  
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@_last_update_time",_name]];
    if (arrayData != nil) { 
        NSString *strTime = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData]; 
        if ([ strTime compare:__ETAO_VERSION__] <= 0) {
            return ;
        } 
    } 
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
