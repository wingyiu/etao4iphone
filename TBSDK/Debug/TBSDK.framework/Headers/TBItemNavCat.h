//
//  TBItemNavCat.h
//  TBSDK
//
//  Created by HanFeng on 11-7-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

@interface TBItemNavCat : TBModel {
	NSString *categoryId;
    NSString *name;
    NSNumber *auctionCount;
}

@property (nonatomic, retain) NSString *categoryId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *auctionCount;

@end
