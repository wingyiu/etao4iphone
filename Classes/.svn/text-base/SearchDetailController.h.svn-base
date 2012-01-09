//
//  SearchDetailController.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchDetailSessionDelegate.h"
#import "EtaoUIViewWithBackgroundController.h" 

@class SearchDetailSession;

@interface SearchDetailController : EtaoUIViewWithBackgroundController <UITableViewDataSource, UITableViewDelegate, SearchDetailSessionDelegate>{
    
    UITableView *_detailTableView;
    
    //NSMutableArray *_detailDateSource;
    
    UIView* itemListHeadView;
    
    SearchDetailSession *_searchDetailSession;
    
    BOOL _isLoading;	
}

- (id) initWithProduct:(NSDictionary*)dict;

- (id) initWithJson:(NSString*)json;

- (void) setJsonData:(NSString*)json;

@property (nonatomic, retain) UITableView* detailTableView;

//@property (nonatomic, retain) NSMutableArray* detailDateSource;

@property (nonatomic, retain) SearchDetailSession* searchDetailSession;

@property (nonatomic, retain) id delegate;

@end
