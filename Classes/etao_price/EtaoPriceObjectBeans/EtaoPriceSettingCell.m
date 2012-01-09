//
//  MyUITableViewCell.m
//  etao4iphone
//
//  Created by  on 11-11-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceSettingCell.h"

@implementation EtaoPriceSettingCell

@synthesize btnView = _btnView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.btnView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"etao_check.png"]]autorelease];
        _btnView.hidden = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)willTransitionToState:(UITableViewCellStateMask)state{
    [super willTransitionToState:state];
    
    if ((state & UITableViewCellStateShowingEditControlMask) == UITableViewCellStateShowingEditControlMask) {
        for (UIView *subview in self.subviews) {
            if([NSStringFromClass([subview class])isEqualToString:@"UITableViewCellEditControl"])
            {
                subview.hidden = YES;
                subview.alpha = 0.0;
            }
        }
    }
    
}

-(void)didTransitionToState:(UITableViewCellStateMask)state{
    [super didTransitionToState:state];
    
    if (state == UITableViewCellStateShowingEditControlMask || state == UITableViewCellStateDefaultMask)
    {
        for (UIView *subview in self.subviews) {
            if([NSStringFromClass([subview class])isEqualToString:@"UITableViewCellEditControl"])
            {
                
                UIView *checkButtonView = (UIView*)[subview.subviews objectAtIndex:0];
       
                if ([checkButtonView.subviews count] == 0) {
                    [checkButtonView addSubview:_btnView];
                    subview.hidden = NO;
                    subview.alpha = 1.0;
                }
            
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesMoved:touches withEvent:event];
}

-(void)dealloc{
    [_btnView release];
    [super dealloc];
}

@end
