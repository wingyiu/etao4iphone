//
//  EtaoTopQueryView.h
//  etao4iphone
//
//  Created by iTeam on 11-9-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequest.h"
#import "EtaoQueryView.h"

#import "EtaoQueryTypeView.h"
@interface EtaoTopQueryView : UIView {

	id delegate ;
	

}

@property (nonatomic, assign) id delegate; 
@property (nonatomic, assign) SEL action; 

@property (nonatomic, retain) EtaoQueryView *_queryView;
@property (nonatomic, retain) NSMutableArray *_topQueryArray;
@property (nonatomic, retain) EtaoQueryTypeView *_queryType; 
@property (nonatomic, assign) int _idx ;

- (void) requestFinished:(HttpRequest *)request;

- (void) requestFailed:(HttpRequest *)request;

- (void) setInfo:(NSString*)jsonContent ;

@end
