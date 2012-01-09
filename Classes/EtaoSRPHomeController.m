    //
//  EtaoSRPHomeController.m
//  etao4iphone
//
//  Created by iTeam on 11-9-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoSRPHomeController.h"
#import "EtaoHomeViewController.h"
#import "NSObject+SBJson.h"
#import "EtaoSRPController.h"
#import "HttpRequest.h"
#import "NSString+QueryString.h"
#import "EtaoUIBarButtonItem.h"


@implementation EtaoSRPHomeController

- (void) UIBarButtonItemHome:(UIBarButtonItem*)sender{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];  
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];  
	
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonItemHome:)]autorelease];
    self.navigationItem.leftBarButtonItem = home;
   
	self.navigationItem.titleView = _textField;
	self.navigationItem.rightBarButtonItem = _searchFieldButton;

	[self._tableView setFrame:CGRectMake(0, 0, 320, 460)];	 
	self._tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	self.view.backgroundColor = [UIColor blackColor];
	
    if ([_suggestList count] == 0) {
        [self.view bringSubviewToFront:self._searchCancelBtn];
	}
    
    [self._textField becomeFirstResponder];  
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
} 


- (void)searchButtonTapped:(id)sender{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		UIBarButtonItem *btn = (UIBarButtonItem*)sender;
		if ([btn.title isEqualToString:@"取消"]) { 
			btn.title = @"搜索";
			[_textField resignFirstResponder];
			[self.navigationController setNavigationBarHidden:NO animated:YES];
			[super unmark];
		}
		else {
			if (![_textField.text isEqualToString:@""] && self._textField.text != nil) {
				[self textFieldShouldReturn:_textField];
			}
		}

	} 
}

- (void)SearchMarkButtonClick{
	[super unmark]; 
	[_textField resignFirstResponder]; 
	_searchFieldButton.title = @"搜索"; 
} 

//        

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[super textFieldDidBeginEditing:textField];
    _searchFieldButton.title = @"取消"; 
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
	[super textFieldDidEndEditing:textField];
    _searchFieldButton.title = @"搜索";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if ([textField.text isEqualToString:@""]) {
		return YES;
	}
	[super textFieldShouldReturn:textField];   
	EtaoSRPController * srp = [[[EtaoSRPController alloc] init]autorelease]; 
	srp._keyword = _textField.text ;
	[srp search: srp._keyword];
	 
	[self.navigationController pushViewController:srp animated:YES]; 
    [self saveInputText:_textField.text];
    
/*	EtaoHomeViewController *home = (EtaoHomeViewController*)[[[[self tabBarController] viewControllers] objectAtIndex: 0]topViewController];
	home._textField.text = srp._keyword ;
*/
	
	return YES;
}

- (void) forceSearch:(NSString*)text { 	
    EtaoSRPController * srp = [[[EtaoSRPController alloc] init]autorelease];
	srp._keyword = text ;
	[srp search: srp._keyword]; 
	[self.navigationController pushViewController:srp animated:YES];

    [self saveInputText:text];
    //[srp release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload]; 
}


- (void)dealloc {
	[_tableView release];
    [super dealloc];
}


@end
