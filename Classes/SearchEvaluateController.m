//
//  SearchEvaluateController.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchEvaluateController.h"
#import "SearchEvaluateSession.h"
#import "EtaoEvaluateItem.h"
#import "EtaoShowAlert.h"
#import "ActivityIndicatorMessageView.h"


@interface  SearchEvaluateController()
-(NSMutableArray*)getItemsArrayDataSource;
-(int)getItemsArrayAllCount;
@end

@implementation SearchEvaluateController

@synthesize buttonAdvantage = _buttonAdvantage;
@synthesize buttonShortcoming = _buttonShortcoming;
@synthesize buttonExperience = _buttonExperience;
@synthesize evaluateTabView = _evaluateTabView; 

@synthesize searchEvaluateSession = _searchEvaluateSession;

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (id) initWithProduct:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        
        if(nil == _searchEvaluateSession) {
            _searchEvaluateSession = [[SearchEvaluateSession alloc] init];
            
            _searchEvaluateSession.sessionDelegate = self;
        }
    
		_searchEvaluateSession.dictParam = dict ;
    }
    
    return self;   
}


- (void) loadView {
    [super loadView];
    
    [self setTitle:@"用户点评"];    

    if(nil == _buttonAdvantage) {
        _buttonAdvantage = [[UIButton alloc] init];
        [_buttonAdvantage setBackgroundColor:[UIColor blueColor]];
        [_buttonAdvantage setBackgroundImage:[UIImage imageNamed:@"SearchEvaluateGoodFoc.png"] forState:UIControlStateSelected];
        [_buttonAdvantage setBackgroundImage:[UIImage imageNamed:@"SearchEvaluateGoodNor.png"] forState:UIControlStateNormal];
        [_buttonAdvantage setFrame:CGRectMake(0,0,100,41)];
        //[_buttonAdvantage setTitle:@"优点" forState:UIControlStateNormal];
        [_buttonAdvantage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonAdvantage setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_buttonAdvantage addTarget:self action:@selector(showAdvabtage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_buttonAdvantage];
        [_buttonAdvantage release];
    }
  
    
    if( nil == _buttonShortcoming ) {
        _buttonShortcoming = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 100, 41)];
        [_buttonShortcoming setBackgroundColor:[UIColor blueColor]];
        [_buttonShortcoming setBackgroundImage:[UIImage imageNamed:@"SearchEvaluateBadFoc.png"] forState:UIControlStateSelected];
        [_buttonShortcoming setBackgroundImage:[UIImage imageNamed:@"SearchEvaluateBadNor.png"] forState:UIControlStateNormal];
        //[_buttonShortcoming setTitle:@"缺点" forState:UIControlStateNormal];
        [_buttonShortcoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonShortcoming setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

        [_buttonShortcoming addTarget:self action:@selector(showShortcoming) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_buttonShortcoming];
        [_buttonShortcoming release];
    }
    
    if( nil == _buttonExperience ) {
        _buttonExperience = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 120, 41)];
        [_buttonExperience setBackgroundImage:[UIImage imageNamed:@"SearchEvaluateExpFoc.png"] forState:UIControlStateSelected];
        [_buttonExperience setBackgroundImage:[UIImage imageNamed:@"SearchEvaluateExpNor.png"] forState:UIControlStateNormal];
        [_buttonExperience setBackgroundColor:[UIColor blueColor]];
        [self.view addSubview:_buttonExperience];
        //[_buttonExperience setTitle:@"心得" forState:UIControlStateNormal];
        [_buttonExperience setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonExperience setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

        [_buttonExperience addTarget:self action:@selector(showExperience) forControlEvents:
         UIControlEventTouchUpInside];
        [_buttonExperience release];
    }
    
    if (nil == _evaluateTabView ) {
        _evaluateTabView = [[UITableView alloc] initWithFrame:CGRectMake(0,41,[self.view bounds].size.width, [self.view bounds].size.height-41) ];//style:UITableViewStyleGrouped];
        
        _evaluateTabView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _evaluateTabView.backgroundColor = [UIColor clearColor];
        _evaluateTabView.autoresizesSubviews = YES;
        
        [self.view addSubview:_evaluateTabView];
        
        [_evaluateTabView setDelegate:self];
        [_evaluateTabView setDataSource:self];
    }
    
    ActivityIndicatorMessageView *loadv = [[[ActivityIndicatorMessageView alloc]initWithFrame:CGRectMake(120, 100, 80, 80) Message:@"正在加载"]autorelease];
    [loadv startAnimating];
    [self.view addSubview:loadv]; 
    [self.view bringSubviewToFront:loadv]; 
    _evaluateTabView.hidden = YES;
    
    _buttonAdvantage.selected = YES;
    
    _isLoading = YES;
    
    [self retain];
    [_searchEvaluateSession requestEvaluateDetailDate];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section != 0) {
        return 0;
    }
    
    int totalCount = [self getItemsArrayAllCount];
    
    if( totalCount <= 0) {
        return 0;
    }
    
    if ([self getItemsArrayDataSource] == nil) {
        return 0;
    }
   
    if (totalCount <= 0) {
        return 0;
    }
    
    int arraycount = [[self getItemsArrayDataSource] count];
    
    if (arraycount < totalCount) {
        return arraycount + 1;
    } 
    else {
        return arraycount;
    }
}


