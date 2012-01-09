//
//  EtaoTuanNavTitleView.h
//  etao4iphone
//
//  Created by  on 11-11-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoGroupBuyLocationDataSource.h"

@interface EtaoTuanNavTitleView : UIView{
    
    UIButton *_btn ;
	
	UIImageView *_arrow ;
	
	id delegate ;
	SEL buttonClick;
	
	BOOL _selected ;
    EtaoGroupBuyLocationDataSource* _datasource;
}
@property (nonatomic, assign) id delegate; 
@property (nonatomic, assign) SEL buttonClick; 
@property (nonatomic, assign) BOOL selected ;
@property (nonatomic, retain) UIButton *btn ;

@property (nonatomic, retain) UIImageView *arrow ;

/* 监视函数 */
- (void)watchWithDatasource:(id)datasource;
- (void)watchWithKey:(NSString*)key;

- (void) doArrow;
- (void) setText:(NSString*)text;
@end
