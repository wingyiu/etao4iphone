//
//  EtaoPriceDetailController.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoPriceAuctionItem.h"
#import "HTTPImageView.h"
#import "TBMemoryCache.h"
#import "TBWebViewControll.h"
#import "EtaoPriceMainViewController.h"
#import "ETDetailSwipeController.h"

@interface touchController:UIButton
@end


@interface shopViewTouchController:UIView{
    EtaoPriceAuctionItem* _item;
    touchController* _touchcontroller;
    UILabel* _goseesee;

}
@property(nonatomic,assign)  EtaoPriceAuctionItem* item;
@property(nonatomic,assign) touchController* touchcontroller;
@property(nonatomic,assign) UILabel* goseesee;
@end

@interface EtaoPriceDetailController : ETaoUIViewController <ETDetailSwipeInsiderControllerDelegate>
{
    EtaoPriceAuctionItem* _item;
    touchController* _touchcontroller;
    UIView* _imageBGView;
    HTTPImageView* _imgView;
    UIView* _auctionView;
    shopViewTouchController* _shopView;
    
}
@property(nonatomic,retain)HTTPImageView* imgView;

@property(nonatomic,retain) EtaoPriceAuctionItem* item;

- (void)jumpTo:(id)sender;
- (void) constructUserConmentsImgView:(UIView*)parent cmtScore: (float)pr;
@end
