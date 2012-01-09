//
//  ETHttpImageView.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETHttpImageView.h"
#import "ETDownloadCache.h"

 

@implementation UIImage (Categories)



+ (UIImage *)emptyImageForSize:(CGSize)size {
    int width = MAX(size.width, size.height);
    width = ceil(width/20.0) * 20;
    
    UIImage *img = [UIImage imageWithName:[NSString stringWithFormat:@"no_picture_%dx%d.png", width, width]];
    return img ? img : [UIImage imageWithName:@"no_picture_80x80.png"];
}

+ (UIImage *)imageWithName:(NSString *)name {
    static float sysver = 0;
    if (sysver == 0) {
        sysver = [[[UIDevice currentDevice] systemVersion] floatValue];
    }
    
    if (sysver >= 4.0) {
        return [UIImage imageNamed:name];
    }
    
    if ([name length] > 4 && [[name substringFromIndex:[name length]-4] isEqualToString:@".png"]) {
        return [UIImage imageNamed:name];
    }
    
    return [UIImage imageNamed:[name stringByAppendingString:@".png"]];
}

+ (UIImage *)placeHolderForSize:(CGSize)size {
    int width = MAX(size.width, size.height);
    width = ceil(width/20.0) * 20;
    
    UIImage *img = [UIImage imageWithName:[NSString stringWithFormat:@"picture_holder_%dx%d.png", width, width]];
    return img ?: [UIImage imageWithName:@"picture_holder_360x360.png"];
}

@end

@implementation ETHttpImageView
@synthesize tag ,size ,delegate;
@synthesize maxConcurrentOperationCount = _maxConcurrentOperationCount;
@synthesize url = _url ;
@synthesize placeHolder = _placeHolder ; 
@synthesize data = _data ; 
@synthesize secondsToCache = _secondsToCache;
@synthesize didUseCachedResponse = _didUseCachedResponse;
@synthesize http = _http ;
@synthesize networkQueue = _networkQueue ;
@synthesize loadingImageDic = _loadingImageDic;
@synthesize imageRect = _imageRect;

static NSThread *decodeThread = nil ;
static NSOperationQueue* sharedQueue = nil ;
static NSRecursiveLock *httpImageAccessLock = nil;

+(NSOperationQueue*) sharedQueue {
    if (sharedQueue == nil) {
        sharedQueue = [[NSOperationQueue alloc]init];
        [sharedQueue setSuspended:NO];
        [sharedQueue setMaxConcurrentOperationCount:4];
    }
    return  sharedQueue;
}

+(NSRecursiveLock*) sharedImageLock {
    if (httpImageAccessLock == nil) {
        httpImageAccessLock = [[NSRecursiveLock alloc]init]; 
    }
    return  httpImageAccessLock;
}

- (void) dealloc {
    NSLog(@"%s",__FUNCTION__); 
    if (_http != nil) {
        [_http cancel];
        _http.delegate = nil;
        [_http clearDelegatesAndCancel]; 
        self.http = nil ;
    } 
    
    [_placeHolder release];
    _placeHolder = nil ;
    [_data release];
    
    _data = nil ;
    delegate = nil ;
     
    self.url = nil ; 
    
    [super dealloc];
}

- (void) cancel {
    if (_http != nil) {
        [_http cancel];
        _http.delegate = nil;
        [_http clearDelegatesAndCancel];  
        self.delegate = nil;
    }  
}
- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        _secondsToCache = 0 ;
        _maxConcurrentOperationCount = 10 ;
        _imageRect = frame;
        self.placeHolder = [UIImage placeHolderForSize:frame.size];
    } 
    return self;
}

- (id)init
{
    if(self = [super init]){ 
     //   _secondsToCache = 3600 ;
        _maxConcurrentOperationCount = 10 ;
        //self.userInteractionEnabled = YES;//这个选项决定了该view是否可以响应点击事件
        return self;
    }
    return nil;
    
}
 

