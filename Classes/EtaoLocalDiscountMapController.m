    //
//  EtaoLocalDiscountMapController.m
//  etao4iphone
//
//  Created by iTeam on 11-8-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalDiscountMapController.h"


@implementation EtaoLocalDiscountMapController

@synthesize mapView;

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
    self.title = @"位置";
}
 
- (void) locate:(EtaoLocalDiscountItem*)item{
	//MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
	MKMapView *mv = [[MKMapView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-44)];
    mv.mapType = MKMapTypeStandard;
	
	
	CLLocation *location = [[CLLocation alloc]initWithLatitude:item.coordinate.latitude longitude:item.coordinate.longitude]; // {31.230381,121.473727};
	MKCoordinateRegion userLoc = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000.0, 1000.0);
	[location release];
	[mv setRegion:userLoc animated:NO]; 
	
	[self.view addSubview:mv];
	self.mapView = mv ;
	[self.mapView addAnnotation:item]; 
	[mv release];
	
}

- (NSString *)imageNameForAnnotaion:(id <MKAnnotation>)annotation {
    NSString * image = nil;
    if ([annotation isKindOfClass:[EtaoLocalDiscountItem class]]) {
		EtaoLocalDiscountItem *item = (EtaoLocalDiscountItem*)annotation;
        switch ([item.itemType intValue]) {
            case EtaoDiscountItemTypeCatering:
                image = @"etao_annotation_image_category_catering";
                break;
            case EtaoDiscountItemTypeEntertainment:
                image = @"etao_annotation_image_category_entertainment";
                break;
            case EtaoDiscountItemTypeLiving:
                image = @"etao_annotation_image_category_living";
                break;
            default:
                break;
        }
        
    }
	
    return image;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[EtaoLocalDiscountItem class]]) {   
		static NSString * locationIdentifier = @"LocationPoint";
		
		NSString *imageUnselectedName = [self imageNameForAnnotaion:annotation];
		UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", imageUnselectedName]];
		
        MKAnnotationView * pinAnnotationView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:locationIdentifier];
        if (pinAnnotationView == nil) {
            pinAnnotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:locationIdentifier] autorelease];
			pinAnnotationView.canShowCallout = NO; 
            pinAnnotationView.image = image;
        }else {
            pinAnnotationView.image = image;
         	[pinAnnotationView setAnnotation:annotation];   
        }
        
        return pinAnnotationView;  
	}
	return nil;  
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
