//
//  ETaoNetWorkAlert.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ETaoNetWorkAlert : NSObject <UIAlertViewDelegate>
{
    
}
 
+ (ETaoNetWorkAlert*) alert ;
- (void) show ;
- (void) showLocation ;

@end
