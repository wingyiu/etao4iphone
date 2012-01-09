//
//  EtaoLocalClassifyView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalClassifyView.h"
#import "EtaoLocalListController.h"
#import "EtaoLocalMapController.h"


@implementation EtaoLocalClassifyView

@synthesize typeButtonClickOnSelector ;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
	 	self.backgroundColor = [UIColor colorWithRed:55/255.0f green:55/255.0f blue:55/255.0f alpha:1.0]; 
 
		UIButton *downButton_all = [[[UIButton alloc] initWithFrame:CGRectMake(0, -1, 80, 32.5)]autorelease];
		[downButton_all setTitle:@"all" forState:UIControlStateNormal];
		[downButton_all setImage:[UIImage imageNamed:@"etaoLocalTypeAll.png"] forState:UIControlStateNormal];
		[downButton_all setImage:[UIImage imageNamed:@"etaoLocalTypeAll1.png"] forState:UIControlStateSelected]; 
		[downButton_all addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		downButton_all.backgroundColor = [UIColor clearColor];
		[downButton_all setTag:0];
		  
		UIButton *downButton_catering = [[[UIButton alloc] initWithFrame:CGRectMake(80, -1, 80, 32.5)]autorelease];
		[downButton_catering setTitle:@"catering" forState:UIControlStateNormal];
		[downButton_catering setImage:[UIImage imageNamed:@"etaoLocalTypeFood.png"] forState:UIControlStateNormal];
		[downButton_catering setImage:[UIImage imageNamed:@"etaoLocalTypeFood1.png"] forState:UIControlStateSelected]; 
		
		[downButton_catering addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[downButton_catering setTag:1];
		
		UIButton *downButton_living = [[[UIButton alloc] initWithFrame:CGRectMake(160, -1, 80, 32.5)]autorelease];	
		[downButton_living setTitle:@"living" forState:UIControlStateNormal];
		[downButton_living setImage:[UIImage imageNamed:@"etaoLocalTypeLiving.png"] forState:UIControlStateNormal];
		[downButton_living setImage:[UIImage imageNamed:@"etaoLocalTypeLiving1.png"] forState:UIControlStateSelected]; 
		
		[downButton_living addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[downButton_living setTag:2];
		
		UIButton *downButton_ent = [[[UIButton alloc] initWithFrame:CGRectMake(240, -1, 80, 32.5)]autorelease];  
		[downButton_ent setTitle:@"entertainment" forState:UIControlStateNormal];
		[downButton_ent setImage:[UIImage imageNamed:@"etaoLocalTypeEntertainment.png"] forState:UIControlStateNormal];
		[downButton_ent setImage:[UIImage imageNamed:@"etaoLocalTypeEntertainment1.png"] forState:UIControlStateSelected]; 
		
		[downButton_ent addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[downButton_ent setTag:3];
		

		[self addSubview:downButton_all];
		[self addSubview:downButton_catering];
		[self addSubview:downButton_ent];
		[self addSubview:downButton_living];
		[downButton_all setSelected:YES];
		
		
		
    }
    return self;
}
- (void) downButtonPressed:(id)sender
{
 	UIButton *button = (UIButton*)sender ;
	for (UIView *subView in [button.superview subviews]) {//遍历这个view的subViews
        if ([subView isKindOfClass:NSClassFromString(@"UIButton")] )
		{	  
			UIButton *btn = (UIButton*) subView;
			if (btn.selected) {
				[btn setSelected:NO];
			} 
 
		}
	} 
	[button setSelected:YES]; 	
	if (self.delegate && self.typeButtonClickOnSelector && [delegate respondsToSelector:self.typeButtonClickOnSelector]) {
		[delegate performSelectorOnMainThread:self.typeButtonClickOnSelector withObject:button.titleLabel.text waitUntilDone:YES];
	}
    
    if( button.tag == 0 ) {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-StyleAll"];
    }else if( button.tag == 1 ) {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-StyleFood"];     
    }else if( button.tag == 2 ) {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-StyleLife"];
    }else if( button.tag == 3 ) {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-StyleFun"];
    }
}

- (void) setSelected:(NSString*)type{ 
	for (UIView *subView in [self subviews]) {//遍历这个view的subViews
        if ([subView isKindOfClass:NSClassFromString(@"UIButton")] )
		{	  
			UIButton *btn = (UIButton*) subView;
			if (btn.selected) {
				[btn setSelected:NO];
			} 
			if ([btn.titleLabel.text isEqualToString:type] ) {
				[btn setSelected:YES];
			}
		}
	}  
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
