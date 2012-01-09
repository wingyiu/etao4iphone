//
//  EtaoCategoryNavController.h
//  etao4iphone
//
//  Created by iTeam on 11-9-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoSRPDataSource.h"
#import "EtaoSRPRequest.h"  
#import "EtaoAuctionViewCell.h"
#import "EtaoSRPController.h"
#import "EtaoUIViewWithBackgroundController.h"
#import "ETaoUIViewController.h"
@interface EtaoCategoryNavController : ETaoUIViewController <UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UINavigationBarDelegate> {

	EtaoSRPDataSource *_srpdata; 
	
	UITableView *_tableView;  
	
	NSString *_keyword ;
	
	NSString *_catid ;
	
	NSString *_ppath ;
	
	NSMutableDictionary *_pidvid ; 
	
	BOOL _isLoading ;
	
	BOOL _isCatMode;
}
 

- (id) initWithWord:(NSString*)word cat:(NSString*)cat pidvid:(NSString*)pv ;

- (void) requestFinished:(EtaoSRPRequest *)request;

- (void) requestFailed:(EtaoSRPRequest *)request;

- (void) loadMoreFrom:(int)s TO:(int)e;

- (void) search ;

- (void) searchWord:(NSString*)word cat:(NSString*)cat pidvid:(NSString*)pv ;
 
@property (nonatomic,retain) EtaoSRPDataSource *_srpdata; 
@property (nonatomic,assign) BOOL _isLoading ; 
@property (nonatomic,assign) BOOL _isCatMode ;
@property (nonatomic,retain) UITableView *_tableView; 
@property (nonatomic,retain) NSString *_keyword ; 
@property (nonatomic,retain) NSString *_catid ;
@property (nonatomic,retain) NSString *_ppath ;
@property (nonatomic,retain) NSMutableDictionary *_pidvid ;


@end
