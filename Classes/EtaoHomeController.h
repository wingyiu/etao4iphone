//
//  EtaoHomeController.h
//  etao4iphone
//
//  Created by iTeam on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>   
#import "HttpRequest.h"
#import "EtaoTopQueryView.h"
#import "EtaoHomeTuanView.h"

@interface EtaoHomeController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
 
	UITableView *_tableView; 
	
	NSMutableArray *_suggestList;
	
	BOOL _loadingSuggest ;
	
}

- (void) requestFinished:(HttpRequest *)request;

- (void) requestFailed:(HttpRequest *)request;

- (void) loadSuggest:(NSString*)text ;


- (void) unmark ;
- (void) mark ;

@property (nonatomic,retain) UITableView *_tableView; 
@property (nonatomic,retain) NSMutableArray *_suggestList;

@property (assign) BOOL _loadingSuggest ;
@property (nonatomic,retain) UITextField *_textField;
@property (nonatomic,retain) UIBarButtonItem* _searchFieldButton;
@property (nonatomic,retain) UIButton *_searchCancelBtn ;
@property (nonatomic,retain) EtaoTopQueryView* _topqueryView ;
@property (nonatomic,retain) EtaoHomeTuanView* _tuanView ;
@end
