//
//  FirstInAlertViewController.m
//  etao4iphone
//
//  Created by 稳 张 on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETFirstInAlertViewController.h"


#define MOVE_MIN_DISTANCE 50

@interface ETFirstInAlertViewController() {
    int currentPageIndex;
//    bool isAnimationing; //是否正在移动中
//    CGPoint beginPoint;
//    UIImageView *currentImgView;
//    UIImageView *tmpImageView;
//    IBOutlet UIImageView *imgView1;
//    IBOutlet UIImageView *imgView2;
}

- (void) initFirstInAlertView;

//- (void) pageNext;
//- (void) pageBack;
//- (void) disPlayCurrentView;

- (UIImageView*) getImgViewByIndex:(int)index;

//-(void)imgFromLeft;

@end


@implementation ETFirstInAlertViewController

@synthesize itemsPageArray = _itemsPageArray;
@synthesize scrollView = _scrollView;
@synthesize delegate;

- (id)init {
    self = [super init];
    if (self) {
   
        [self initFirstInAlertView];
        // Initialization code here.
    }
    
    return self;
}


- (id)initWithItem:(ETFirstInAlertItem *)item {
    self = [super init];
    if (self) {
 
        [self initFirstInAlertView];
        // Initialization code here.
    }
    
    return self;
}


- (id)initWithArray:(NSArray *)itemArray {
    self = [super init];
    if (self) {
        
        if (_itemsPageArray) {
            [_itemsPageArray release];
        }
        
        _itemsPageArray = [[NSArray alloc] initWithArray:itemArray];

        [self initFirstInAlertView];
        // Initialization code here.
    }
    
    return self;
}


- (void) initFirstInAlertView {

    currentPageIndex = 0;
}


-(void) loadView {
    [super loadView];
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];

        [_scrollView setDelegate:self];
        [self.view addSubview:_scrollView];
        
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator=NO; //水平滚动条隐藏
        _scrollView.showsVerticalScrollIndicator=NO;//垂直滚动条隐藏
        //_scrollView.scrollsToTop = YES;
        [_scrollView setBackgroundColor:[UIColor colorWithRed:53/255.0f green:57/255.0 blue:65/255.0f alpha:1]];
    }
    
    [_scrollView setContentSize:CGSizeMake(320*_itemsPageArray.count,460)];

    for (int i=0; i<_itemsPageArray.count; i++) {
        UIImageView* imgView = [self getImgViewByIndex:i];
        [imgView setFrame:CGRectMake(320*i, 0, 320, 460)];
        [_scrollView addSubview:imgView];        
    }
}

+ (BOOL) isFirstShow {
    //__FIRSTINALERT__   
    NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"__FIRSTINALERT__"];
    if ([tempStr isEqualToString:@"__FIRSTINALERT__"]) {
        return NO;
    }
    
    return YES;
}


- (void) showFinished {
    [[NSUserDefaults standardUserDefaults] setObject:@"__FIRSTINALERT__" forKey:@"__FIRSTINALERT__"];    

    if ([delegate respondsToSelector:@selector(finishedDispaly)]) {
        [delegate performSelector:@selector(finishedDispaly)withObject:self];
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    
    currentPageIndex = index;
    //index为当前页码
    
    if (currentPageIndex == [_itemsPageArray count]-1) {

        int offset = ((int)scrollView.contentOffset.x)%((int)scrollView.frame.size.width);
        NSString* tempStr = [NSString stringWithFormat:@"__%d__", offset];
        
        NSLog(tempStr,nil);
        
        if (((int)scrollView.contentOffset.x)%((int)scrollView.frame.size.width) > 100) {
            [self showFinished];
        }
    }
}

//-(void) loadView {
//    [super loadView];
//    
//    imgView1 = [self getImgViewByIndex:0];
//    currentImgView = imgView1;
//    
//    [imgView2 setHidden:YES];
//    tmpImageView = imgView2;
//    
//    [self.view addSubview:imgView1];
//    [self.view addSubview:imgView2];
//}


//-(void) isPlayNextTime:(BOOL)isPlay {
//    
//}


//- (void) pageNext {
//
//    if ([_itemsPageArray count] >= currentPageIndex+1) {
//       
//    }
//
////    [self disPlayCurrentView];
//}


//- (void) disPlayCurrentView {
// 
//    if ([_itemsPageArray count] >= currentPageIndex) {
//        return;
//    }
// 
//    ETFirstInAlertItem* currentItem = [_itemsPageArray objectAtIndex:currentPageIndex];
//    
//    if (nil == currentItem) {
//        return;
//    }
//    
//    if ([currentItem view] == nil) {
//        
//        if ([currentItem imgName] == nil) {
//            return;
//        }
//        
//        currentItem.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//        [self.view addSubview:currentItem.view];
//    }
//    
//    //设置View的初始位置
//    [currentItem.view setFrame:CGRectMake(320, 0, 320, 480)];
//
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:0.4]; 
//    [currentItem.view setFrame:CGRectMake(0, 0, 320, 480)];
//    [UIView commitAnimations]; 
//}


