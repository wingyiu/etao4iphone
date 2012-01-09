//
//  ETTableViewCell.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETTableViewCell.h"
#import "ETImageCache.h"
@class ETTableViewCell ;
@implementation ETTableViewContentView 
@synthesize item = _item ;

- (void) drawRect:(CGRect)rect{ 
    [self setBackgroundColor:[UIColor whiteColor]];  
    
    [(ETTableViewCell *)[self superview] drawContentView:_item in:rect];
    
}

@end


@implementation ETTableViewImageView 
@synthesize image = _image ;

- (void) drawRect:(CGRect)rect{   
    [self setBackgroundColor:[UIColor whiteColor]];  
    
    [(ETTableViewCell *)[self superview] drawImageView:_image in:rect];
}

@end

@implementation ETTableViewCell
@synthesize queue = _queue;
@synthesize loadingImageDic = _loadingImageDic;

@synthesize item = _item; 
@synthesize mainImage = _mainImage ;

@synthesize pictUrl = _pictUrl ;
@synthesize etContentView = _etContentView ;
@synthesize etImageView = _etImageView ; 
@synthesize httpImageRequestArr = _httpImageRequestArr;

@synthesize accessLock = _accessLock;

- (void) dealloc {
    NSLog(@"%s",__FUNCTION__);
    [_item release];
    [_etContentView release];
    [_etImageView release];
    [_pictUrl release];
    [_mainImage release];
    [_accessLock release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.opaque = YES; 
        //   self.selectionStyle = UITableViewCellSelectionStyleNone ;
        _etContentView = [[ETTableViewContentView alloc]initWithFrame:CGRectZero]; 
        _etImageView = [[ETTableViewImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _etContentView.opaque = YES; 
        _etImageView.opaque = YES;
        
        _accessLock = [[NSRecursiveLock alloc]init]; 

        [self addSubview:_etContentView];
        [self addSubview:_etImageView]; 
    }
    return self;
}

+ (int) height  {
    return 90 ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void) setFrame:(CGRect)f{
	[super setFrame:f];
	_etContentView.frame = CGRectMake(0,0,f.size.width ,f.size.height-1);
//	[_etContentView setNeedsDisplay];
}


- (void) setImageFrame:(CGRect) f{
    imageRect = f;
    _etImageView.frame = f;
//	[_etImageView setNeedsDisplay];
}

/*
- (void) setNeedsDisplay{
	[super setNeedsDisplay];
	[_etImageView setNeedsDisplay];
 	[_etContentView setNeedsDisplay];   
}
*/
/*
- (void) layoutSubviews{
	[super layoutSubviews];
	self.contentView.hidden = YES;
	[self.contentView removeFromSuperview];
	[self setNeedsDisplay];
}
*/
- (UIImage*)resizeImage:(UIImage*)image toWidth:(NSInteger)width height:(NSInteger)height
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize size = CGSizeMake(width, height);
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    else
        UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Flip the context because UIKit coordinate system is upside down to Quartz coordinate system
    CGContextTranslateCTM(context, 0.0, height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Draw the original image to the context
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, width, height), image.CGImage);
    
    // Retrieve the UIImage from the current context
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)targetSize {
    //If scaleFactor is not touched, no scaling will occur      
    CGFloat scaleFactor = 1.0;
    
    //Deciding which factor to use to scale the image (factor = targetSize / imageSize)
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

- (void) setItem:(id<NSObject>)item url:(NSString*) url{
    self.item = item;
    _etImageView.image = nil;
    _etContentView.item = _item;
    [_etContentView setNeedsDisplay];
    self.pictUrl = url;
    
    ETImageCache *sharedCache = [ETImageCache sharedCache];
    _mainImage = [sharedCache objectForKey:_pictUrl];
    if (_mainImage == nil ) { 
        BOOL found = NO;
        for (ETHttpImageView *httpImg in _httpImageRequestArr){
            if ([httpImg.url isEqualToString:_pictUrl]) {
                found = YES;
                break;
            }
        }  
        
        // 不在队列里面
        if (!found) {  
            ETHttpImageView *httpImage = [[[ETHttpImageView alloc] init]autorelease]; 
            httpImage.delegate = self;
            httpImage.imageRect = imageRect; 
            [_httpImageRequestArr addObject:httpImage];
            [httpImage load:url]; 
        }
    }    
    else{ 
        _etImageView.image = _mainImage;
    }
    [_etImageView setNeedsDisplay];      
}

- (void) httpImageLoadFinished:(ETHttpImageView *)httpimage {  
 
    [_accessLock lock];
    NSMutableArray *deltmp = [[NSMutableArray alloc]initWithCapacity:10];
    ETHttpImageView *tmp = nil;
    for (ETHttpImageView *httpImg in _httpImageRequestArr) { 
        if ([httpImg.url isEqualToString:httpimage.url]) {
            [deltmp addObject:httpImg]; 
            tmp = httpImg ;
            break;
        }
    }
    for (ETHttpImageView *httpImg in deltmp) {
        [_httpImageRequestArr removeObject:httpImg];
    }
    [deltmp release]; 
    [_accessLock unlock];  

    if ([tmp.url isEqualToString:_pictUrl]) {
        _etImageView.image = tmp.image;  
        [_etImageView setNeedsDisplay]; 
    }
  
}

- (void) httpImageLoadFailed:(ETHttpImageView *)httpimage {  
    [_accessLock lock];
    NSMutableArray *deltmp = [[NSMutableArray alloc]initWithCapacity:10];
    ETHttpImageView *tmp = nil;
    for (ETHttpImageView *httpImg in _httpImageRequestArr) { 
        if ([httpImg.url isEqualToString:httpimage.url]) {
            [deltmp addObject:httpImg]; 
            tmp = httpImg ;
        }
    }
    for (ETHttpImageView *httpImg in deltmp) {
        [_httpImageRequestArr removeObject:httpImg];
    }
    [deltmp release]; 

    [_accessLock unlock]; 
}

- (void) drawContentView:(id)it in:(CGRect)rect {  
    [self setBackgroundColor:[UIColor whiteColor]];     
}

- (void) drawImageView:(UIImage*)img in:(CGRect)rect{  
    [self setBackgroundColor:[UIColor whiteColor]];      
}

@end
