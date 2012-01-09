//
//  SearchEvaluateController.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoUIViewWithBackgroundController.h"
#import "SearchEvaluateSessionDelegate.h"

@class SearchEvaluateSession;

@interface SearchEvaluateController :EtaoUIViewWithBackgroundController <UITableViewDataSource, UITableViewDelegate, SearchEvaluateSessionDelegate> {
    
    UIButton* _buttonAdvantage;
    UIButton* _buttonShortcoming;
    UIButton* _buttonExperience;
    
    UITableView* _evaluateTabView; 
        
    SearchEvaluateSession *_searchEvaluateSession;
    
    BOOL _isLoading;
}

- (id) initWithProduct:(NSDictionary*)dict;

-(void)showAdvabtage;
-(void)showShortcoming;
-(void)showExperience;

@property (nonatomic, retain)UIButton* buttonAdvantage;
@property (nonatomic, retain)UIButton* buttonShortcoming;
@property (nonatomic, retain)UIButton* buttonExperience;

@property (nonatomic, retain)UITableView* evaluateTabView; 

@property (nonatomic, retain)SearchEvaluateSession *searchEvaluateSession;

@end
