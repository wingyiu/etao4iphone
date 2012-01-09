//
//  EtaoSearchBarView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoSearchBarView.h"


@implementation EtaoSearchBarView
@synthesize _textField ;
@synthesize _searchCancelBtn; 
@synthesize _searchButton;

- (id)init {
    
    self = [super init];
    if (self) {
		UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 250.0f, 30.0f)];
		self._textField = textField;
		[textField release];
		
		_textField.leftViewMode = UITextFieldViewModeAlways;  
		_textField.leftView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftsearch.png"]] autorelease]; 
		_textField.borderStyle = UITextBorderStyleRoundedRect;
		_textField.autocorrectionType = UITextAutocorrectionTypeNo;
		_textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		_textField.returnKeyType = UIReturnKeyDone;
		_textField.clearButtonMode = UITextFieldViewModeWhileEditing; 
		_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_textField.placeholder = @"搜索，比价，省钱"; 
		_textField.delegate = self; 
		
		
		//定义搜索点击的时候，方便取消的效果
		UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
		_searchCancelBtn = btn;
		_searchCancelBtn.frame = CGRectMake(0, 0, 320, 440); 
		_searchCancelBtn.backgroundColor = [UIColor blackColor]; 
		[_searchCancelBtn addTarget:self action:@selector(SearchMarkButtonClick) forControlEvents:UIControlEventTouchDown];
		_searchCancelBtn.hidden = YES;  
    }
    return self;
}

- (void) mark { 	
	if (_searchCancelBtn.alpha == 0.6) {
		return ;
	}
	_searchCancelBtn.hidden = NO;
 	_searchCancelBtn.alpha = 0.0; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	_searchCancelBtn.alpha = 0.6;
	[UIView commitAnimations];
}

- (void) unmark { 
	if (_searchCancelBtn.alpha == 0.0) {
		return ;
	}
 	_searchCancelBtn.alpha = 0.6; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	_searchCancelBtn.alpha = 0.0;
	[UIView commitAnimations];
	_searchCancelBtn.hidden = NO;  
}

- (void)SearchMarkButtonClick{
	[self unmark];
	[_textField resignFirstResponder];   
}


- (void)searchButtonTapped:(id)sender{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		UIBarButtonItem *btn = (UIBarButtonItem*)sender;
		if ([btn.title isEqualToString:@"取消"]) { 
			btn.title = @"搜索";
			[_textField resignFirstResponder];
			[self unmark];
		} 
	} 
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self mark];
	_searchFieldButton.title = @"取消"; 
	
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
	[_textField resignFirstResponder]; 
	[self unmark];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
 	[_textField resignFirstResponder]; 
	[self unmark];
	return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
	[self unmark];
	return YES;	
}



- (void)dealloc {
    [super dealloc];
}


@end
