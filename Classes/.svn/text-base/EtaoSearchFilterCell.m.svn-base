//
//  EtaoSearchFilterCell.m
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 11-12-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "EtaoSearchFilterCell.h"
#import "EtaoAuctionSearchCategoryFilterViewController.h"

@implementation EtaoSearchFilterCell

@synthesize delegate = _delegate;


- (void)dealloc{
    _delegate = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}

- (NSArray*)_getFrames:(NSArray*)texts{ 
	NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:[texts count]];
    if ([texts count] == 3) {
        [tmp addObject:[NSNumber numberWithFloat:86]];
        [tmp addObject:[NSNumber numberWithFloat:86]];
        [tmp addObject:[NSNumber numberWithFloat:86]];
    }
    if ([texts count] == 2) {
        [tmp addObject:[NSNumber numberWithFloat:137]];
        [tmp addObject:[NSNumber numberWithFloat:137]];
    }
    if ([texts count] == 1) {
        [tmp addObject:[NSNumber numberWithFloat:290]];
    }
/*	for (ETFiterItem *s in texts ) {
		CGSize size = [s.name sizeWithFont:font];
		total += size.width;  
	}
    float cs = 320;
    float restWidth;
    if ([texts count] == 1) {
        restWidth = cs-leftMargin-rightMargin-total;
    }
    else if([texts count] == 2){
        restWidth = (cs-leftMargin-rightMargin-intervalX)-total;
    }
    else if([texts count] == 3){
        restWidth = (cs-leftMargin-rightMargin-2*intervalX)-total;
    }
    for ( ETFiterItem *s in texts) {	
        CGSize size = [s.name sizeWithFont:font];
        [tmp addObject:[NSNumber numberWithFloat:size.width + restWidth*(size.width)/total]];
	}	*/
	return tmp ;
}

- (void) drawContentView:(NSArray*)it in:(CGRect)rect {  
    
    for(UIView *view in [self.etView subviews]){
        if([view isKindOfClass:[UIButton class]]){
            [view removeFromSuperview];
        }
    }
        
    [self.etView setBackgroundColor:[UIColor grayColor]];
    NSArray *arrayAll = it;
    NSMutableArray *arrayOfEachRow = [NSMutableArray arrayWithCapacity:3];
    for(int i=0; i<[arrayAll count]; i++){
        if([arrayAll count] == 0){
            return;
        }
        arrayOfEachRow = [arrayAll objectAtIndex:i];
        NSArray *eachFrame = [self _getFrames:arrayOfEachRow];
        float xsum = 15;
        for(int j=0; j<[arrayOfEachRow count]; j++)
        {
            ETFiterItem *item = [arrayOfEachRow objectAtIndex:j];
            float y = i*30+10+i*15;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGRect frame = CGRectMake(xsum, y, [[eachFrame objectAtIndex:j]floatValue], 30);
            [btn setFrame:frame];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:6.0];
            [btn.layer setBorderWidth:1.0];
            [btn.layer setBorderColor:[[UIColor colorWithRed:0.889 green:0.880 blue:0.880 alpha:1.0]CGColor]];
            
            [btn setTitle:item.name forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forState:UIControlStateNormal];
			[btn setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
			[btn setBackgroundImage:[self imageWithColor:[UIColor brownColor] ] forState:UIControlStateSelected];
            [btn setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted];
            [btn setContentMode:UIViewContentModeCenter];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            if(item.selected == YES){
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.etView addSubview:btn];
            xsum = btn.frame.origin.x + [[eachFrame objectAtIndex:j]floatValue] + 16;
        }
    }
    
}

- (void)btnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    SEL sel = @selector(EtaoSearchFilterCellBtnClicked:);
	if (self.delegate &&  [self.delegate respondsToSelector:sel]) {
        [self.delegate performSelector:sel withObject: btn];
	}  
}

@end
