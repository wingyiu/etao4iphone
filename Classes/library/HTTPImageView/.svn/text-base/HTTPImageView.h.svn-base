//
//  HTTPImageView.h
//  taobao4iphone
//
//  Created by Xu Jiwei on 10-7-16.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPRequest.h"

@class ASINetworkQueue;
@class TBMemoryCache;
@class ASIDownloadCache;

@interface HTTPImageView : UIImageView <ASIHTTPRequestDelegate ,ASIProgressDelegate> {
    NSString            *url;
    UIImage             *placeHolder;
    
    UIView              *hoverView;
     
    
    
    ASINetworkQueue     *networkQueue;
    TBMemoryCache       *memoryCache;
    
    BOOL    isSyc;
    BOOL    isProgress;
    long long _contentLength;
    long long _reciveLength;
    
    UILabel* _progressLabel;
    UIActivityIndicatorView *_activityView;
}

- (void)setSelected:(BOOL)value animated:(BOOL)animated;

@property (nonatomic, retain) UIImage *placeHolder;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, retain) ASINetworkQueue *networkQueue; 
@property (nonatomic, retain) TBMemoryCache *memoryCache;
@property (nonatomic,assign) BOOL isSyc;
@property (nonatomic,assign) BOOL isProgress;

@end
