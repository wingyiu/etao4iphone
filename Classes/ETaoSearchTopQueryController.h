//
//  ETaoSearchTopQueryController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoHttpRequest.h"

@interface ETaoSearchTopQueryController : UIViewController <UITableViewDataSource,UITableViewDelegate,EtaoHttpRequstDelegate>{

    UITableView *_tableView; 
    
    NSMutableArray *_topQuery ;
    NSMutableArray *_topQueryInfo ;
    UIViewController *_parent ;
    EtaoHttpRequest * _request;
}
 
@property (nonatomic,retain) UITableView *tableView; 
@property (nonatomic,retain) NSMutableArray *topQuery ;
@property (nonatomic,retain) NSMutableArray *topQueryInfo ;
@property (nonatomic,retain) EtaoHttpRequest * request;
@property (nonatomic, assign) UIViewController *parent ;
@end
