//
//  EtaoTuanNavTitleView.m
//  etao4iphone
//
//  Created by  on 11-11-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanNavTitleView.h"

@implementation EtaoTuanNavTitleView

@synthesize btn = _btn;
@synthesize arrow = _arrow ;
@synthesize delegate ,buttonClick;
@synthesize selected =  _selected;

- (void)dealloc {
    [_datasource removeObserver:self forKeyPath:@"status"];
    [_btn release];
    [_arrow release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		UIFont *font = [UIFont boldSystemFontOfSize:18];
		UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom]; 
		bt.frame = frame; 
		[bt addTarget: self action: @selector(downButtonPressed:) forControlEvents: UIControlEventTouchUpInside]; 
		bt.titleLabel.font  = font;
		bt.titleLabel.textAlignment = UITextAlignmentCenter; 
		bt.titleLabel.shadowColor = [UIColor grayColor]; 
		CGSize s = {-1.0,-1.0};
		bt.titleLabel.shadowOffset = s; 
		CGSize size1 = [[NSString stringWithFormat:@"选择城市"] sizeWithFont:font];
		
		UIImageView *arr = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down.png"]];
		arr.frame = CGRectMake(frame.size.width/2+size1.width/2+5,10.0f,10,10);
		[bt setTitle:@"选择城市" forState:UIControlStateNormal];
		[bt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
		[bt setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
		[bt addSubview:arr]; 		
		self.btn = bt ;
		self.arrow = arr ;
		[arr release];
		_selected = NO ;
		[self addSubview:_btn];
    }
    return self;
}
- (void) setText:(NSString*)text{
	UIFont *font = [UIFont boldSystemFontOfSize:18]; 
	CGSize size1 = [text sizeWithFont:font];   
	[_btn  setTitle:text forState:UIControlStateNormal]; 
    [_btn  setTitle:text forState:UIControlStateSelected]; 
	_arrow.frame = CGRectMake(self.frame.size.width/2+size1.width/2+5,10.0f,10,10);  	
}

-(void) doArrow
{
    if (!_selected) { 
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES]; 
		[UIView setAnimationDuration:0.2f];   
		[UIView setAnimationRepeatCount:1];  
		_arrow.transform=CGAffineTransformMakeRotation(M_PI);
		[UIView commitAnimations]; 
		_selected = YES;
	}
	else { 
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES]; 
		[UIView setAnimationDuration:0.2f];   
		[UIView setAnimationRepeatCount:1];  
		_arrow.transform=CGAffineTransformMakeRotation(2*M_PI);
		[UIView commitAnimations]; 
		_selected = NO;
	}
}

- (void) downButtonPressed:(id)sender
{
	if (!_selected) { 
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES]; 
		[UIView setAnimationDuration:0.2f];   
		[UIView setAnimationRepeatCount:1];  
		_arrow.transform=CGAffineTransformMakeRotation(M_PI);
		[UIView commitAnimations]; 
		_selected = YES;
	}
	else { 
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES]; 
		[UIView setAnimationDuration:0.2f];   
		[UIView setAnimationRepeatCount:1];  
		_arrow.transform=CGAffineTransformMakeRotation(2*M_PI);
		[UIView commitAnimations]; 
		_selected = NO;
	} 
    
	UIButton *button = (UIButton*)sender ;  
	[button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted]; 
	if (self.delegate && self.buttonClick && [delegate respondsToSelector:self.buttonClick]) {
		[delegate performSelectorOnMainThread:self.buttonClick withObject:button waitUntilDone:YES];
	}
}

#pragma mark -v event handle
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isKindOfClass:[EtaoGroupBuyLocationDataSource class]]){
        ET_DS_GROUPBUY_LOCATION_STATUS status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case ET_DS_GROUPBUY_LOCATION_CHANGE: //数据加载完成
                if (_datasource.currentCity != nil){
                    [self setText:_datasource.currentCity];
                }
                break;
            default:
                break;
        }
    }
}

#pragma mark -v Watch
/* 监视相关*/

- (void)watchWithKey:(NSString *)key{
    _datasource = (EtaoGroupBuyLocationDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:key];
    [_datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
    if (_datasource.currentCity != nil){
        [self setText:_datasource.currentCity];
    }
}

- (void)watchWithDatasource:(id)datasource{
    [datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
    if (_datasource.currentCity != nil){
        [self setText:_datasource.currentCity];
    }
}



@end
