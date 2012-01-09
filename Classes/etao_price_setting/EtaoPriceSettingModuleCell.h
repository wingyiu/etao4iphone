//
//  EtaoTableViewModuleCell.h
//  etao_price_setting
//
//  Created by 无线一淘客户端测试机 on 11-11-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EtaoPriceSettingModuleCell:NSObject{
    
    NSString *_tag;
    NSString *_text;
    NSString *_catid;
    NSString *_siteid;
    NSString *_type;
    NSString *_selected;
    NSString *_choosed;
    NSString *_order;
}

@property (nonatomic, retain) NSString* tag;                        
@property (nonatomic, retain) NSString* text;
@property (nonatomic, retain) NSString* catid;
@property (nonatomic, retain) NSString* siteid;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* selected;
@property (nonatomic, retain) NSString* choosed;
@property (nonatomic, retain) NSString* order;

-(NSComparisonResult)CellCompare:(EtaoPriceSettingModuleCell*)cell;

@end
