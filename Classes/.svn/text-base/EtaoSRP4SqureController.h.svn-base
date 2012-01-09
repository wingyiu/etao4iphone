//
//  EtaoSRP4SqureController.h
//  etao4iphone
//
//  Created by 稳 张 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomSearchBarController.h"
#import "EtaoSRPDataSource.h"
#import "EtaoSRPRequest.h"
#import "HttpRequest.h"

#import "EtaoAuctionViewCell.h"
#import "EtaoProductViewCell.h"
#import "EtaoMenuView.h"
#import "EtaoCustomButtonView.h"

#import "SearchDetailController.h" 
#import "ETaoUIViewController.h"
#import "EtaoUIViewWithBackgroundController.h"
#import "EtaoLocalListHeadDistanceView.h"


@interface EtaoSRP4SqureController : ETaoUIViewController<UIScrollViewDelegate,UINavigationBarDelegate> {
    
	UIScrollView* _scrollView;
    
	NSString *_keyword ;
	NSString *_catid ; 
	NSString *_ppath ;
	NSString *_sort ;
	
	EtaoLocalListHeadDistanceView *_head ;
	
	EtaoMenuView *_rankView ;
	
	BOOL _isLoading ;
	
	SearchDetailController *_detailDirect ;
	
	EtaoCustomButtonView *_rankbtnv;

}

- (void) requestFinished:(EtaoSRPRequest *)request;

- (void) requestFailed:(EtaoSRPRequest *)request;

- (void) loadMoreFrom:(int)s TO:(int)e;

- (void) loadMoreFrom:(NSArray*)startEnds;

- (void) search:(NSString*)keyword;

- (void) searchWord:(NSString*)word cat:(NSString*)cat ppath:(NSString*)ppath;


@property (nonatomic, retain) UIScrollView* scrollView;

@property (nonatomic,retain) EtaoSRPDataSource *_srpdata; 
@property (nonatomic,assign) BOOL _isLoading ; 
@property (nonatomic,assign) BOOL _requestFailed ; 
@property (nonatomic,retain) NSString *_keyword ;
@property (nonatomic,retain) NSString *_catid ;
@property (nonatomic,retain) NSString *_ppath ;
@property (nonatomic,retain) NSString *_sort ;
@property (nonatomic,retain) EtaoLocalListHeadDistanceView *_head ;
@property (nonatomic,retain) EtaoMenuView *_rankView ;
@property (nonatomic,retain) SearchDetailController *detailDirect ;
@property (nonatomic,retain) EtaoCustomButtonView *_rankbtnv;
@property (nonatomic,retain) EtaoSRPRequest *_httpquery;

@end
