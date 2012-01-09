//
//  ETSDKHome.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETSDKHome.h" 
#import "ETHttpRequestTestController.h"
#import "ETDetailSwipeController.h"
@implementation ETSDKHome

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


- (void) buttonClick:(UIButton*)btn{
    if ([btn.titleLabel.text isEqualToString:@"http"]) { 
        ETHttpRequestTestController *v = [[[ETHttpRequestTestController alloc]init]autorelease];
        [self.navigationController pushViewController:v animated:YES];
    }
    
    if ([btn.titleLabel.text isEqualToString:@"swipe"]) { 
        ETDetailSwipeController *v = [[[ETDetailSwipeController alloc]init]autorelease];
        v.cls = [ETHttpRequestTestController class];
        v.detailsDataSourceItems = [NSArray arrayWithObjects:@"a",@"b",@"d", nil];
        [self.navigationController pushViewController:v animated:YES];
    }
    
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];     
    self.title = @"ETSDK";
    
    UIButton *http = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    http.frame = CGRectMake(0, 0, 100, 30);
    [http setTitle:@"http" forState:UIControlStateNormal];
    [http addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:http];
 
    UIButton *swipe = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    swipe.frame = CGRectMake(0, 40, 100, 30);
    [swipe setTitle:@"swipe" forState:UIControlStateNormal];
    [swipe addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:swipe];
    
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
