//
//  ETTableViewCellSimple.m
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 11-12-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETTableViewCellSimple.h"

@class ETTableViewCellSimple;

@implementation ETUIView
@synthesize item = _item;

- (void)dealloc{
    if (_item != nil) {
        [_item release];
        _item = nil;
    }
    [super dealloc];
}

- (void)drawRect:(CGRect)rect{
    NSLog(@"%s",__FUNCTION__); 
    [self setBackgroundColor:[UIColor clearColor]];
    [(ETTableViewCellSimple *)[self superview] drawContentView:_item in:rect];
}

@end


@implementation ETTableViewCellSimple

@synthesize item2 = _item2;
@synthesize etView = _etView;

- (void)dealloc{
    if (_item2 != nil) {
        [_item2 release];
        _item2 = nil;
    }
    if (_etView != nil) {
        [_etView release];
        _etView = nil;
    }
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.etView = [[[ETUIView alloc]initWithFrame:CGRectZero]autorelease];
        _etView.opaque = YES;
        [_etView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_etView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _etView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)setItem:(NSArray*)it{
    self.item2 = [NSArray arrayWithArray:it];
    _etView.item = [NSArray arrayWithArray:_item2];
 //   [_etView setNeedsLayout];
    [_etView setNeedsDisplay];
}

- (void) drawContentView:(NSArray*)it in:(CGRect)rect{
    [self setBackgroundColor:[UIColor clearColor]];
}

@end
