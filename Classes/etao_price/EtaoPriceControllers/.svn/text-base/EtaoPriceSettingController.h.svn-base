//
//  EtaoPriceSettingController.h
//  etao_price_setting
//
//  Created by 无线一淘客户端测试机 on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETaoUITableViewController.h"
#import "EtaoPriceBuySettingDataSource.h"
#import "EtaoPriceSettingCell.h"
#import "EtaoPriceSettingItem.h"
#import "EtaoUIBarButtonItem.h"

@interface EtaoPriceSettingController : ETaoUITableViewController {
    EtaoPriceBuySettingDataSource* _datasource;
    
}

@property (nonatomic,assign)  EtaoPriceBuySettingDataSource* datasource;

/* 监视函数 */
- (void)watchWithDatasource:(id)datasource;
- (void)watchWithKey:(NSString*)key;

@end