-(void)showAdvabtage {
    _buttonAdvantage.selected = YES;
    _buttonShortcoming.selected = NO;
    _buttonExperience.selected = NO;    
    
    [_evaluateTabView reloadData];
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-Advantage"];
}


-(void)showShortcoming {
    _buttonAdvantage.selected = NO;
    _buttonShortcoming.selected = YES;
    _buttonExperience.selected = NO;
    
    [_evaluateTabView reloadData];
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-Shortcoming"];
}


-(void)showExperience {
    _buttonAdvantage.selected = NO;
    _buttonShortcoming.selected = NO;
    _buttonExperience.selected = YES;
    
    [_evaluateTabView reloadData];
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-Experience"];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if( indexPath.row >= [[self getItemsArrayDataSource] count]) {
        return 30;
    }
    
    NSObject* tempObj = 
    [_searchEvaluateSession.searchEvaluateProtocal._evaluateArray objectAtIndex:indexPath.row];
    
    NSString *data = nil;
    if([tempObj isKindOfClass:[EtaoEvaluateItem class]]) {
        
        if(_buttonAdvantage.selected == YES) {
            data = ((EtaoEvaluateItem*)tempObj).good;
        }
        else if(_buttonShortcoming.selected == YES) {
            data = ((EtaoEvaluateItem*)tempObj).bad;            
        }
        else if(_buttonExperience.selected == YES) {
            data = ((EtaoEvaluateItem*)tempObj).summary;
        }
        
        if ([data isKindOfClass:[NSString class]]) {
            NSString *detailText = (NSString *)data;
            
            CGSize detailSize = [detailText sizeWithFont:[UIFont systemFontOfSize:16]
                                       constrainedToSize:CGSizeMake(280.0, 10000.0f)
                                           lineBreakMode:UILineBreakModeWordWrap];
            
            return MAX(detailSize.height + 16.0, 44.0);
        }
    }
    return 0; 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [[self getItemsArrayDataSource] count]; 
    
    if (row >= count ) {
        static NSString *moreCellId = @"moreCell"; 
        UITableViewCell * cell = [_evaluateTabView dequeueReusableCellWithIdentifier:moreCellId];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellId] autorelease];
            
            cell.textLabel.text = @"正在加载";
            cell.textLabel.textColor =  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
            cell.textLabel.textAlignment = UITextAlignmentCenter; 
            
            UIActivityIndicatorView *activityIndicator =  [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
            activityIndicator.frame = CGRectMake(cell.frame.size.width/2-60, 5, 20.0f, 20.0f);
//            activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            [cell addSubview:activityIndicator];
            
            [activityIndicator startAnimating]; 
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        return cell;
    }
    else {
        NSString *itemCellId = [NSString stringWithFormat:@"itemCell_%d%d",indexPath.section, indexPath.row];	
        
        UITableViewCell * cell = [_evaluateTabView dequeueReusableCellWithIdentifier:itemCellId];
        
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
        
        //    CGRect rect = cell.contentView.bounds;
        //    rect.origin.x = 20;
        //    rect.origin.y = 2;
        //    rect.size.width -= 20;
        //    rect.size.height -= 4;
        //    
        NSObject* tempObj = [_searchEvaluateSession.searchEvaluateProtocal._evaluateArray objectAtIndex:indexPath.row];
        
        UILabel *ParameterInfo = [[[UILabel alloc] initWithFrame:CGRectMake(20, 8, 280, cell.bounds.size.height-16)] autorelease];
        ParameterInfo.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        ParameterInfo.backgroundColor = [UIColor clearColor];
        ParameterInfo.font = [UIFont systemFontOfSize:16];
        ParameterInfo.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        ParameterInfo.numberOfLines = 0;
        
        ParameterInfo.textColor = [UIColor blackColor]; 
        ParameterInfo.textAlignment = UITextAlignmentLeft;

        if([tempObj isKindOfClass:[EtaoEvaluateItem class]]) {
            
            NSString *data = @"";
            if(_buttonAdvantage.selected == YES) {
                data = ((EtaoEvaluateItem*)tempObj).good;
            }
            else if(_buttonShortcoming.selected == YES) {
                data = ((EtaoEvaluateItem*)tempObj).bad;            
            }
            else if(_buttonExperience.selected == YES) {
                data = ((EtaoEvaluateItem*)tempObj).summary;
            }
            
            [ParameterInfo setText:data];
        }
        
        [cell addSubview:ParameterInfo];
        
        return cell;  
    }

    return nil;
}


