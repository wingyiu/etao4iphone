//
//  ETSRPDataSource.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETHttpRequest.h"



@class ETSRPDataSource;
@protocol ETSRPDataSourceDelegate <NSObject> 

@optional
// 请求完成
- (void) ETSRPDataSourceRequestFinished:(ETSRPDataSource *)request ;
// 请求失败
- (void) ETSRPDataSourceRequestFailed:(ETSRPDataSource *)request ;  
@end


@interface ETSRPDataSource : NSObject <ETHttpRequstDelegate>{
    // data
	NSMutableArray * _items ;
    NSString *_content ;
}

@property (nonatomic,assign) id<ETSRPDataSourceDelegate> delegate; 

@property (nonatomic,retain) NSString * errorMessage ;
@property (nonatomic,retain) NSString * url ;
@property (nonatomic,retain) NSMutableArray * items ;
@property (nonatomic,retain) ETHttpRequest * request ;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,assign) int totalCount ;
@property int pageCount;
@property int status ;
@property BOOL loading ;

// 子类必须实现setRequestUrl
- (void) setRequestUrl:(NSString *)url;

// 子类必须实现setRequestUrl
- (BOOL) parse:(NSString*)json ;

- (void) start ;

- (int)  count;

- (void) clear ;

+ (id)sharedDataSource;


@end
