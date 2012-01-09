//
//  EtaoLocalListHeadDistanceView.h
//  etao4iphone
//
//  Created by iTeam on 11-8-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EtaoLocalListHeadDistanceView : UIView {
	UILabel *_textLabel;
}

@property (nonatomic ,retain) UILabel *_textLabel;

- (void) setText:(NSString*)str;
- (void) setTextForSRP:(NSString*)key Total:(int)t Now:(int)n;
- (void) setTextForLocal:(NSString*)distance Total:(int)t Now:(int)n;
@end
