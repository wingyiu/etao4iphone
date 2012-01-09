//
//  EtaoAuctionSRPTableViewCell1.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoAuctionItem.h" 

#import "EtaoProductItem.h"
#import "ETTableViewCell.h"
@interface EtaoAuctionSRPTableViewCell : ETTableViewCell 
 

- (void) drawImageView:(UIImage*)img in:(CGRect)rect ;
- (void) drawContentView:(id)it in:(CGRect)rect ;

@end