- (UIImageView*) getImgViewByIndex:(int)index {
    if ([_itemsPageArray count] <= index) {
        return nil;
    }
    
    ETFirstInAlertItem* item = [_itemsPageArray objectAtIndex:index];
    
//    if (nil == currentItem) {
//        return nil;
//    }
    
    if ([item view] == nil) {
        
        if ([item imgName] == nil) {
            return nil;
        }
        
        item.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item.imgName]];
//        [self.view addSubview:currentItem.view];
    }

    return item.view;
}


- (void) pageBack {
    if (currentPageIndex == 0) {
        return;
    }
    
    currentPageIndex--;
//    [self disPlayCurrentView];
}


-(void) dealloc {
    
    [_itemsPageArray release];
    [_scrollView release];
//    [currentImgView release];
//    [tmpImageView release];
//    [imgView1 release];
//    [imgView2 release];
    
    [super dealloc];
}

//#pragma mark -
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    UITouch *touch = [touches anyObject];
//    beginPoint = [touch locationInView:self.view];
//    
//}
//
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    if (isAnimationing) {
//        return;
//    }
//    
//    UITouch *touch = [touches anyObject];
//    CGPoint currentPosition = [touch locationInView:self.view];
//    
//    CGFloat offsetW = currentPosition.x - beginPoint.x;
//    CGFloat offsetH = currentPosition.y - beginPoint.y;
//    
//    if (fabsf(offsetW) > fabsf(offsetH)) {
//        //左右移动
//        if (offsetW > MOVE_MIN_DISTANCE) {
//            [self imgFromLeft];
//        }
//        else if(offsetW < -MOVE_MIN_DISTANCE)
//        {
////            [self imgFromRight];
//        }
//    }
////    else
////    {
////        //上下移动
////        if (offsetH > MOVE_MIN_DISTANCE) {
////            [self imgFromUp];
////        }
////        else if(offsetH < -MOVE_MIN_DISTANCE)
////        {
////            [self imgFromBottom];
////        }
////    }
//}
//
//- (void)myAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
//{
//    NSLog(@"Animation stop");
//    if (currentImgView == imgView1) {
//        currentImgView = imgView2;
//        tmpImageView = imgView1;
//    }
//    else
//    {
//        currentImgView = imgView1;
//        tmpImageView = imgView2;
//    }
//    
//    [tmpImageView setHidden:YES];
//    isAnimationing = NO;
//}
//
//-(void)imgFromLeft
//{
//    //已经 是第一个了。就不在移动，如果想要循环显示的话，就设置 
//    /*
//     if (currentImgIndex <= 0) {
//     return  ;
//     }
//     */
//    // 循环
//    NSLog(@"imgFrom ----Left");
//    //currentImgIndex = (currentImgIndex+allImgNumber-1)%allImgNumber;
//    [tmpImageView setImage:[self getImgViewByIndex:currentPageIndex].image];// [_itemsPageArray objectAtIndex:currentPageIndex]];
//    [tmpImageView setHidden:NO];
//    [tmpImageView setFrame:CGRectMake(-320, 0, 320, 460)];
//    
//    isAnimationing = YES;
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.75f];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(myAnimationDidStop:finished:context:)];
//    
//    [tmpImageView setFrame:CGRectMake(0, 0, 320, 460)];
//    [currentImgView setFrame:CGRectMake(320, 0, 320, 460)];
//    
//    [UIView commitAnimations];
//}
//


@end
