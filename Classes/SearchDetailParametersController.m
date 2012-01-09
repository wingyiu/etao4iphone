//
//  SearchDetailParameters.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchDetailParametersController.h"

@implementation SearchDetailParametersController

@synthesize parametersTableView = _parametersTableView;
@synthesize parametersDateSource = _parametersDateSource;


- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
        
        if (nil == _parametersTableView ) {
            _parametersTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,[self.view bounds].size.width, [self.view bounds].size.height) style:UITableViewStyleGrouped];
                   
            _parametersTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _parametersTableView.backgroundColor = [UIColor clearColor];
            _parametersTableView.autoresizesSubviews = YES;
            
            [self.view addSubview:_parametersTableView];
            
            [_parametersTableView setDelegate:self];
            [_parametersTableView setDataSource:self];
        }
    }
    
    return self;
}


-(void)loadView {
    [super loadView];
    
    [self setTitle:@"详细参数"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_parametersDateSource count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSArray* itemArray = [[_parametersDateSource objectAtIndex:indexPath.row] componentsSeparatedByString:@":"];
   
    id data = [itemArray objectAtIndex:1];
    
    if ([data isKindOfClass:[NSString class]]) {
        NSString *detailText = (NSString *)data;
    
        CGSize detailSize = [detailText sizeWithFont:[UIFont systemFontOfSize:16]
                                   constrainedToSize:CGSizeMake(180.0, 10000.0f)
                                       lineBreakMode:UILineBreakModeWordWrap];
        
        return MAX(detailSize.height + 16.0, 44.0);
    }
    
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *itemCellId = [NSString stringWithFormat:@"itemCell_%d%d",indexPath.section, indexPath.row];	
    
    UITableViewCell * cell = [_parametersTableView dequeueReusableCellWithIdentifier:itemCellId];

    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellId] autorelease];
    }
    else {
        for (UIView *v in [cell subviews]) {
            if ([v isKindOfClass:[UILabel class]]) {
                [v removeFromSuperview];
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //NSArray* itemArray = [[partArray objectAtIndex:i] componentsSeparatedByString:@" | "];
    NSArray* itemArray = [[_parametersDateSource objectAtIndex:indexPath.row] componentsSeparatedByString:@":"];
    
    UILabel *ParameterName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, cell.bounds.size.height)];
    ParameterName.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    ParameterName.backgroundColor = [UIColor clearColor];
	ParameterName.font = [UIFont systemFontOfSize:16];
	ParameterName.textColor = [UIColor blackColor]; 
	ParameterName.textAlignment = UITextAlignmentLeft; 
    
    NSString* tempStr = [itemArray objectAtIndex:0];
    
    NSRange foundObj=[tempStr rangeOfString:@"：" options:NSCaseInsensitiveSearch];
    
    if(foundObj.length>0) { 
        [ParameterName setText:[NSString stringWithFormat:@"%@", [itemArray objectAtIndex:0]]];
    }
    else {
        [ParameterName setText:[NSString stringWithFormat:@"%@:", [itemArray objectAtIndex:0]]];
    }
    
    //[ParameterName setText:[NSString stringWithFormat:@"%@:", [itemArray objectAtIndex:0]]];
    [cell addSubview:ParameterName];
    [ParameterName release];
    
        
    CGRect rect = cell.contentView.bounds;
    rect.origin.x = 120;
    //rect.origin.y = 0;
    rect.size.width = 180;
    //rect.size.height -= 4;
    
    UILabel *ParameterInfo = [[UILabel alloc] initWithFrame:rect];//CGRectMake(120, 0, 200, cell.bounds.size.height)];
    ParameterName.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    ParameterInfo.backgroundColor = [UIColor clearColor];
	ParameterInfo.font = [UIFont systemFontOfSize:16];
    ParameterInfo.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    ParameterInfo.numberOfLines = 0;
    
	ParameterInfo.textColor = [UIColor blackColor]; 
	ParameterInfo.textAlignment = UITextAlignmentLeft; 
    [ParameterInfo setText:[itemArray objectAtIndex:1]];
    [cell addSubview:ParameterInfo];
    [ParameterInfo release];
    
    return cell;  
}


- (void)setDetaiParametersController:(NSString*) parameters {
    
    if (nil == _parametersDateSource ) {
        _parametersDateSource = [[NSMutableArray alloc] init];
    }
    else {
        [_parametersDateSource removeAllObjects];
    }
    
    NSArray* partArray = [parameters componentsSeparatedByString:@";"];
    
    for ( NSString *s in partArray) {
        if ([s length] > 0) {
            [_parametersDateSource addObject:s]; 
        }
    }
}


- (void)dealloc {
    
    [_parametersTableView release];
    
    [_parametersDateSource removeAllObjects];
    [_parametersDateSource release];
    
    [super dealloc];
}

@end
