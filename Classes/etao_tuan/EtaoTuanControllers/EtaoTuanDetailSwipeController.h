//
//  EtaoTuanDetailSwipeController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETDetailSwipeController.h"
#import "EtaoTuanAuctionItem.h"
#import "EtaoTimerController.h"
#import "EtaoGroupBuyAuctionDataSource.h"

@interface EtaoTuanDetailSwipeController : ETDetailSwipeController{
    EtaoGroupBuyAuctionDataSource* _datasource;
    EtaoTuanAuctionItem *_localItem ;
    BOOL _loading ;
    
    EtaoTimerController* _timerController;
}


@property (nonatomic,retain)  EtaoGroupBuyAuctionDataSource* datasource;
@property(nonatomic, retain) EtaoTimerController* timerController;
 
@end