- (void)load:(NSString *)str {
      
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([str isEqualToString:_url]) {
        return;
    } 
    self.url = str;
    self.data = [NSMutableData dataWithCapacity:128]; 
    NSURL *imgURL = [_url length] > 0 ? [NSURL URLWithString:_url] : nil; 
    _didUseCachedResponse = NO;
    
    // 检查内存图片cache
    ETImageCache *sharedCache = [ETImageCache sharedCache];
    UIImage *image = [sharedCache objectForKey:_url];
    if (image != nil) {
        self.image = image;
        
        self.size = self.image.size;
        SEL sizeRecive = @selector(httpImageSizeRecive:);
        if (self.delegate && [self.delegate respondsToSelector:sizeRecive]) { 
            [self.delegate performSelector:sizeRecive withObject:self afterDelay:0.0];
        } 
        
        SEL loadFinished = @selector(httpImageLoadFinished:);
        if (self.delegate && [self.delegate respondsToSelector:loadFinished]) { 
            [self.delegate performSelector:loadFinished withObject:self afterDelay:0.0];
        }
        
        return ; 
    }
    
    // 检查文件cache
    ETDownloadCache *cache = [ETDownloadCache sharedCache];
    NSData* data = [cache objectForKey:str];
    if (data != nil ) { 
        _didUseCachedResponse = YES; 
        [_data setData:data];
        
        [self performSelector:@selector(requestFinishedThread) onThread:[[self class] threadForRequest] withObject:nil waitUntilDone:NO];
        
        return;
    }
     
    if ( imgURL != nil) {
        self.http = [ASIHTTPRequest requestWithURL:imgURL]; 
        _http.delegate = self;  
        _http.tag = [self hash];
        [_http setNumberOfTimesToRetryOnTimeout:5]; 
        
        if (self.networkQueue) {  
            [self.networkQueue addOperation:_http];
        }
        else {
        //    [[ASIHTTPRequest sharedQueue]setMaxConcurrentOperationCount:_maxConcurrentOperationCount];
            [_http startAsynchronous];
        } 
        
    } else {
        self.image = [UIImage emptyImageForSize:self.bounds.size];
    } 
   
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)targetSize {
    //If scaleFactor is not touched, no scaling will occur      
    CGFloat scaleFactor = 1.0;
    
    //Deciding which factor to us e to scale the image (factor = targetSize / imageSize)
    if (image.size.width > targetSize.width || image.size.height > targetSize.height)
        if (!((scaleFactor = (targetSize.width / image.size.width)) > (targetSize.height / image.size.height))) //scale to fit width, or
            scaleFactor = targetSize.height / image.size.height; // scale to fit heigth.
    
    UIGraphicsBeginImageContext(targetSize); 
    
    //Creating the rect where the scaled image is drawn in
    CGRect rect = CGRectMake((targetSize.width - image.size.width * scaleFactor) / 2,
                             (targetSize.height -  image.size.height * scaleFactor) / 2,
                             image.size.width * scaleFactor, image.size.height * scaleFactor);
    
    //Draw the image into the rect
    [image drawInRect:rect];
    
    //Saving the image, ending image context
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
 
#pragma mark ------新起线做渲染------
 
+ (void)runRequests
{
	// Should keep the runloop from exiting
	CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
	CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
	CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    
    BOOL runAlways = YES; // Introduced to cheat Static Analyzer
	while (runAlways) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		CFRunLoopRun();
		[pool drain];
	}
    
	// Should never be called, but anyway
	CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
	CFRelease(source);
}

+ (NSThread *)threadForRequest
{
	if (decodeThread == nil) {
		@synchronized(self) {
			if (decodeThread == nil) {
				decodeThread = [[NSThread alloc] initWithTarget:self selector:@selector(runRequests) object:nil];
				[decodeThread start];
			}
		}
	}
	return decodeThread;
}

- (void)_decodeImageDone{ 
    
    if (self.image != nil) {
        // set cache
        ETImageCache *sharedCache = [ETImageCache sharedCache];
        [sharedCache cacheImage:self.image forKey:self.url]; 
    }

    SEL loadFinished = @selector(httpImageLoadFinished:);
    if (self.delegate && [self.delegate respondsToSelector:loadFinished]) { 
        [self.delegate performSelector:loadFinished withObject:self ];
    }   
}

