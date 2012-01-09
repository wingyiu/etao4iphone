//
//  EtaoTuanSettingController.h
//  etao_price_setting
//
//  Created by 无线一淘客户端测试机 on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETaoUITableViewController.h"
#import "EtaoTuanSettingCell.h"
#import "EtaoTuanSettingItem.h"
#import "EtaoUIBarButtonItem.h"
#import "EtaoGroupBuySettingDataSource.h"

@interface EtaoTuanSettingController : ETaoUITableViewController {
    EtaoGroupBuySettingDataSource* _datasource;
}

@property (nonatomic,assign)  EtaoGroupBuySettingDataSource* datasource;

/* 监视函数 */
- (void)watchWithDatasource:(id)datasource;
- (void)watchWithKey:(NSString*)key;

@end
