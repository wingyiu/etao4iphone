//
//  ETTableViewCellSimple.h
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 11-12-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETUIView : UIView {
    NSArray* _item;
}
@property (nonatomic, retain) NSArray* item;

- (void)drawRect:(CGRect)rect;

@end


@interface ETTableViewCellSimple : UITableViewCell
{
    NSArray* _item2;
    ETUIView *_etView;
}
@property (nonatomic, retain)NSArray* item2;
@property (nonatomic, retain)ETUIView *etView;

- (void)setItem:(NSArray*)it;
- (void)drawContentView:(NSArray*)it in:(CGRect)rect;

@end
