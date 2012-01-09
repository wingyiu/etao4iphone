//
//  SearchDetailParameters.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoUIViewWithBackgroundController.h"

@interface SearchDetailParametersController: EtaoUIViewWithBackgroundController <UITableViewDataSource, UITableViewDelegate> {

    UITableView *_parametersTableView;
    
    NSMutableArray *_parametersDateSource;
}

- (void)setDetaiParametersController:(NSString*) parameters;

@property (nonatomic, retain) UITableView* parametersTableView;

@property (nonatomic, retain) NSMutableArray* parametersDateSource;

@end
