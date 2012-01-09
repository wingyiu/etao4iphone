//
//  CustomSearchBarView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomSearchBarView.h"


@implementation CustomSearchBarView

@synthesize _textField,_searchFieldButton;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
		UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth; 
		
		
		UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbox.png"]];
		backgroundView.frame = CGRectMake(0.f, 0.f, toolBar.frame.size.width, toolBar.frame.size.height);
		backgroundView.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[toolBar insertSubview:backgroundView atIndex:0];
 		[backgroundView release];
		 
		_textField = [[UITextField alloc] initWithFrame:CGRectMake(35.0f, 5.0f, 220.0f, self.frame.size.height - 10)];
		_textField.borderStyle = UITextBorderStyleNone;
		_textField.autocorrectionType = UITextAutocorrectionTypeNo;
		_textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		_textField.returnKeyType = UIReturnKeySearch;
		_textField.clearButtonMode = UITextFieldViewModeWhileEditing; 
		_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_textField.placeholder = @"搜索，比价，省钱"; 
 
		UIBarButtonItem* space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]autorelease];
		UIBarButtonItem *textFieldItem = [[[UIBarButtonItem alloc] initWithCustomView:_textField]autorelease]; 
		_searchFieldButton = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleBordered target:self action:@selector(searchButtonTapped:)];
 
		[toolBar setItems:[NSArray arrayWithObjects:space,space,space,textFieldItem,space,_searchFieldButton,nil] animated:NO];
 		 
		[self addSubview:toolBar]; 
		
		[toolBar release];
		
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[_textField release];
	[_searchFieldButton release];
    [super dealloc];
}


@end
