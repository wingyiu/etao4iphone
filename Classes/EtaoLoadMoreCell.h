//
//  EtaoLoadMoreCell.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EtaoLoadMoreCell : UITableViewCell {
 
    UIViewController *_parent; 
	
}

@property (nonatomic,assign) UIViewController *_parent;
 
@property (nonatomic, assign) id delegate; 
@property (nonatomic, assign) SEL action; 

- (void) setReload;

@end
