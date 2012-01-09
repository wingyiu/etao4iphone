//
//  EtaoPageBaseCategoryController.m
//  etaoetao
//
//  Created by GuanYuhong on 11-11-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPageBaseCategoryController.h"

@implementation EtaoPageBaseCategoryController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.title = @"选择分类";
    
    UIBarButtonItem* back = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered  target:self action:@selector(back)]autorelease];
	self.navigationItem.leftBarButtonItem = back; 

    
    UIBarButtonItem* done = [[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered  target:self action:@selector(done)]autorelease];
	self.navigationItem.rightBarButtonItem = done; 
 
    self.view.backgroundColor = [UIColor purpleColor];

}
 
- (int) viewCount{
    
    return 7 ;
}
- (void) back {
   [self.parentViewController dismissModalViewControllerAnimated:YES]; 

}

- (void) done {
    [self.parentViewController dismissModalViewControllerAnimated:YES]; 
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
