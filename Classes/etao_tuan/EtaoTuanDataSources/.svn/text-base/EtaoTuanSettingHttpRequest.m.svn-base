//
//  EtaoTuanSettingHttpRequest.m
//  etao4iphone
//
//  Created by  on 11-11-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanSettingHttpRequest.h"
#import "EtaoTuanSettingModuleCell.h"
#import "SBJson.h"


@implementation EtaoTuanSettingHttpRequest

@synthesize items = _items;

-(void)dealloc{
    if(_parameters != nil)
    {
        [_parameters removeAllObjects];
        [_parameters release];  
        _parameters = nil;
    }

    if(_items != nil)
    {
        [_items removeAllObjects];
        [_items release];
        _items = nil;
    }
    [super dealloc];
}

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
    NSString* url = @"http://wap.etao.com/go/rgn/decider/tuangou.html";
    //NSString *url = [NSString stringWithFormat:@"%@%@", _urlprefix, [self _dictToString:_parameters]];
    NSLog(@"load url %@", url);
    [self load:url];
}

-(NSUInteger)count{
    return [_items count];
}

-(NSMutableArray *)mergeWebAndLocal:(NSArray *)webArray{
    
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:@"tuan_user_choose_display"];
    NSMutableArray *oriArray = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    if(oriArray==nil){
        oriArray = [[[NSMutableArray alloc]init]autorelease];
    }
    
 //   [oriArray removeAllObjects];
    
    BOOL isExist = NO;
    
    for (EtaoTuanSettingModuleCell *web in webArray) {
        if([web isKindOfClass:[EtaoTuanSettingModuleCell class]]){
            isExist = NO;
            for (EtaoTuanSettingModuleCell *ori in oriArray) {
                if(([web.tag isEqualToString:ori.tag])){
                    isExist = YES;
                    break;
                }
            }
            if (!isExist) {
                [oriArray addObject:web];
            }
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
            NSString* catid = [(NSDictionary*)obj objectForKey:@"cat"];
            NSString* siteid = [(NSDictionary*)obj objectForKey:@"site"];
            NSString* choosed = [(NSDictionary*)obj objectForKey:@"choose"];
            NSString* type = [(NSDictionary*)obj objectForKey:@"type"];
            EtaoTuanSettingModuleCell* cell = [[EtaoTuanSettingModuleCell alloc]init];
            cell.tag = tag;
            cell.catid = [catid stringByReplacingOccurrencesOfString:@";" withString:@","];
            cell.siteid = siteid;
            cell.selected =@"0";
            cell.type = type;
            if([choosed isEqualToString:@"1"]){
                cell.choosed = @"1";
                cell.selected = @"1";
            }else{
                cell.choosed = @"0";
            }
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
    return [_items objectAtIndex:index];
}

-(void)removeAllObjects{
    [_items removeAllObjects];
}

-(void)clear{
    
    [_items removeAllObjects];
}

@end
