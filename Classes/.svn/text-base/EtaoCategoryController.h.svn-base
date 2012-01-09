//
//  EtaoCategoryController.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "EtaoCategorySessionDelegate.h"
#import "EtaoUIViewWithBackgroundController.h" 

@class EtaoCategorySession;

@interface EtaoCategoryController : EtaoUIViewWithBackgroundController <UITableViewDataSource, UITableViewDelegate, EtaoCategorySessionDelegate>{
    
    UITableView *_etaoCategoryTableView;
    
    EtaoCategorySession *_etaoCategorySession;
    
    BOOL _isLoading;	
    UIViewController *_parent ;
}
@property (nonatomic, assign) UIViewController *parent ;

@property (nonatomic, retain) UITableView* etaoCategoryTableView;

@property (nonatomic, retain) EtaoCategorySession* etaoCategorySession;

@property (nonatomic, retain) id delegate;

@end
