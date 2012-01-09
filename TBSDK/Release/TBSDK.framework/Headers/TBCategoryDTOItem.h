//
//  TBCategoryDTOItem.h
//  taobao4iphone
//
//  Created by chenyan on 11-9-21.
//  Copyright 2011 Taobao.com. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TBModel.h"

/* com.taobao.search.api.getCategory，类目搜索返回的，类目数据类型*/
@interface TBCategoryDTOItem : TBModel{
    NSString    *catId;
    NSString    *name;
    NSString    *url;
    NSString    *leaf;
    NSString    *num;
}

/*类目id*/
@property (nonatomic, retain) NSString  *catId;

/*类目名*/
@property (nonatomic, retain) NSString  *name;

/*类目路径*/
@property (nonatomic, retain) NSString  *url;

/*是否叶子目录*/
@property (nonatomic, retain) NSString  *leaf;

/*子类目数量*/
@property (nonatomic, retain) NSString  *num;


@end
