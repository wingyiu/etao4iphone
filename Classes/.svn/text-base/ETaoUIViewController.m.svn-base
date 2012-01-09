//
//  ETaoUIViewController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETaoUIViewController.h"
#import "EtaoUIBarButtonItem.h"
@implementation ETaoUIViewController

@synthesize superController = _superController ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void) UIBarButtonItemBackClick:(UIBarButtonItem*)sender{   
    [self.navigationController popViewControllerAnimated:YES];
    //[[self parentViewController] dismissModalViewControllerAnimated:YES];  
}
 

- (void) UIBarButtonItemHomeClick:(UIBarButtonItem*)sender{   
    [[self parentViewController] dismissModalViewControllerAnimated:YES];  
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
  /*  
    self.navigationItem.backBarButtonItem = nil;
    EtaoUIBarButtonItem *back = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_arrow.png"] target:self action:@selector(UIBarButtonItemClick:)]autorelease];
    back.title = @"back"; 
    self.navigationItem.leftBarButtonItem = back; 
    */
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
