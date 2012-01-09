//
//  EtaoSRP4SqureCell.h
//  etao4iphone
//
//  Created by 稳 张 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPImageView.h"
#import "ActivityIndicatorMessageView.h"

@interface EtaoSRP4SqureCell : UIView {
    HTTPImageView* _httpImg;
    UIButton* _button;
    UILabel* _label;
    ActivityIndicatorMessageView* _loadv;
}

- (id)initWithFrame:(CGRect)frame;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@property (nonatomic, retain) HTTPImageView* httpImg;
@property (nonatomic, retain) UIButton* button;
@property (nonatomic, retain) UILabel* label;
@property (nonatomic, retain) ActivityIndicatorMessageView* loadv;

@property (nonatomic,retain) id item ;
@property (nonatomic,assign) UIViewController *parent;

@end
