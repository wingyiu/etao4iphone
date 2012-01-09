//
//  EtaoPriceBuySettingDataSource.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceBuySettingDataSource.h"

@implementation EtaoPriceBuySettingDataSource
@synthesize items = _items;
@synthesize status = _status;
@synthesize mode = _mode;

- (id) init{
    self = [super init];
    if(self){
        _request = [[EtaoHttpRequest alloc]init];
        _request.delegate = self;
        
        _items = [[NSMutableArray alloc]init];
        
        _mode = @"0";
    }
    return self;
}

- (void)dealloc{
    if(_request !=nil){
        [_request release];
        _request = nil;
    }
    if(_items != nil)
    {
        [_items release];
        _items = nil;
    }
    [_oriItems release];
    [super dealloc];
}

#pragma mark -V APIs
- (void)reload{
    [_request load:PRICEBUY_SETTING_URL];
    self.status = ET_DS_PRICEBUY_SETTING_LOADING;
}


#pragma mark -V logic fuction

-(NSMutableArray *)mergeWebAndLocal:(NSArray *)webArray{
    
    
    
    if(_oriItems==nil){
        _oriItems = [[[NSMutableArray alloc]init]autorelease];
    }    
    /* 生成线上 hushmap */
    NSMutableDictionary* webDic = [[[NSMutableDictionary alloc]init]autorelease];
    for (EtaoPriceSettingItem *item in webArray) {
        [webDic setObject:item forKey:[NSString stringWithFormat:@"%@",item.tag]];
    }
    
    /* 生成线下 hushmap */
    NSMutableDictionary* oriDic = [[[NSMutableDictionary alloc]init]autorelease];
    for (EtaoPriceSettingItem *item in _oriItems) {
        [oriDic setObject:item forKey:[NSString stringWithFormat:@"%@",item.tag]];
    }
    
    NSMutableArray* oriItems = [[[NSMutableArray alloc]init]autorelease];
    for (EtaoPriceSettingItem *ori in _oriItems) {
        EtaoPriceSettingItem* web = [webDic objectForKey:ori.tag];
        if(web!=nil){
            ori.choosed = web.choosed;
            ori.selected = [web.choosed isEqualToString:@"1"]?@"1":ori.selected;//修改不同的地方
            [oriItems addObject:ori];
        }
    }
    
    for(EtaoPriceSettingItem* web in webArray) {
        EtaoPriceSettingItem* ori = [oriDic objectForKey:web.tag];
        if(ori == nil){
            [oriItems addObject:web];
        }
    }
    return oriItems;
}

- (void)addItemsByJSON:(NSString *)json{
    
    if(_items){
        _oriItems = [_items copy];
        [_items removeAllObjects];
    }
    
    NSMutableArray* webArray = [[[NSMutableArray alloc]init]autorelease];
    if(json!=nil){
        NSString* realJsonString = [json stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\""];
        NSError* error=nil;
        SBJsonParser* jsonParser = [[SBJsonParser alloc]init];
        NSDictionary* dict = [jsonParser objectWithString:realJsonString error:&error];
        if(error){
            NSLog(@"Parser Error! %@",[error description]);
            [jsonParser release];
            return;
        }
        NSArray* array = [dict objectForKey:@"items"];
        NSEnumerator *e = [array objectEnumerator];
        id obj;
        while(obj = [e nextObject]){
            NSString* tag = [(NSDictionary*)obj objectForKey:@"tag"];
            NSString* catid = [(NSDictionary*)obj objectForKey:@"catid"];
            NSString* siteid = [(NSDictionary*)obj objectForKey:@"siteid"];
            NSString* choosed = [(NSDictionary*)obj objectForKey:@"choose"];
            NSString* selected = [(NSDictionary*)obj objectForKey:@"selected"];
            NSString* type = [(NSDictionary*)obj objectForKey:@"type"];
            EtaoPriceSettingItem* item = [[EtaoPriceSettingItem alloc]init];
            
            item.tag = tag;
            item.catid = catid==nil? @"":catid;
            item.siteid = siteid;
            item.type = type;
            item.choosed = choosed;
            item.selected = selected;
            
            [webArray addObject:item];
            [item release];
        }
        [jsonParser release];
    }
    
    [_items setArray:[self mergeWebAndLocal:webArray]];  
    NSArray * arr = [NSArray arrayWithArray:[_items sortedArrayUsingSelector:@selector(CellCompare:)]];
    [_items setArray:arr];
    
}

- (NSMutableArray*)getSelectedItems{
    NSMutableArray *array = [[[NSMutableArray alloc]init]autorelease];
    for(EtaoPriceSettingItem* item in _items){
        if([item.selected isEqualToString:@"0"])continue;
        [array addObject:item];
    }
    return array;
}



#pragma mark -V Http Request
- (void)requestFinished:(ETHttpRequest *)request{
    NSData* data = request.data;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
    NSString* jsonString = [[NSString alloc] initWithData:data encoding:enc];
    [self addItemsByJSON:jsonString];
    [jsonString release];
    self.status = ET_DS_PRICEBUY_SETTING_OK;
}

- (void)requestFailed:(ETHttpRequest *)request{
    self.status = ET_DS_PRICEBUY_SETTING_FAIL;
}

#pragma mark -V Serializing
/* 序列化接口 */
- (void)serializing:(NSString *)key{
    NSMutableDictionary* dict = [[[NSMutableDictionary alloc]init]autorelease];
    [dict setObject:_items forKey:@"items"];
    [dict setObject:_mode forKey:@"mode"];
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)deserializing:(NSString *)key{
    //排序
    NSArray * arr = [NSArray arrayWithArray:[_items sortedArrayUsingSelector:@selector(CellCompare:)]];
    [_items setArray:arr];
    
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSMutableDictionary* array = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    [_items setArray:[array objectForKey:@"items"]];
    self.mode = [array objectForKey:@"mode"];
    self.status = ET_DS_PRICEBUY_SETTING_LOCAL; //本地状态
}

- (NSString*)className{
    return @"EtaoPriceBuySettingDataSource";
}

+ (NSString*)keyName:(NSString *)str{
    return [NSString stringWithFormat:@"pricebuy_setting"];
}


@end
