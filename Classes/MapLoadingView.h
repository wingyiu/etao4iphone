//
//  MapLoadingView.h
//  etao4iphone
//
//  Created by iTeam on 11-9-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ActivityIndicatorMessageView.h"

@interface MapLoadingView : ActivityIndicatorMessageView {

}

- (id)initWithFrame:(CGRect)frame Message:(NSString*)msg;

@end
