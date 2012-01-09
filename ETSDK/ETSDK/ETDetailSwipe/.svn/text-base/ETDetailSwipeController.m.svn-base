//
//  ETDetailSwipeController.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETDetailSwipeController.h" 
#import "ETDetailSwipeController.h"
#import "EtaoUIBarButtonItem.h"
#import "EtaoTuanListDetailController.h"
#import "TBWebViewControll.h"

@implementation ETDetailSwipeController

@synthesize swipeLeftRecognizer = _swipeLeftRecognizer ;
@synthesize swipeRightRecognizer = _swipeRightRecognizer ;
@synthesize detailController = _detailController,detailController2 = _detailController2;
@synthesize cls = _cls;
@synthesize navTitle = _navTitle;
@synthesize detailsDataSourceItems = _detailsDataSourceItems ;

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

- (void) dealloc{
    if (_detailController != nil) {
        [_detailController release];
        _detailController = nil;
    }
    if (_detailController2 != nil) {
        [_detailController2 release];
        _detailController2 = nil;
    }
    [_swipeRightRecognizer release];
    [_swipeLeftRecognizer release];
    [super dealloc];
}




// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.swipeLeftRecognizer = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)]autorelease]; 
    [_swipeLeftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:_swipeLeftRecognizer]; 

    self.swipeRightRecognizer = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)]autorelease]; 
    [_swipeRightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:_swipeRightRecognizer]; 
      
    
 //   self.detailController = [[[self.cls alloc]init]autorelease];  
 //   [self.view addSubview:_detailController.view];
      
 //   [self setDetailByIndex:1];
    
}


- (void) setDetailByIndex:(int) idx {
    if (self.navTitle == nil) {
        self.navTitle = @"详情页";
    } 
    self.title = @"详情页";//[NSString stringWithFormat:@"%@(%d/%d)",self.navTitle,idx+1,[_detailsDataSourceItems count]];
    self.detailController = [[[self.cls alloc]init]autorelease]; 
    
    [_detailController setDetailFromItem:[_detailsDataSourceItems objectAtIndex:idx]];

    _detailController.view.frame = CGRectMake(_detailController.view.frame.origin.x , 0, _detailController.view.frame.size.width, 415);

    [self.view addSubview:_detailController.view];     
    _index = idx;
}
 
/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
 */
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"begin:%@",[self.view subviews]);
	CGPoint location = [recognizer locationInView:self.view]; 


    
    int toward = 320 ;
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        location.x -= 220.0;
        toward = 320;
        _index += 1;
    }
    else {
        location.x += 220.0;
        toward = -320;
        _index -= 1;
    } 
     
    if ( _index < 0 ) {
        _index = 0 ;
        return;
    }
    if (_index >= [_detailsDataSourceItems count]) { 
        _index = [_detailsDataSourceItems count] - 1;
         return;
    }

    self.detailController2  = [[[self.cls alloc]init]autorelease]; 
    [_detailController2 setDetailFromItem:[_detailsDataSourceItems objectAtIndex:_index]]; 
    _detailController2.view.frame = CGRectMake(_detailController2.view.frame.origin.x + toward, 0, _detailController2.view.frame.size.width, 365);
    [self.view addSubview:_detailController2.view];
    
    [UIView animateWithDuration:0.4 
                     animations:^{
                            for (UIView *view in [self.view subviews]) {
                                    view.frame = CGRectMake(view.frame.origin.x - toward, view.frame.origin.y, view.frame.size.width, 365);
                            }
                     }
                     completion:^(BOOL finished){ 
                         [self.detailController.view removeFromSuperview]; 
                         self.detailController = _detailController2;
                         self.detailController2 = nil;  // release tmp
                     }
     ];  
    if (self.navTitle == nil) {
        self.navTitle = @"详情页";
    }
    self.title = @"详情页"; //[NSString stringWithFormat:@"%@(%d/%d)",self.navTitle,_index+1,[_detailsDataSourceItems count]];
    NSLog(@"after:%@",[self.view subviews]);
     
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
 

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch { 
    return YES;
}

@end
