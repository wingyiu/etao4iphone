//
//  ETaoHelpView.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETaoHelpView;

@protocol ETaoHelpViewDelegate <NSObject>

@optional


- (void) ETaoHelpViewClick:(ETaoHelpView*)view ;


@end

@interface ETaoHelpView : UIView{
    UIImage *_image ;
    NSString * _name ;
}

@property (nonatomic, retain) UIImage *image ;
@property (nonatomic, copy  ) NSString *name ;

- (id)initWithImage:(UIImage*) image withName:(NSString*) name;

- (void) show ;
@end
