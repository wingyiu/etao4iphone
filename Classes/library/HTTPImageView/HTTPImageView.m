//
//  HTTPImageView.m
//  taobao4iphone
//
//  Created by Xu Jiwei on 10-7-16.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import "HTTPImageView.h"

#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "TBMemoryCache.h"
#import "UIImage+EmptyImage.h"
#import "ASIDownloadCache.h"
#import "UIImage+Categories.h"

@implementation HTTPImageView

@synthesize url;
@synthesize networkQueue;
@synthesize memoryCache;
@synthesize placeHolder;
@synthesize isSyc;
@synthesize isProgress; 

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        self.placeHolder = [UIImage placeHolderForSize:frame.size];
    }
    isSyc = NO;
    isProgress = NO;
    return self;
}

- (id)init
{
    if(self = [super init]){
        isSyc = NO;
        isProgress = NO;
        _reciveLength = 0;
        self.userInteractionEnabled = YES;//这个选项决定了该view是否可以响应点击事件
        
        return self;
    }
    return nil;
    
}

- (void)setUrl:(NSString *)str {
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([str isEqualToString:url]) {
        return;
    }
    
    TB_RELEASE(url);
    url = [str copy];
    
    NSURL *imgURL = [url length] > 0 ? [NSURL URLWithString:url] : nil;
    
    if (imgURL != nil) {
        
        ASIHTTPRequest *httpRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
        httpRequest.delegate = self;
        [httpRequest setNumberOfTimesToRetryOnTimeout:3];
        httpRequest.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                self,   @"imageView",
                                url,    @"imageURL",
                                nil];
    
        if (self.memoryCache) {
            UIImage *img = [self.memoryCache objectForKey:url];
            if (img == nil) {
                if(isProgress){
                    httpRequest.downloadProgressDelegate = self; //设置progress 代理
                    
                    _progressLabel = [[UILabel alloc]initWithFrame:
                                      CGRectMake(self.frame.size.width/2-85, self.frame.size.height/2-20, 170, 40)];
                    _progressLabel.text = [NSString stringWithFormat:@"图片加载00%%"];
                    [_progressLabel setTextAlignment:UITextAlignmentCenter];
                    _progressLabel.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]; 
                    _activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]autorelease];
                    _activityView.frame = CGRectMake(10,11,20,20);
                    [_activityView startAnimating];
                    [_progressLabel addSubview:_activityView];
                    [self addSubview:_progressLabel];
                }
                
                if (self.networkQueue) {
                    [self.networkQueue addOperation:httpRequest];
                } else {
                    if(isSyc){
                        [httpRequest startSynchronous];
                    }
                    else{
                        [httpRequest startAsynchronous];
                    }
                }
            }
            else{
                self.image = img;
            }
            
        } else {
            httpRequest.cachePolicy = ASIOnlyLoadIfNotCachedCachePolicy;
            httpRequest.cacheStoragePolicy = ASICacheForSessionDurationCacheStoragePolicy;
            ASIDownloadCache *cache = [ASIDownloadCache sharedCache];
            httpRequest.downloadCache = cache;
            if ([cache canUseCachedDataForRequest:httpRequest]) {
                [httpRequest startSynchronous];
            } else {
                self.image = self.placeHolder;
                [httpRequest startAsynchronous];
            }
        }
        
    } else {
        self.image = [UIImage emptyImageForSize:self.bounds.size];
    }
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    NSString* content_length = [responseHeaders objectForKey:@"Content-Length"];
    _contentLength = [content_length longLongValue];
}

- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
    _reciveLength += bytes;
    _progressLabel.text = [NSString stringWithFormat:@"图片加载%2d%%",_reciveLength*100/_contentLength];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [_activityView stopAnimating];
    [_progressLabel removeFromSuperview];
    [_progressLabel release];
    
    UIImage *img = [UIImage imageWithData:[request responseData]];
    if (img == nil) {
        img = [UIImage emptyImageForSize:self.bounds.size];
    }
    
    NSString *imgurl = [(request.originalURL ?: request.url) absoluteString];
    
    if (self.memoryCache) {
        [self.memoryCache cacheObject:img forKey:imgurl];
    }
    
    if ([[request.userInfo objectForKey:@"imageURL"] isEqualToString:self.url]) {
        self.image = img;
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [_activityView stopAnimating];
    [_progressLabel removeFromSuperview];
    [_progressLabel release];
     self.image = [UIImage imageNamed:@"no_picture_80x80.png"];
}

#pragma mark -
#pragma mark Selection

- (void)showHoverShadow {
    if (hoverView == nil) {
        hoverView = [[UIView alloc] initWithFrame:self.bounds];
        hoverView.alpha = 0.3;
        hoverView.backgroundColor = [UIColor blackColor];
    }
    
    if (hoverView.superview != self) {
        hoverView.frame = self.bounds;
        [self addSubview:hoverView];
    }
}

- (void)setSelected:(BOOL)value animated:(BOOL)animated {
    if (value) {
        [self showHoverShadow];
        
    } else {
        if (animated) {
            [UIView beginAnimations:nil context:NULL];
            hoverView.alpha = 0;
            [UIView commitAnimations];
            [hoverView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
            
        } else {
            [hoverView removeFromSuperview];
        }
    }
}

#pragma mark -

- (void)dealloc {
    self.networkQueue = nil;
    self.url = nil;
    self.placeHolder = nil; 
    
    
    TB_RELEASE(hoverView);
    TB_RELEASE(memoryCache);
    
    [super dealloc];
}


@end
