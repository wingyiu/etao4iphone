//
//  EtaoTuanSettingDataSource.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanSettingDataSource.h"

@implementation EtaoTuanSettingDataSource
@synthesize items = _items;

#pragma mark -API
- (void)save{
    //排序
    NSArray * arr = [NSArray arrayWithArray:[_items sortedArrayUsingSelector:@selector(CellCompare:)]];
    [_items setArray:arr];
    //保存到本地
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:_items];
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:@"tuan_user_choose_display"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)load{
    //清空已有数据
    if([_items count] > 0){
        [_items removeAllObjects];
    }
    //获取本地数据
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:@"tuan_user_choose_display"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    [_items setArray:array];
    
    //如果本地数据为空
    if([_items count] == 0){
        //发起同步请求
        _request.isSyc = YES;
        [_request load:SETTING_URL];
    }
    else{
        //发起异步请求
        _request.isSyc = NO;
        [_request load:SETTING_URL];
    }
}

- (NSMutableArray*)getSelectedItems{
    NSMutableArray *array = [[[NSMutableArray alloc]init]autorelease];
    for(EtaoTuanSettingItem* item in _items){
        if([item.selected isEqualToString:@"0"])continue;
        [array addObject:item];
    }
    return array;
}

#pragma mark -http delegate
- (void)requestFinished:(EtaoHttpRequest *)request{
    NSData* data = request.data;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
    NSString* jsonString = [[NSString alloc] initWithData:data encoding:enc];
    [self addItemsByJSON:jsonString];
    [jsonString release];
    [self save];
}

- (void)requestFailed:(EtaoHttpRequest *)request{
    [[ETaoNetWorkAlert alert]show];
}

#pragma mark -logic fuction
- (void)addItemsByJSON:(NSString *)json{
    
    if(_items){
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
            NSString* catid = [(NSDictionary*)obj objectForKey:@"cat"];
            NSString* siteid = [(NSDictionary*)obj objectForKey:@"site"];
            NSString* choosed = [(NSDictionary*)obj objectForKey:@"choose"];
            NSString* selected = [(NSDictionary*)obj objectForKey:@"selected"];
            NSString* type = [(NSDictionary*)obj objectForKey:@"type"];
            EtaoTuanSettingItem* item = [[EtaoTuanSettingItem alloc]init];
            
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

-(NSMutableArray *)mergeWebAndLocal:(NSArray *)webArray{
    
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:@"tuan_user_choose_display"];
    NSMutableArray *oriArray = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    if(oriArray==nil){
        oriArray = [[[NSMutableArray alloc]init]autorelease];
    }    
    /* 生成线上 hushmap */
    NSMutableDictionary* webDic = [[[NSMutableDictionary alloc]init]autorelease];
    for (EtaoTuanSettingItem *item in webArray) {
        [webDic setObject:item forKey:[NSString stringWithFormat:@"%@",item.tag]];
    }
    
    /* 生成线下 hushmap */
    NSMutableDictionary* oriDic = [[[NSMutableDictionary alloc]init]autorelease];
    for (EtaoTuanSettingItem *item in oriArray) {
        [oriDic setObject:item forKey:[NSString stringWithFormat:@"%@",item.tag]];
    }
    
    for (EtaoTuanSettingItem *ori in oriArray) {
        EtaoTuanSettingItem* web = [webDic objectForKey:ori.tag];
        if(web!=nil){
            ori.choosed = web.choosed;
            ori.selected = [web.choosed isEqualToString:@"1"]?@"1":ori.selected;//修改不同的地方
        }
        else{
            [oriArray removeObject:ori]; //去处已经过期的 tag
        }
    }
    
    for(EtaoTuanSettingItem* web in webArray) {
        EtaoTuanSettingItem* ori = [oriDic objectForKey:web.tag];
        if(ori == nil){
            [oriArray addObject:web];
        }
    }
    return oriArray;
}

- (id) init{
    self = [super init];
    if(self){
        _request = [[EtaoHttpRequest alloc]init];
        _request.delegate = self;
        
        _items = [[NSMutableArray alloc]init];
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
    [super dealloc];
}



@end
