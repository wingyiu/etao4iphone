//
//  EtaoCustomButtonView.h
//  etao4iphone
//
//  Created by iTeam on 11-9-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EtaoCustomButtonView : UIView {
	UIButton *_btn ;
	
	UIImageView *_arrow ;
	
	id delegate ;
	
	SEL buttonClick;
	
	BOOL _selected ;
}
@property (nonatomic, assign) id delegate; 
@property (nonatomic, assign) SEL buttonClick; 
@property BOOL _selected ;
@property (nonatomic, assign) UIButton *_btn ;

@property (nonatomic, assign) UIImageView *_arrow ;

- (void) doArrow;

- (void) setText:(NSString*)text;

@end
