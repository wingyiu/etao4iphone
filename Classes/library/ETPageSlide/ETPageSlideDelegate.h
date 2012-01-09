//
//  ETPageSlideDelegate.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ETPageSlideDelegate <NSObject>
- (UIViewController *)pageForColAtIndexPath:(NSNumber *)index;
- (void) slidePageForColAtIndexPath:(NSNumber *)index withCtrls:(UIViewController*)controller;
- (NSMutableArray *)getAllHeaders;
- (NSMutableArray *)getAllKeys;
@end
