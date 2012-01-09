//
//  EtaoTableViewModuleCell.m
//  etao_price_setting
//
//  Created by 无线一淘客户端测试机 on 11-11-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceSettingModuleCell.h"


@implementation EtaoPriceSettingModuleCell

@synthesize tag = _tag;
@synthesize text = _text;
@synthesize catid = _catid;
@synthesize siteid = _siteid;
@synthesize type = _type;
@synthesize selected = _selected;
@synthesize choosed = _choosed;
@synthesize order = _order;


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self){
        self.tag = [aDecoder decodeObjectForKey:@"tag"];
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.catid = [aDecoder decodeObjectForKey:@"catid"];
        self.siteid = [aDecoder decodeObjectForKey:@"siteid"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.selected = [aDecoder decodeObjectForKey:@"selected"];
        self.choosed = [aDecoder decodeObjectForKey:@"choosed"];
        self.order = [aDecoder decodeObjectForKey:@"order"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_tag forKey:@"tag"];
    [aCoder encodeObject:_text forKey:@"text"];
    [aCoder encodeObject:_catid forKey:@"catid"];
    [aCoder encodeObject:_siteid forKey:@"siteid"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_selected forKey:@"selected"];
    [aCoder encodeObject:_choosed forKey:@"choosed"];
    [aCoder encodeObject:_order forKey:@"order"];
}


-(void)dealloc{
    [_tag release];
    [_text release];
    [_catid release];
    [_siteid release];
    [_type release];
    [_selected release];
    [_choosed release];
    [_order release];
    [super dealloc];
}


-(NSComparisonResult)CellCompare:(EtaoPriceSettingModuleCell*)cell
{
    if([self.selected isEqualToString:@"1"]&&[cell.selected isEqualToString:@"0"])
        return NSOrderedAscending;
    else if([self.selected isEqualToString:@"0"]&&[cell.selected isEqualToString:@"1"])
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

@end
