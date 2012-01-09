//
//  ETSRPTableViewController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETHttpRequest.h"
#import "ETSRPDataSource.h"
#import "ASINetworkQueue.h"
#import "ETSRPDataSource.h"
#import "EtaoAuctionSRPDataSource.h"
#import "ETUIViewController.h"


static int SRP_PAGE_COUNT = 20 ;

@interface ETSRPTableViewController : ETUIViewController <UITableViewDelegate,UITableViewDataSource, ETSRPDataSourceDelegate> {
  
    ASINetworkQueue *_queue ;
    NSMutableDictionary *_loadingImageDic;
    UITableView *_tableView;
    
    ETSRPDataSource  *_datasource;
    
    NSMutableDictionary *_imageCache ;
    
    NSMutableArray *_httpImageArr;
    
}
 
@property (nonatomic,retain) ETSRPDataSource  *datasource;
@property (nonatomic,retain) UITableView *tableView;


@end
