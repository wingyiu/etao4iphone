//
//  EtaoUISearchDisplayController.h
//  etaoetao
//
//  Created by GuanYuhong on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "EtaoUIBarButtonItem.h"


@protocol EtaoUISearchDisplayControllerDelegate <NSObject>

@optional

- (void)textFieldWordSelected:(NSString*)text ;
- (void)textFieldInputDidCancel:(NSString*)text ;
- (void)textFieldInputDidStart:(NSString*)text ; 
- (void)textFieldInputDidEnd:(NSString*)text ; 
- (void)searchButtonDidClick:(EtaoUIBarButtonItem*)button ; 

@end


@interface EtaoUISearchDisplayController : NSObject < UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    UITextField *_textField;  
    
    EtaoUIBarButtonItem *_searchBarButton ;
          
    UITableView *_tableView; 
    
    NSMutableArray *_suggestList;
     
	
	BOOL _loadingSuggest;
    BOOL _withSearch;
     
    UINavigationItem *_navItems;


    
    // The delegate - will be notified of various changes in state via the ASIHTTPRequestDelegate protocol
	id <EtaoUISearchDisplayControllerDelegate> delegate; 
	SEL didtextFieldWordSelected;
	SEL didtextFieldInputDidStart; 
	SEL didtextFieldInputDidCancel;
    SEL didtextFieldInputDidEnd;
    SEL didsearchButtonDidClick;
}

@property (nonatomic,retain) UITextField *textField;   
@property (nonatomic,retain) EtaoUIBarButtonItem *searchBarButton ;
@property (nonatomic,retain) UITableView *tableView; 
@property (nonatomic,retain) NSMutableArray *suggestList; 

@property (nonatomic ,assign) UINavigationItem *navItems;
@property (nonatomic ,assign) id delegate;
@property (assign) SEL didtextFieldWordSelected;
@property (assign) SEL didtextFieldInputDidStart;
@property (assign) SEL didtextFieldInputDidEnd; 
@property (assign) SEL didtextFieldInputDidCancel;  
@property (assign) SEL didsearchButtonDidClick;

@property (assign) BOOL _loadingSuggest;
 
@property (assign) BOOL _withSearch;

- (void) loadSuggest:(NSString*)text;

- (void) saveInputText :(NSString*)inputText;

- (void) setButtonText:(NSString*)text;

- (id)initWithTextField:(UITextField *)textField tableView:(UITableView *)tableview NavItem:(UINavigationItem *)avItems withSearchButton:(BOOL) btn;


@end