- (void) requestFinishedThread{ 
    UIImage *img = [UIImage imageWithData:_data];
    if (img == nil) {
        img = [UIImage emptyImageForSize:self.bounds.size];
    }   
    if ( _secondsToCache != 0 ) {
        ETDownloadCache *cache = [ETDownloadCache sharedCache];
        [cache cacheObject:_data forKey:_url maxAge:_secondsToCache];
    } 
    
     
    if (_imageRect.size.width == 0 && _imageRect.size.height == 0 ) {
        self.image = img; 
        self.size = img.size;
    }
    else
    {
        //缩放 图片数据
        self.image = [self scaleImage:img toSize:self.imageRect.size];  
    }
           
    // release http we donot needit 
    self.http = nil;
    
    [self performSelectorOnMainThread:@selector(_decodeImageDone) withObject:nil waitUntilDone:NO];
 
}
 

- (void) requestFinished:(ASIHTTPRequest *)request {
  
    [self performSelector:@selector(requestFinishedThread) onThread:[[self class] threadForRequest] withObject:nil waitUntilDone:NO];
}



# pragma requestFinished when http fail
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    //NSLog(@"%@",responseHeaders);
}

- (void) requestFailed:(ASIHTTPRequest *)request {  
    
    self.image = [UIImage imageNamed:@"no_picture_80x80.png"];
   // self.image = nil;
    [self performSelectorOnMainThread:@selector(_decodeImageDone) withObject:nil waitUntilDone:NO];
    SEL loadFailed = @selector(httpImageLoadFailed:);
    if (self.delegate && [self.delegate respondsToSelector:loadFailed]) { 
        //  [self.delegate performSelector:loadFailed withObject:self ];
        [self.delegate httpImageLoadFailed:self];
    }
    // release http 
    self.http = nil ;

}

- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data{  
    [_data appendData:data];
    if (self.size.width == 0 && self.size.height == 0 ) {
        if ([_data length] > 128) {
            if ([ETHttpImageView GetJpgSize:_data Size:&size]) { 
                SEL sizeRecive = @selector(httpImageSizeRecive:);
                if (self.delegate && [self.delegate respondsToSelector:sizeRecive]) { 
                    [self.delegate performSelector:sizeRecive withObject:self ];
                } 
            }
        } 
    }
    
}


+ (BOOL) GetJpgSize:(NSData *)data Size:(CGSize*)size{ 
    const unsigned char *pData = (unsigned char *)[data bytes];
    int FileSizeLow = [data length];
    unsigned int i = 0;
    //if ((pData[i] == 0xFF) && (pData[i + 1] == 0xD8) && (pData[i + 2] == 0xFF) && (pData[i + 3] == 0xDB)) {
    if ((pData[i] == 0xFF) && (pData[i + 1] == 0xD8)) {
        
        i += 4;
        
        // Check for valid JPEG header (null terminated JFIF)
        //      if ((pData[i + 2] == 'J') && (pData[i + 3] == 'F') && (pData[i + 4] == 'I') && (pData[i + 5] == 'F')
        //          && (pData[i + 6] == 0x00) ) { 
        
        //Retrieve the block length of the first block since the first block will not contain the size of file
        unsigned short block_length = pData[i] * 256 + pData[i + 1];
        
        while (i < FileSizeLow) {
            //Increase the file index to get to the next block
            i += block_length; 
            
            if (i >= FileSizeLow) {
                //Check to protect against segmentation faults
                return NO;
            }
            
            if (pData[i] != 0xFF) {
                return NO;
            } 
            
            if (pData[i + 1] == 0xC0) {
                //0xFFC0 is the "Start of frame" marker which contains the file size
                //The structure of the 0xFFC0 block is quite simple [0xFFC0][ushort length][uchar precision][ushort x][ushort y]
                size->height = pData[i + 5] * 256 + pData[i + 6];
                size->width  = pData[i + 7] * 256 + pData[i + 8]; 
                return YES;
            }
            else {
                i += 2; //Skip the block marker
                
                //Go to the next block
                block_length = pData[i] * 256 + pData[i + 1];
            }
        }
        
        //If this point is reached then no size was found
        return NO;
        //  }
        // else {
        //      return size;
        //  } //Not a valid JFIF string
    }
    else {
        return NO;
    } //Not a valid SOI header
    
    return NO;
} 
@end
