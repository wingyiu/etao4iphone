//file://localhost/Users/iteam/zhangsuntai/etao4iphone/Classes/CustomSearchBarView.m
//  EtaoAuctionItem.h
//  etao4iphone
//
//  Created by iTeam on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights rese
//

#import <Foundation/Foundation.h>
#import "ETaoModel.h"

@interface EtaoCategoryItem : TBModel {
	NSString * count;
	NSString * key;
	NSString * name; 
	int catlevel ;
	BOOL head ;
}


@property (nonatomic, retain) NSString * count;
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, assign) int catlevel ;
@property (nonatomic, assign) BOOL head ;

@end

@interface EtaoPidVidItem : TBModel {
	NSString * key;
	NSString * name; 
	BOOL _select ;
	BOOL head ;
}

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, assign) BOOL _select ;
@property (nonatomic, assign) BOOL head ;
@end



@interface EtaoAuctionItem : ETaoModel {
	NSString * nid;
	NSString * title;
	NSString * pic;
	NSString * link;
	NSString * price;	
	NSString * postFee;	
	NSString * loc;	
	NSString * userId;	
	NSString * userType;	
	NSString * userNickName	;
	NSString * sales;	
	NSString * epid	;
	NSString * category	;
	NSString * comUrl;	
	NSString * logo	;
	NSString * isComUrlWapUrl;
	NSString * isLinkWapUrl;
}
 

@property (nonatomic, retain) NSString * nid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * pic; 
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * postFee;
@property (nonatomic, retain) NSString * loc;
@property (nonatomic, retain) NSString * userId; 
@property (nonatomic, retain) NSString * userType;
@property (nonatomic, retain) NSString * userNickName;
@property (nonatomic, retain) NSString * sales;
@property (nonatomic, retain) NSString * epid;
@property (nonatomic, retain) NSString * category; 
@property (nonatomic, retain) NSString * comUrl;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * isComUrlWapUrl;
@property (nonatomic, retain) NSString * isLinkWapUrl;


@end
