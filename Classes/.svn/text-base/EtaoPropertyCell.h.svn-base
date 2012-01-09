//
//  EtaoPropertyCell.h
//  etao4iphone
//
//  Created by iTeam on 11-9-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoCategoryNavController.h"
#import "EtaoAuctionItem.h"


@interface EtaoPropertyCell : UITableViewCell {
	NSString *_pid ; 
	NSString *_vid ; 
	
	EtaoPidVidItem *pidvid ;
	
	EtaoCategoryNavController *_parent ;
}

@property (nonatomic,assign) NSString *_pid ;  
@property (nonatomic,assign) NSString *_vid ; 
@property (nonatomic,assign) EtaoPidVidItem *_pidvid ;
@property (nonatomic,assign) EtaoCategoryNavController *_parent ;

- (void) setPid:(EtaoPidVidItem*)pid Vid:(EtaoPidVidItem*)vid;

@end

@interface EtaoCategoryCell : UITableViewCell {

	EtaoCategoryItem *_item;
	
	EtaoCategoryNavController *_parent ;
}

@property (nonatomic,assign) EtaoCategoryItem *_item ;
@property (nonatomic,assign) EtaoCategoryNavController *_parent ;

- (void) setCat:(EtaoCategoryItem*)cat;

@end


@interface EtaoBreadcrumbCell : UITableViewCell {
	
}

- (void) setPath:(NSArray*)path;
 

@end
