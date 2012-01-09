    //
//  CustomSearchBarDisplayController.m
//  etao4iphone
//
//  Created by iTeam on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomSearchBarDisplayController.h"


@implementation CustomSearchBarDisplayController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

 
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];

	self.title = @"一淘";
 	
	UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homebg.png"]];
	backgroundView.frame = CGRectMake(0.f, 0.f, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
	backgroundView.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.navigationController.navigationBar insertSubview:backgroundView atIndex:0];
	[backgroundView release]; 	 
 
}
 

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)searchButtonTapped:(id)sender{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		UIBarButtonItem *btn = (UIBarButtonItem*)sender;
		if ([btn.title isEqualToString:@"取消"]) { 
			btn.title = @"搜索";
			[_textField resignFirstResponder];
			[self.navigationController setNavigationBarHidden:NO animated:YES];
			[super unmark];
		} 
	} 
}

- (void)SearchMarkButtonClick{
	[super unmark];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[_textField resignFirstResponder]; 
	_searchFieldButton.title = @"搜索"; 
} 

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[super textFieldDidBeginEditing:textField]; 
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
	[super textFieldDidEndEditing:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[super textFieldShouldReturn:textField];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	//EtaoSRPController * srp = [[[EtaoSRPController alloc] init]autorelease];
	//[srp search:_textField.text];
	//[self.navigationController pushViewController:srp animated:YES];
	
	EtaoSRPController *srp = (EtaoSRPController*)[[[[self tabBarController] viewControllers] objectAtIndex: 1]topViewController];
	[srp search:_textField.text]; 
	self.tabBarController.selectedIndex = 1;

	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
	[super textFieldShouldEndEditing:textField];
	return YES;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
