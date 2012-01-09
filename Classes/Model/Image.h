//
//  Image.h
//  etao4iphone
//
//  Created by iTeam on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Image :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * pict_url;
@property (nonatomic, retain) NSData * data;

@end



