//
//  CustomSearchBarController.h
//  etao4iphone
//
//  Created by iTeam on 11-9-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "EtaoUIViewWithBackgroundController.h"

@interface CustomSearchBarController: EtaoUIViewWithBackgroundController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {

	UITextField *_textField;
	
	UIBarButtonItem *_searchFieldButton; 
	
	// 实现点击去掉的效果
	UIButton *_searchCancelBtn;

    UITableView *_tableView; 
    
    NSMutableArray *_suggestList;
    
    //NSMutableArray *_historyList;
	
	BOOL _loadingSuggest;

}

@property(nonatomic,retain) UITextField *_textField;
@property(nonatomic,retain)  UIBarButtonItem* _searchFieldButton;
@property(nonatomic,retain)  UIButton *_searchCancelBtn;  
@property(nonatomic,retain) UIButton *_searchButton;


@property (nonatomic,retain) UITableView *_tableView;  

@property (nonatomic,retain) NSMutableArray *_suggestList;
//@property (nonatomic,retain) NSMutableArray *historyList;

@property (assign) BOOL _loadingSuggest;


- (void) unmark ;
- (void) mark ;

- (void) loadSuggest:(NSString*)text;

- (void)saveInputText :(NSString*)inputText;


@end
