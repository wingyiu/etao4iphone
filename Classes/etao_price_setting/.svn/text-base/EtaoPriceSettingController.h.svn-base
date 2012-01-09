//
//  EtaoPriceSettingController.h
//  etao_price_setting
//
//  Created by 无线一淘客户端测试机 on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoPriceSettingHttpRequest.h"
#import "ETaoUITableViewController.h"
#import "EtaoPriceSettingHttpRequest.h"
#import "EtaoPriceSettingModuleCell.h"
#import "EtaoUIBarButtonItem.h"

@interface EtaoPriceSettingController : ETaoUITableViewController {

    EtaoPriceSettingHttpRequest *_httprequest;
    
    UIImageView* bgView;
    
}

-(void)requestFinished:(EtaoPriceSettingHttpRequest *)sender;
-(void)requestFailed:(EtaoPriceSettingHttpRequest *)sender;

- (void)start;
- (void)load;
- (void)save;

-(NSMutableArray *)getDataSource;

@property (nonatomic, retain)EtaoPriceSettingHttpRequest* httprequest;


@property (nonatomic, assign)BOOL _requestFailed;

@end
