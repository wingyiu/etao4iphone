//
//  ETFilterViewController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETFilterItem : NSObject {
    
}
@property (nonatomic,retain) id object ;
@property (nonatomic,retain) NSString *title ;
@property (nonatomic,retain) UIImage  *image ; 
@end


@interface ETFilterViewController : UITableViewController

@property (nonatomic,retain) NSMutableArray *items; 
@property (nonatomic,retain) NSString *headTitle ;

@property (nonatomic, assign) id delegate; 

@end

 