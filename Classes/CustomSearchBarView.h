//
//  CustomSearchBarView.h
//  etao4iphone
//
//  Created by iTeam on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomSearchBarView : UIView {
	
	UITextField *_textField;
	
	UIBarButtonItem *_searchFieldButton ;

}

@property(nonatomic,retain) UITextField *_textField;
@property(nonatomic,retain) UIBarButtonItem *_searchFieldButton ;
@end
