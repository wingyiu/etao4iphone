//
//  EtaoLocalListTableViewCell.h
//  etao4iphone
//
//  Created by iTeam on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoLocalDiscountItem.h"

@interface EtaoLocalListTableViewCell : UITableViewCell {

}
 
@property (assign) int _idx ;
@property (nonatomic,retain) EtaoLocalDiscountItem* _item ;
- (void) set:(EtaoLocalDiscountItem*)item;

+ (int) height;

@end
