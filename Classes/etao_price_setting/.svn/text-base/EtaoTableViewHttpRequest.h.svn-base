//
//  Test2MyHttpRequest.h
//  Test2
//
//  Created by 左 昱昊 on 11-10-31.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface EtaoTableViewHttpRequest : NSObject{
    NSString* _url;
    NSData* data;
    SEL requestDidFinishSelector;
    SEL requestDidFailedSelector;
}

@property(nonatomic,retain) NSString* _url;
@property(nonatomic,retain) NSData* data;
@property(nonatomic,assign) id delegate;
@property(nonatomic,assign) SEL requestDidFinishSelector;
@property(nonatomic,assign) SEL requestDidFailedSelector;

- (id)init; 
- (void) load:(NSString*)url withSync:(BOOL)isSync;
- (void) requestFinished:(ASIHTTPRequest *)request ;
- (void) requestFailed:(ASIHTTPRequest *)request ;


@end