- (void) SearchEvaluateRequestDidFinish:(NSObject *)obj {
    [self release];
    _isLoading = NO;
    
    ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)[self.view viewWithTag:ActivityIndicatorMessageView_TAG];
	if (loadv!=nil) { 
		[loadv stopAnimating];
	} 
	_evaluateTabView.hidden = NO;
    
    if (_evaluateTabView.delegate != nil) {
        [_evaluateTabView reloadData];
    }
}


- (void) SearchEvaluateRequestDidFailed:(NSObject *)obg {
    [self release];
    
    ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)[self.view viewWithTag:ActivityIndicatorMessageView_TAG];
	if (loadv!=nil) { 
		[loadv stopAnimating];
	} 
	_evaluateTabView.hidden = NO;
	
     _isLoading = NO;
    [EtaoShowAlert showAlert];
}


-(NSMutableArray*)getItemsArrayDataSource {
    if (_searchEvaluateSession == nil) {
        return nil;
    }
    else if(_searchEvaluateSession.searchEvaluateProtocal == nil) {
        return nil;
    }
    
    return _searchEvaluateSession.searchEvaluateProtocal._evaluateArray;
}


-(int)getItemsArrayAllCount {
    if (_searchEvaluateSession == nil) {
        return 0;
    }
    else if(_searchEvaluateSession.searchEvaluateProtocal == nil) {
        return 0;
    }
    
    //当总数大于100条时，只下载最多100条
    if (_searchEvaluateSession.searchEvaluateProtocal._allEvaluateCount > 100 ) {
        return 100;
    }
    
    return _searchEvaluateSession.searchEvaluateProtocal._allEvaluateCount;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
 	
    if(indexPath.section != 0) {
        return;
    }
    
	NSUInteger row = [indexPath row];
	NSUInteger count = [[self getItemsArrayDataSource] count];  
	
    if(row >= [self getItemsArrayAllCount] ) {
        //已经全拿完了
        return;
    }
    
    if (row>100) {
        _isLoading = NO; 
        return;
    }

    
    // load more
	if (row == count ) {
		
		if (_isLoading == YES) {
			return;
		} 
        
        //如果前面连续5条为空，就不继续往后加载了。
        
//        if ( row > 10 ) {
//            
//            bool is
//            for (int i=0; i<5; i++) {
//                NSObject* tempObj = [_searchEvaluateSession.searchEvaluateProtocal._evaluateArray objectAtIndex:row];
//                
//                if([tempObj isKindOfClass:[EtaoEvaluateItem class]]) {
//                    
//                    NSString *data = @"";
//                    if(_buttonAdvantage.selected == YES) {
//                        data = ((EtaoEvaluateItem*)tempObj).good;
//                    }
//                    else if(_buttonShortcoming.selected == YES) {
//                        data = ((EtaoEvaluateItem*)tempObj).bad;            
//                    }
//                    else if(_buttonExperience.selected == YES) {
//                        data = ((EtaoEvaluateItem*)tempObj).summary;
//                    }
//                }
//
//            }
//        }
        
                
       /////////////////////////////////////////////////////////////////////////////////////////
        
        
 		_isLoading = YES; 
        
        [self retain];
       [_searchEvaluateSession loadMoreFrom: count count:count+10];
	} 
}


- (void) dealloc {
	_evaluateTabView.delegate = nil;
	_evaluateTabView.dataSource = nil;
    [_evaluateTabView release];
    
    [_searchEvaluateSession release];
    
    [super dealloc];
}


@end
