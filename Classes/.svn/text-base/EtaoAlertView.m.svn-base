//
//  etaoAleartView.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoAlertView.h"
#import <QuartzCore/QuartzCore.h>

@implementation EtaoAlertView

@synthesize m_delegate;


-(id)initBackGroundImage:(UIImage*)img 
                delegate:(id)delegate
                   title:(NSString*)title 
                 message:(NSString*)message 
                 //  width:(CGFloat)width
                 buttons:(NSArray*)buttons
             buttonimage:(UIImage*)buttonImg
{
    self = [super init];
    if(self)
    {
        self.m_delegate = delegate;
        self.frame = CGRectMake(0, 0, 320, 480);
        self.backgroundColor = [UIColor clearColor];
        if(buttons.count == 0)
        {
            [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(hiddenAlert) userInfo:nil repeats:NO];
        }
        
        UIView *showView = [[UIView alloc] init];
        
        int width = img.size.width;
        int height = img.size.height;
        
        showView.frame = CGRectMake(0, 0, width, height);
        
        
        UILabel *labTitle = [[UILabel alloc] init];
        UILabel *labMessage = [[UILabel alloc] init];
        
        labTitle.textAlignment = UITextAlignmentCenter;
        labMessage.textAlignment = UITextAlignmentCenter;
        
        labTitle.backgroundColor = [UIColor clearColor];
        labTitle.font = [UIFont systemFontOfSize:17];
        labTitle.textColor = [UIColor whiteColor];
        labTitle.text = title;
        UIFont *font = [UIFont systemFontOfSize:17];
        CGSize size = CGSizeMake(width-20,2000);
        CGSize labelsize = [title sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        if(labelsize.width<width-20)
            labTitle.frame = CGRectMake(10, 5, width-20, labelsize.height);
        else
            labTitle.frame = CGRectMake(10, 5, labelsize.width, labelsize.height);
        
        labTitle.numberOfLines = 0;
        
        labMessage.backgroundColor = [UIColor clearColor];
        labMessage.font = [UIFont systemFontOfSize:15];
        labMessage.textColor = [UIColor whiteColor];
        labMessage.text = message;
        UIFont *font2 = [UIFont systemFontOfSize:15];
        CGSize size2 = CGSizeMake(width-20,2000);
        CGSize labelsize2 = [message sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:UILineBreakModeWordWrap];
        if(labelsize2.width < width-20)
            labMessage.frame = CGRectMake(10, labelsize.height+15, width-20, labelsize2.height);
        else
            labMessage.frame = CGRectMake(10, labelsize.height+15, labelsize2.width, labelsize2.height);
        
        labMessage.numberOfLines = 0;
        
        [showView addSubview:labTitle];
        [showView addSubview:labMessage];
        
        
        
        //添加button
        NSInteger buttonHeight = 0;
        if(buttons.count==2)
        {
            for(int i=0;i<buttons.count;i++)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundImage:buttonImg forState:UIControlStateNormal];
                btn.frame = CGRectMake((i+1)*10 + i*((width-30)/2), labMessage.frame.size.height + labMessage.frame.origin.y + 20, (width-30)/2, 30);
                btn.tag = i+1;
                [btn setTitle:[buttons objectAtIndex:i] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnClidk:) forControlEvents:UIControlEventTouchUpInside];
                [showView addSubview:btn];
            }
            buttonHeight = 50;
        }
        else
        {
            for(int i=0;i<buttons.count;i++)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundImage:buttonImg forState:UIControlStateNormal];
                btn.frame = CGRectMake(10, labMessage.frame.size.height + labMessage.frame.origin.y + 20 + i*45, width-20, 30);
                btn.tag = i+1;
                [btn setTitle:[buttons objectAtIndex:i] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnClidk:) forControlEvents:UIControlEventTouchUpInside];
                [showView addSubview:btn];
            }
            buttonHeight = buttons.count* 45+10;
        }
        
        
        showView.backgroundColor = [UIColor colorWithPatternImage:img];
        showView.alpha = 0.6;
        
        showView.layer.cornerRadius = 8;
        showView.layer.borderWidth = 2;
        showView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        showView.layer.masksToBounds = YES;
        
//        CAKeyframeAnimation * animation; 
//        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
//        animation.duration = 0.3; 
//        animation.delegate = self;
//        animation.removedOnCompletion = YES;
//        animation.fillMode = kCAFillModeForwards;

//出现时，抖动效果。
//        NSMutableArray *values = [NSMutableArray array];
//        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]]; 
//        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]]; 
//        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]]; 
//        
//        animation.values = values;
//        [showView.layer addAnimation:animation forKey:nil];
        
        [self addSubview:showView];
        
        int tempHeight = labTitle.frame.size.height+labMessage.frame.size.height + 25+buttonHeight;

        if( tempHeight < height) {
            tempHeight = height;
        }
        
        showView.frame = CGRectMake(0, 0, width, tempHeight);//labTitle.frame.size.height+labMessage.frame.size.height + 25+buttonHeight);
        showView.center = self.center;
        
        [labTitle release];
        [labMessage release];
        
        [showView release];
        
    }
    return self;
}

-(IBAction)btnClidk:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [m_delegate myAlertViewClickButtonIndex:self buttonIndex:btn.tag];
}


-(void)hiddenAlert
{
    [self dismissMyAlertView];
}


-(void)dismissMyAlertView
{
    [UIView beginAnimations:@"hidden" context:nil];
    self.alpha = 0;
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
}


-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [self removeFromSuperview];
}


-(void)dealloc
{
    [super dealloc];
}

@end
