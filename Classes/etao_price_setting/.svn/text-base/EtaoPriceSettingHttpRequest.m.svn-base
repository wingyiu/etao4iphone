//
//  EtaoHttpRequest.m
//  etao_price_setting
//
//  Created by 无线一淘客户端测试机 on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceSettingHttpRequest.h"


@implementation EtaoPriceSettingHttpRequest

@synthesize items = _items;



-(id)init{
    self = [super init];
    if(self){
        _parameters = [[NSMutableDictionary alloc]initWithCapacity:10];
        self.items = [[[NSMutableArray alloc]init]autorelease];
        return self;
    }
    return nil;
}

-(void)addParam:(NSObject *)param forKey:(NSString *)key{
    [_parameters setObject:param forKey:key];
}

-(void)removeParam:(NSString *)key{
    [_parameters removeObjectForKey:key];
}

-(NSString *)_dictToString:(NSDictionary *)dict{
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:[[dict allKeys]count]];
    for (NSString *key in [dict keyEnumerator]) 
    {
        NSObject *val = [dict objectForKey:key];
        NSString *paramVal;
        if([val isKindOfClass:[NSString class]]){
            paramVal = (NSString *)val;
        }else{
            paramVal = [val JSONRepresentation];
        }
        
        [dataArr addObject:[NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[paramVal stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"]]];
    }
    
    return [dataArr componentsJoinedByString:@"&"];
}

-(void)start{
    [self load:@"http://wap.etao.com/go/rgn/decider/ssjj.html"];
}

-(NSUInteger)count{
    return [_items count];
}

-(NSMutableArray *)mergeWebAndLocal:(NSArray *)webArray{
    
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_choose_display"];
    NSMutableArray *oriArray = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    if(oriArray==nil){
        oriArray = [[[NSMutableArray alloc]init]autorelease];
    }    
    /* 生成线上 hushmap */
    NSMutableDictionary* webDic = [[[NSMutableDictionary alloc]init]autorelease];
    for (EtaoPriceSettingModuleCell *web in webArray) {
        [webDic setObject:web forKey:[NSString stringWithFormat:@"%@",web.tag]];
    }

    /* 生成线下 hushmap */
    NSMutableDictionary* oriDic = [[[NSMutableDictionary alloc]init]autorelease];
    for (EtaoPriceSettingModuleCell *ori in oriArray) {
        [oriDic setObject:ori forKey:[NSString stringWithFormat:@"%@",ori.tag]];
    }
    
    for (EtaoPriceSettingModuleCell *ori in oriArray) {
        EtaoPriceSettingModuleCell* web = [webDic objectForKey:ori.tag];
        if(web!=nil){
            ori.choosed = web.choosed;
            ori.selected = [web.choosed isEqualToString:@"1"]?@"1":ori.selected;//修改不同的地方
        }
        else{
            [oriArray removeObject:ori]; //去处已经过期的 tag
        }
    }
    
    for(EtaoPriceSettingModuleCell* web in webArray) {
        EtaoPriceSettingModuleCell* ori = [oriDic objectForKey:web.tag];
        if(ori == nil){
            [oriArray addObject:web];
        }
    }
    
    return oriArray;
    
}

-(void)addItemsByJSON:(NSString *)json{
    
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
            NSString* catid = [(NSDictionary*)obj objectForKey:@"catid"];
            NSString* siteid = [(NSDictionary*)obj objectForKey:@"siteid"];
            NSString* choosed = [(NSDictionary*)obj objectForKey:@"choose"];
            NSString* selected = [(NSDictionary*)obj objectForKey:@"selected"];
            NSString* type = [(NSDictionary*)obj objectForKey:@"type"];
            EtaoPriceSettingModuleCell* cell = [[EtaoPriceSettingModuleCell alloc]init];
            
            cell.tag = tag;
            cell.catid = [catid stringByReplacingOccurrencesOfString:@";" withString:@","];
            cell.siteid = siteid;
            cell.type = type;
            cell.choosed = choosed;
            cell.selected = selected;
            
            [webArray addObject:cell];
            [cell release];
        }
        [jsonParser release];
    }
    
    [self.items setArray:[self mergeWebAndLocal:webArray]];  
    NSArray * arr = [NSArray arrayWithArray:[_items sortedArrayUsingSelector:@selector(CellCompare:)]];
    [_items setArray:arr];
    
}

-(id)objectAtIndex:(NSUInteger)index{
    if(_items.count == 0 || index >= _items.count)return nil;
    return [_items objectAtIndex:index];
}

-(void)removeAllObjects{
    [_items removeAllObjects];
}

-(void)clear{
    
    [_items removeAllObjects];
}

-(void)dealloc{
    if(_parameters != nil)
    {
      [_parameters release];  
        _parameters = nil;
    }
    if(_urlprefix != nil)
    {
        [_urlprefix release];
        _urlprefix = nil;
    }
    if(_items != nil)
    {
        [_items release];
        _items = nil;
    }
    [super dealloc];
}

@end
