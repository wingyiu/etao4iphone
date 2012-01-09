//
//  EtaoHomeViewController.h
//  etao4iphone
//
//  Created by iTeam on 11-9-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSearchBarController.h"   
#import "HttpRequest.h"

#import "EtaoTopQueryView.h"
#import "EtaoHomeTuanView.h"

#import "UpdateSessionDelegate.h"

@class UpdateSession;

@interface EtaoHomeViewController :  CustomSearchBarController <UITextFieldDelegate, UpdateSessionDelegate> {
	
     UpdateSession* _updateSession;
}

- (void) TopQueryrequestFinished:(HttpRequest *)request;

- (void) TopQueryrequestFailed:(HttpRequest *)request;


@property (nonatomic,retain) EtaoTopQueryView* _topqueryView ;
@property (nonatomic,retain) EtaoHomeTuanView* _tuanView ;

@property (nonatomic,retain) NSString *_topQueryJson;

@property (nonatomic, retain) UpdateSession* updateSession;

@end
