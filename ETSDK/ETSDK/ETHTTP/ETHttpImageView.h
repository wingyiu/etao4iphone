//
//  ETHttpImageView.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETHttpRequest.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ETImageCache.h"
#import "ETLoadingCache.h"

@interface UIImage (Categories)
+ (UIImage *)emptyImageForSize:(CGSize)size;
+ (UIImage *)placeHolderForSize:(CGSize)size;
+ (UIImage *)imageWithName:(NSString *)name;
@end

@class ETHttpImageView;

@protocol EtaoHttpImageViewDelegate <NSObject>

@optional 

- (void) httpImageSizeRecive:(ETHttpImageView *)httpimage;

- (void) httpImageLoadFinished:(ETHttpImageView *)httpimage ;

- (void) httpImageLoadFailed:(ETHttpImageView *)httpimage ;
@end



@interface ETHttpImageView : UIImageView <ASIHTTPRequestDelegate>{ 
     id _delegate; 
     CGRect _imageRect;
}

@property (nonatomic, assign) id delegate; 

#pragma just a tag  
@property (assign) int tag;
@property (assign) CGSize size ;
@property (assign) int maxConcurrentOperationCount;
@property (assign) NSTimeInterval secondsToCache;
@property (assign, readonly) BOOL didUseCachedResponse; 
@property (nonatomic,assign) NSMutableDictionary *loadingImageDic ;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) UIImage *placeHolder;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) ASIHTTPRequest *http ;
@property (nonatomic, assign) ASINetworkQueue *networkQueue; 
@property (nonatomic, assign) CGRect imageRect;

+ (BOOL) GetJpgSize:(NSData *)data Size:(CGSize*)size;

- (void)load:(NSString *)str ; 

- (void) cancel ;

+ (NSThread *)threadForRequest;

@end
