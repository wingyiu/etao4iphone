    //
//  EtaoUIViewWithBackgroundController.m
//  etao4iphone
//
//  Created by iTeam on 11-9-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoUIViewWithBackgroundController.h"


@implementation EtaoUIViewWithBackgroundController

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
//	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.1058 green:0.6705 blue:0.8705 alpha:1.0]; 
/*	
	UIImageView * left= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftbg.png"]];
	left.frame = CGRectMake(0,0,10,368);
	[self.view addSubview:left];
	[left release];
	
	UIImageView * right= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightbg.png"]];
	right.frame = CGRectMake(310,0,10,368);
	[self.view addSubview:right];
	[right release];
*/
	
}
 

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
