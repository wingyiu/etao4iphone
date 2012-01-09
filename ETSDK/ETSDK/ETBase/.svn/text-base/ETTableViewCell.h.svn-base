//
//  ETTableViewCell.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ETaoModel.h"
#import "ETHttpImageView.h"
#import "ASINetworkQueue.h"
#import "ETLoadingCache.h"

@interface ETTableViewContentView : UIView { 
}
@property (nonatomic,retain) id<NSObject> item ; 
@end


@interface ETTableViewImageView : UIView { 
}
@property (nonatomic,retain) UIImage *image ;
@end

@interface ETTableViewCell : UITableViewCell
{
    CGRect imageRect;
    NSRecursiveLock *_accessLock;
}


@property (nonatomic,retain) id<NSObject> item ; 
@property (nonatomic,retain) UIImage *mainImage ;
@property (nonatomic,assign) ASINetworkQueue *queue ;
@property (nonatomic,assign) NSMutableDictionary *loadingImageDic ; 

@property (nonatomic,retain) NSString *pictUrl; 
@property (nonatomic,retain) ETTableViewContentView *etContentView ;
@property (nonatomic,retain) ETTableViewImageView *etImageView ;

@property (nonatomic,retain) NSMutableArray *httpImageRequestArr;


@property (retain) NSRecursiveLock *accessLock;

+ (int) height  ;

- (void) setImageFrame:(CGRect) f;

- (void) setItem:(id<NSObject>)item url:(NSString*) url;
- (void) drawImageView:(UIImage*)img in:(CGRect)rect ;
- (void) drawContentView:(id)it in:(CGRect)rect ;

@end
