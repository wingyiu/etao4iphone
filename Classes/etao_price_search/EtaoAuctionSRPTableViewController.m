//
//  EtaoAuctionSRPTableViewController.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoAuctionSRPTableViewController.h"
#import "EtaoAuctionSRPDataSource.h"
#import "EtaoAuctionSRPTableViewCell.h"
#import "EtaoAuctionItem.h"
#import "EtaoLoadMoreCell.h"
#import "NSObject+SBJson.h" 
#import "ActivityIndicatorMessageView.h"
#import "EtaoUIBarButtonItem.h"
#import "NSObject+SBJson.h"
#import "etao4iphoneAppDelegate.h"
#import "ETaoHistoryViewController.h"


@implementation EtaoAuctionSRPTableViewController
 
@synthesize requestUrl = _requestUrl;
@synthesize keyword = _keyword;
@synthesize ppath = _ppath;
@synthesize catid = _catid;
@synthesize sort = _sort;
@synthesize website = _website;
@synthesize panGes = _panGes;
@synthesize filterView  = _filterView;
@synthesize head = _head;
@synthesize rankbtnv = _rankbtnv;
@synthesize rankView = _rankView;
@synthesize categorychoosed = _categorychoosed;
@synthesize fsellerNameSet = _fsellerNameSet;
@synthesize start_price = _start_price;
@synthesize end_price = _end_price;
@synthesize propchoosed = _propchoosed;

static int oo = 0 ;
static int beginx = 0 ; 


- (void) dealloc {
    
    [_datasource release];
    [_requestUrl release];
    [_panGes release];
    [_ppath release];
    [_keyword release];
    [_catid release];
    [_sort release];
    [_website release];
    [_filterView.view removeFromSuperview];
    [_filterView release];
    
    [_categorychoosed release];
    [_fsellerNameSet release];
    [_start_price release];
    [_end_price release];
    [_propchoosed release];
    
    [_catList release];
    [_catPath release];
    [_sellerList release];
    [_propKeys release];
    [_propDicts release]; 
    
    [_head release];
    [_rankbtnv release];
    [_rankView release];
    
    [_tableView release];
    
    
    [super dealloc];
}


- (id) init {
    self = [super init];     
    
    _datasource = [[EtaoAuctionSRPDataSource alloc]init];
    _datasource.delegate = self;
    _datasource.pageCount = SRP_PAGE_COUNT;
    _requestUrl = [[ETUrlObject alloc]init];
    self.categorychoosed = [[[NSMutableDictionary alloc]initWithCapacity:1]autorelease];
    self.fsellerNameSet = [[[NSMutableSet alloc]initWithCapacity:1]autorelease];
    self.propchoosed = [[[NSMutableDictionary alloc]initWithCapacity:1]autorelease];
    self.start_price = @"0";
    self.end_price = @"1000";
    return  self;
}


- (void)navButtonTapped:(id)sender { 
    //   if ([sender isKindOfClass:[UIBarButtonItem class]]) {	
    //ETFloatingViewController * catNavController = [[[ETFloatingViewController alloc] init]autorelease]; 
    
    //[self.navigationController pushViewController:catNavController animated:YES]; 
     
}
 

#pragma mark ---------gestureRecongnizer------------
- (void) showShakeAnimation:(UIView *)view
{
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(3, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-3, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(1, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:nil];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


-(void)handelPan:(UIPanGestureRecognizer*)gestureRecognizer{
    //获取平移手势对象在self.view的位置点，并将这个点作为self.aView的center,这样就实现了拖动的效果
    CGPoint curPoint = [gestureRecognizer locationInView:[self.view window] ]; 
    //在初始点如果往右滑
    CGPoint ver = [gestureRecognizer velocityInView:[[UIApplication sharedApplication] keyWindow]];
    if (ver.x > 0 && self.navigationController.view.frame.origin.x == 0) {
        [self showShakeAnimation:self.navigationController.view];
        return ;
    }

    if (beginx == 0) {
        oo = self.navigationController.view.frame.origin.x;
        beginx = curPoint.x ;
    }
    
    if ( gestureRecognizer.state == UIGestureRecognizerStateBegan ){
     //  _panGes.enabled = NO ;
        beginx = curPoint.x ; 
        // 禁用掉table的滑动
        _tableView.scrollEnabled = NO;
        _filterView.view.hidden = NO;
    }
    if ( gestureRecognizer.state == UIGestureRecognizerStateChanged ){
        
        if (self.navigationController.view.frame.origin.x <= -255 && ver.x < 0) {
            self.navigationController.view.frame = CGRectMake( -255, 
                                                              self.navigationController.view.frame.origin.y, 
                                                              self.navigationController.view.frame.size.width, 
                                                              self.navigationController.view.frame.size.height); 
        }
        else if(self.navigationController.view.frame.origin.x >= -255){
            self.navigationController.view.frame = CGRectMake( oo + (curPoint.x - beginx), 
                                                      self.navigationController.view.frame.origin.y, 
                                                      self.navigationController.view.frame.size.width, 
                                                      self.navigationController.view.frame.size.height);
        }
    }
    
    if (self.navigationController.view.frame.origin.x >= 0 ) {
        _filterView.tableView.frame = CGRectMake(0, 20, _filterView.tableView.frame.size.width, _filterView.tableView.frame.size.height);
    }
    else
    {
       _filterView.tableView.frame = CGRectMake(60, 20, _filterView.tableView.frame.size.width, _filterView.tableView.frame.size.height); 
    }

    if ( gestureRecognizer.state == UIGestureRecognizerStateEnded ){ 
        beginx = 0 ; 
        float toSize = 0 ; 
        if (ver.x < 0 && self.navigationController.view.frame.origin.x < -20 ) {
            toSize = -255;
        }
        if (ver.x > 0 && self.navigationController.view.frame.origin.x < -240) {
            toSize = -255;
        }
        [UIView beginAnimations:nil context:nil]; 
        [UIView setAnimationDuration:0.1];   
        self.navigationController.view.frame = CGRectMake(toSize, 
                                                          self.navigationController.view.frame.origin.y,
                                                          self.navigationController.view.frame.size.width,
                                                          self.navigationController.view.frame.size.height);   
        
        [UIView commitAnimations]; 
        [self showShakeAnimation:self.navigationController.view];
        
        NSArray *cellArray  = [self.tableView visibleCells];
        if (toSize == 0 ) {
            for (UITableViewCell *cell in cellArray) {
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
                selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
                cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
                [selectedView release];
            }            
            _tableView.scrollEnabled = YES;
        }else{
            for (UITableViewCell *cell in cellArray) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            } 
        }  
    }
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (_filterView == nil) {
        return NO;
    }
    CGPoint translation = [gestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
    
    // Check for horizontal gesture
    if (sqrt(translation.x * translation.x) / sqrt(translation.y * translation.y) > 1)
    {
        _filterView.view.hidden = NO;
        _tableView.scrollEnabled = NO;
        [_rankView disappeared];
       _rankbtnv._selected = YES;
        [_rankbtnv doArrow]; 
        [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:[[UIApplication sharedApplication] keyWindow]];
        return YES;
    }
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:[[UIApplication sharedApplication] keyWindow]];
    return NO;
}


#pragma mark ---------scrollview------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [super scrollViewWillBeginDragging:scrollView];
     _panGes.enabled = NO ;     
    [_rankView disappeared];
	_rankbtnv._selected = YES;
	[_rankbtnv doArrow]; 
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [super scrollViewDidEndDecelerating:scrollView];
    _panGes.enabled = YES ;

}


- (void) setFilterInfo:(NSString*)json {
    NSDictionary *jsonValue = [json JSONValue]; 
    
    _catList = [[NSMutableArray arrayWithCapacity:10] retain];
	NSArray *catList = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"catList"];
	for (NSDictionary *item in catList) { 
		ETFiterItem * cat = [[[ETFiterItem alloc]init]autorelease] ; 
		cat.name = [item objectForKey:@"name"];
		cat.key = [item objectForKey:@"key"];
        cat.ftype = ETCategory;
        if ([_categorychoosed objectForKey:cat.key]) {
            cat.selected = YES;
        }else{
            cat.selected = NO ;
        }
		[_catList addObject:cat]; 
	}  
    NSEnumerator *keyEnum = [_categorychoosed keyEnumerator];
    NSString *k;
    while (k = [keyEnum nextObject]) {
        ETFiterItem * cat = [[[ETFiterItem alloc]init]autorelease] ; 
		cat.name = [_categorychoosed objectForKey:k];
		cat.key = k;
        cat.ftype = ETCategory;
        cat.selected = YES;
		[_catList addObject:cat];
    }
    
    
    NSArray *propList = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"propList"];
    _propKeys = [[NSMutableArray alloc]initWithCapacity:10];
    _propDicts = [[NSMutableDictionary alloc]initWithCapacity:10];
	for (NSDictionary *item in propList) {
		NSMutableArray *vids = [NSMutableArray arrayWithCapacity:10];
        
		ETFiterItem * pid = [[[ETFiterItem alloc] init]autorelease];  
        [pid setFromDictionary:[item objectForKey:@"key"]]; 
		pid.selected = NO;
        for (NSDictionary *vid in [item objectForKey:@"values"]) {
			ETFiterItem * v = [[[ETFiterItem alloc] init]autorelease];
			v.name = [vid objectForKey:@"name"];
			v.key = [vid objectForKey:@"key"];
			v.selected = NO; 
            v.ftype = ETProperty; 
            [vids addObject:v]; 
		}
        
        
		[_propDicts setObject:vids forKey:pid]; 
        [_propKeys addObject:pid];
	}   
    
    [_propchoosed removeAllObjects];
    NSArray *propSelectedList = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"propertyPath"];
    for (NSDictionary *item in propSelectedList) {
        NSLog(@"%@",item);
        ETFiterItem * pid = [[[ETFiterItem alloc]init ]autorelease];
        ETFiterItem * vid = [[[ETFiterItem alloc]init ]autorelease];
        pid.key = [item objectForKey:@"key"];
        pid.name = [item objectForKey:@"keyName"]; 
        vid.key = [item objectForKey:@"valueKey"];
        vid.name = [item objectForKey:@"valueName"];
        vid.selected = YES;
        
        for (ETFiterItem *p in _propKeys) {
            BOOL found = NO ;
            if ([p.key isEqualToString:pid.key]) {
                for (ETFiterItem *v in [_propDicts objectForKey:p]) {
                    if ([v.key isEqualToString:vid.key]) {
                        v.selected = YES;
                        found = YES;
                        [_propchoosed setObject:[NSString stringWithFormat:@"%@:%@", p.key, v.key] forKey:v.name];
                        break;
                    }  
                } 
                if (!found) {
                    [[_propDicts objectForKey:p] addObject:vid];
                    [_propchoosed setObject:[NSString stringWithFormat:@"%@:%@", p.key, vid.key] forKey:vid.name];
                }
            }
        } 
    }  
    
    
    NSString *sellerlist = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"sellerList"];
    _sellerList = [[NSMutableArray alloc]initWithCapacity:20];
    for (NSString *b2c in [sellerlist componentsSeparatedByString:@","]) {
        ETFiterItem * w = [[ETFiterItem alloc]init];
        w.key = b2c ;
        w.name = b2c ;
        w.ftype = ETB2C ;
        if ([_fsellerNameSet containsObject:w.name]) {
            w.selected = YES;
        }else{
            w.selected = NO;
        }
        [_sellerList addObject:w];
        [w release];
        
    } 
    
}
 

- (EtaoAuctionSearchCategoryFilterViewController*) getSRPFilterBy:(NSString*)json type:(ETFilterType)type{
    EtaoAuctionSearchCategoryFilterViewController *cat = [[[EtaoAuctionSearchCategoryFilterViewController alloc]init]autorelease];
    cat.ftype = type;
    cat.delegate = self;
    
    if (type == ETCategory) { 
        cat.title = @"分类";
        [cat.itemDicts setObject:_catList forKey:@"分类"];
        cat.choosedCategory = _categorychoosed;
//        NSEnumerator *keyEnum = [_categorychoosed keyEnumerator];
//        NSString *k;
//        while (k = [keyEnum nextObject]) {
//            [cat.choosedCategory setObject:[_categorychoosed objectForKey:k] forKey:k];
//        }
    }
    if (type == ETProperty) {
        cat.title = @"属性";
        cat.itemDicts = _propDicts ;
        cat.itemKeys = _propKeys ; 
        cat.choosedProp = _propchoosed;
    }
    if (type == ETB2C) {
        cat.title = @"商家";
        [cat.itemKeys addObject:@"商家"];
        [cat.itemDicts setObject:_sellerList forKey:@"商家"]; 
        cat.choosedSeller = _fsellerNameSet;
    }
    if (type == ETOther) {
        cat.title = @"价格区间";
        if (_start_price != nil && _end_price != nil) {
            cat.start_price = _start_price;
            cat.end_price = _end_price;
        }
    }
    return cat;    
}



- (void) goToCatByType{
    self.navigationController.view.frame = CGRectMake(260, 
                                                      self.navigationController.view.frame.origin.y, 
                                                      self.navigationController.view.frame.size.width, 
                                                      self.navigationController.view.frame.size.height);
     
  
    [self.navigationController pushViewController:[self getSRPFilterBy:_datasource.content type:ETProperty] animated:NO]; 
    
    [UIView beginAnimations:nil context:nil]; 
    [UIView setAnimationDuration:0.2]; 
    self.navigationController.view.frame = CGRectMake(0, 
                                                      self.navigationController.view.frame.origin.y, 
                                                      self.navigationController.view.frame.size.width, 
                                                      self.navigationController.view.frame.size.height); 
    _filterView.tableView.frame = CGRectMake(_filterView.tableView.frame.origin.x - 260, 20, _filterView.tableView.frame.size.width , _filterView.tableView.frame.size.height);   
    _tableView.scrollEnabled = YES;
    [UIView commitAnimations];
    
}


- (void) EtaoSearchFilterItemSelected:(ETaoFilterItem *)item {
    self.navigationController.view.frame = CGRectMake(260, 
                                                      self.navigationController.view.frame.origin.y, 
                                                      self.navigationController.view.frame.size.width, 
                                                      self.navigationController.view.frame.size.height);
    
    
    [self.navigationController pushViewController:[self getSRPFilterBy:_datasource.content type:item.type] animated:NO]; 
    
    
    
    [UIView beginAnimations:nil context:nil]; 
    [UIView setAnimationDuration:0.2]; 
    self.navigationController.view.frame = CGRectMake(0, 
                                                      self.navigationController.view.frame.origin.y, 
                                                      self.navigationController.view.frame.size.width, 
                                                      self.navigationController.view.frame.size.height); 
    _filterView.tableView.frame = CGRectMake(_filterView.tableView.frame.origin.x - 260, 20, _filterView.tableView.frame.size.width , _filterView.tableView.frame.size.height);   
    _tableView.scrollEnabled = YES;
    [UIView commitAnimations];
}


- (void)  EtaoAuctionSearchCategoryFilterBack:(EtaoAuctionSearchCategoryFilterViewController *)v {
    if ([v.title isEqualToString:@"分类"]) {
        NSEnumerator *e = [v.choosedCategory keyEnumerator];
        NSString *tmp;
        NSString *catid_tmp = @"";
//        [_categorychoosed removeAllObjects];
        while (tmp = [e nextObject]) {
            if ([catid_tmp isEqualToString:@""]) {
                catid_tmp = [catid_tmp stringByAppendingString:tmp];
            }else{
                catid_tmp = [catid_tmp stringByAppendingFormat:@" %@",tmp];
            }
            
 //           [_categorychoosed setObject:[v.choosedCategory objectForKey:tmp] forKey:tmp];
        }
        self.categorychoosed = v.choosedCategory;
        _catid = catid_tmp;
        [self searchWord:_keyword cat:_catid ppath:_ppath website:_website start_price:_start_price end_price:_end_price sort:_sort]; 
		
        [_tableView reloadData];
    }
    if ([v.title isEqualToString:@"属性"]) {
        NSEnumerator *e = [v.choosedProp keyEnumerator];
        NSString *tmp;
        NSString *ppath_tmp = @"";
        while (tmp = [e nextObject]) {
            if ([ppath_tmp isEqualToString:@""]) {
                ppath_tmp = [ppath_tmp stringByAppendingString:[v.choosedProp objectForKey:tmp]];
            }else{
                ppath_tmp = [ppath_tmp stringByAppendingFormat:@";%@",[v.choosedProp objectForKey:tmp]];
            }
        }
        _ppath = ppath_tmp;
        [self searchWord:_keyword cat:_catid ppath:_ppath website:_website start_price:_start_price end_price:_end_price sort:_sort]; 
		
        [_tableView reloadData];
    }
    if ([v.title isEqualToString:@"商家"]) {
//        [_fsellerNameSet removeAllObjects];
        NSString *fseller_tmp = @"";
        for (NSString *s in v.choosedSeller) {
            if ([fseller_tmp isEqualToString:@""]) {
                fseller_tmp = s;
            }else{
                fseller_tmp = [fseller_tmp stringByAppendingFormat:@",%@", s];
            }
//            [_fsellerNameSet addObject:s];
        }
        self.fsellerNameSet = v.choosedSeller;
        _website = fseller_tmp;
        [self searchWord:_keyword cat:_catid ppath:_ppath website:_website start_price:_start_price end_price:_end_price sort:_sort]; 
		
        [_tableView reloadData];
    }
    if ([v.title isEqualToString:@"价格区间"]) {
        if ([v.start_price intValue] <= [v.end_price intValue]) {
            self.start_price = v.start_price;
            self.end_price = v.end_price;
        }else{
            self.start_price = v.end_price;
            self.end_price = v.start_price;
        }
        [self searchWord:_keyword cat:_catid ppath:_ppath website:_website start_price:_start_price end_price:_end_price sort:_sort]; 
		
        [_tableView reloadData];
    }
}


- (void)  EtaoAuctionSearchCategoryFilterDone:(EtaoAuctionSearchCategoryFilterViewController *)v {
    
}


#pragma mark ---------datasource------------
// 请求完成
- (void) ETSRPDataSourceRequestFinished:(ETSRPDataSource *)request {
    [_tableView reloadData];
    if (_filterView != nil) {
        [_filterView.view removeFromSuperview];
    }
    if ([_datasource.items count] > 0 ) {
		[_head setTextForSRP:_keyword Total:_datasource.totalCount Now:1];
 	} 
	else {
		[_head setText:@"很抱歉，没有找到符合条件的商品。"];
	}
    
    
    self.filterView = [[[EtaoSearchFilterViewController alloc]init]autorelease];
    _filterView.view.hidden = YES;
    _filterView.delegate = self;
    _filterView.headTitle = [NSString stringWithFormat:@"筛选\"%@\"",_keyword];
    
    [self setFilterInfo:_datasource.content];
    
    NSEnumerator *keyEnum = [_categorychoosed keyEnumerator];
    NSString *k;
    while (k = [keyEnum nextObject]) {
        [_filterView.catNameSet addObject:[_categorychoosed objectForKey:k]];
    }    
    NSEnumerator *prop_keyEnum = [_propchoosed keyEnumerator];
    NSString *prop_key;
    while (prop_key = [prop_keyEnum nextObject]) {
        [_filterView.propNameSet addObject:prop_key];
    }
    for (NSString *s in _fsellerNameSet) {
        [_filterView.sellerNameSet addObject:s];
    }
    if (_start_price != nil) {
        _filterView.start_price = _start_price;
    }
    if (_end_price != nil) {
        _filterView.end_price = _end_price;
    }
    
    ETaoFilterItem *item1 = [[[ETaoFilterItem alloc]init]autorelease];
    item1.title = [NSString stringWithFormat:@"分类",_keyword];
    item1.type = ETCategory;
    item1.tag = 0 ;
    
    ETaoFilterItem *item2= [[[ETaoFilterItem alloc]init]autorelease];
    item2.title = @"属性";
    item2.type = ETProperty;
    item2.tag = 1 ;
    
    
    ETaoFilterItem *item3 = [[[ETaoFilterItem alloc]init]autorelease];
    item3.title = @"商家";
    item3.type = ETB2C;
    item3.tag = 2 ;
    
    ETaoFilterItem *item4 = [[[ETaoFilterItem alloc]init]autorelease];
    item4.title = @"价格区间";
    item4.type = ETOther;
    item4.tag = 3 ;
    
    if ([_catList count] > 0 ) { 
        [_filterView.items addObject:item1]; 
    }
    if ([_propKeys count] > 0) {
        [_filterView.items addObject:item2];
    } 
    if ([_sellerList count] > 0 ) {
        [_filterView.items addObject:item3];
    } 
    [_filterView.items addObject:item4]; 
    
    UIView *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_filterView.view];
    [window sendSubviewToBack:_filterView.view]; 
    
    
    
}


// 请求失败
- (void) ETSRPDataSourceRequestFailed:(ETSRPDataSource *)request {
    [super ETSRPDataSourceRequestFailed:request];
}


#pragma mark ---------rankbtn-----------
-(void) rankClick:(id)sender
{
	if (_rankView._appeared) {
		UIButton *rankbtn = (UIButton *)sender;
		rankbtn.selected = YES;
		_rankbtnv._selected = YES;
		[_rankbtnv doArrow];
		[_rankView disappeared];
	}
	else {
		_rankbtnv._selected = NO;
		[_rankbtnv doArrow];
		[_rankView appeared];
	} 
}


-(void) rankbtnselected:(id)sender
{
	if ([sender isKindOfClass:[UIButton class]]) {
		UIButton *btn = (UIButton*) sender;
		NSLog(@"%d",btn.tag);
		NSString *text = @"排序";
		if (btn.tag == 0) {
			_sort = @"sale-desc";
			text = @"销量降序";
		}
		else if(btn.tag == 1){
			_sort = @"price-asc";
			text = @"价格升序";
		}
		else if(btn.tag == 2){
			_sort = @"price-desc";
			text = @"价格降序";
		}
		else if(btn.tag == 3){
			_sort = nil;
			text = @"人气降序";
		} 
		[_datasource clear];
        [self searchWord:_keyword cat:_catid ppath:_ppath website:_website start_price:_start_price end_price:_end_price sort:_sort]; 
		
        [_tableView reloadData];
		[_rankView disappeared];
		_rankbtnv._selected = YES;
		[_rankbtnv setText:text];
		[_rankbtnv doArrow];
	}
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-Sort"];
}	 


#pragma mark ---------loadview------------
- (void) loadView {
    [super loadView];
    EtaoUIBarButtonItem* nav = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"筛选" bkColor:[UIColor lightGrayColor] target:self action:@selector(navButtonTapped:)]autorelease];
    self.navigationItem.rightBarButtonItem = nav;
    
    self.panGes = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)]autorelease];
    [self.view addGestureRecognizer:_panGes];
    _panGes.delegate = self; 
    
    _head= [[EtaoLocalListHeadDistanceView alloc] initWithFrame:CGRectMake(0, 0, 320,30)]; 
	[self.view addSubview:_head]; 
	 
	_tableView.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,30)]autorelease]; 
    
	
	_rankView = [[EtaoMenuView alloc] initWithFrame:CGRectMake(62.5f, 0.0f, 195.0f, 153.0f)]; 
    
	[_rankView addTarget:self action: @selector(rankbtnselected:)];
	[self.view addSubview:_rankView]; 
    
    _rankbtnv = [[EtaoCustomButtonView alloc] initWithFrame:CGRectMake(0,0,200,30)];
	_rankbtnv.delegate = self;
	_rankbtnv.buttonClick = @selector(rankClick:);
	self.navigationItem.titleView = _rankbtnv;  
}


#pragma mark ---------tableview代理------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{  
	if ( _datasource.totalCount < 0 ) {
		return 0;
	}
	
	if ( _datasource.totalCount == 0 ) {
        if (_datasource.status == 1 ) {
            return 0 ;
        }
        else{
            return 1 ;
        } 
    }
	
	if ([_datasource count] < _datasource.totalCount ) {
        return [_datasource count] + 1;
    } else {
        return [_datasource count] ;
    }
}


- (void) loadMoreFrom:(NSArray*)startEnds{ 
	
    if ( [_datasource isKindOfClass:[EtaoAuctionSRPDataSource class]] ) {  
        
        [_requestUrl addParam:@"com.taobao.wap.rest2.etao.search" forKey:@"api"];
        [_requestUrl addParam:@"*" forKey:@"v"];
        
        NSNumber *s = (NSNumber*)[startEnds objectAtIndex:0];
        NSNumber *n = (NSNumber*)[startEnds objectAtIndex:1];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
        [dict setValue:_keyword forKey:@"q"];
        [dict setValue:s forKey:@"s"];
        [dict setValue:n forKey:@"n"];
        
        if (_catid != nil) {
            [dict setValue:_catid forKey:@"cat"];
        }
        if (_ppath != nil) {
            [dict setValue:_ppath forKey:@"ppath"];
        }
        if (_website != nil) {
            [dict setValue:_website forKey:@"fseller"];
        }
        if (_sort != nil) {
            [dict setValue:_sort forKey:@"sort"];
        }
        if (_start_price != nil) {
            [dict setValue:_start_price forKey:@"start_price"];
        }
        if (_end_price != nil) {
            [dict setValue:_end_price forKey:@"end_price"];
        }
        
        [_requestUrl addParam:[dict JSONRepresentation] forKey:@"data"]; 
        [_datasource setUrl:[_requestUrl getRequesrUrl]];  
        [_datasource start];

    }
}


- (void) search:(NSString*)keyword{     
    
    self.keyword = keyword ; 
    [_datasource clear];
    [self.tableView reloadData]; 
    NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:SRP_PAGE_COUNT],nil];
    [self loadMoreFrom:startEnds]; 
}


- (void) searchWord:(NSString*)keyword cat:(NSString*)cat ppath:(NSString*)ppath website:(NSString*) website start_price:(NSString *)start_price end_price:(NSString *)end_price sort:(NSString*) sort{
    self.keyword = keyword ; 
    self.catid = cat;
    self.ppath = ppath ;
    self.website = website;
    self.start_price = start_price;
    self.end_price = end_price;
    self.sort = sort;
    [_datasource clear];
    [self.tableView reloadData]; 
    NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:SRP_PAGE_COUNT],nil];
    [self loadMoreFrom:startEnds];   
}


- (void) reloadLastRequest:(id)sender{ 
	int count = [_datasource count];
	NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:20],nil]; 
    
	[self performSelector:@selector(loadMoreFrom:) withObject:startEnds  afterDelay:0.1]; 

}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [EtaoAuctionSRPTableViewCell height];
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[_httpImageRequest count]);
    static NSString *CellIdentifier = @"Cell";
    static NSString *moreCellId = @"moreCell"; 
    
    NSUInteger row = [indexPath row];
	NSUInteger count = [_datasource count];
    
    if (row == count ) { 
		EtaoLoadMoreCell * cell = (EtaoLoadMoreCell*)[tableView dequeueReusableCellWithIdentifier:moreCellId];
		if (cell == nil) {
			cell = [[[EtaoLoadMoreCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellId] autorelease];
            UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
            selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
            cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
            [selectedView release];
            
		} 
		cell._parent = self; 
		if ( _datasource.status == 0 ) {
			[cell setReload];
			cell.delegate =self;
			cell.action = @selector(reloadLastRequest:);
		}
        else
        {
  //          NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:20],nil];  
  //          [self performSelector:@selector(loadMoreFrom:) withObject:startEnds  afterDelay:0.1];
        }
		return cell; 
	}

    else
    {
        EtaoAuctionSRPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[EtaoAuctionSRPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.queue = _queue;
            cell.loadingImageDic = _loadingImageDic;
            cell.httpImageRequestArr = _httpImageArr;
            [cell setImageFrame:CGRectMake(5, 5, 90, 90)];
            
            UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
            selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
            cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } 
        else
        {
//            [cell.httpImage.http setQueuePriority:NSOperationQueuePriorityVeryLow];
        }
        if ([_datasource count] == 0 ) {
            return cell;
        }
         
        id item = [_datasource.items objectAtIndex:[indexPath row]]; 
        if ([item isKindOfClass:[EtaoAuctionItem class]]) {
            [cell setItem:item url:((EtaoAuctionItem*)item).pic]; 
        }
        else if ([item isKindOfClass:[EtaoProductItem class]]) {
            [cell setItem:item url:((EtaoProductItem*)item).pictUrl];     
        }
         
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    
	NSUInteger row = [indexPath row];
	NSUInteger count = [_datasource count];
	
    int maxidx = 0 ;
    for (id c in tableView.visibleCells) {
		if ([ c isKindOfClass:[EtaoAuctionSRPTableViewCell class]]) {
			EtaoAuctionSRPTableViewCell *vc = (EtaoAuctionSRPTableViewCell*)c ;  
            int idx = [_datasource.items indexOfObject:vc.item];
            if ( idx > maxidx) maxidx = idx ; 
		}
	}
    
    [_head setTextForSRP:_keyword Total:_datasource.totalCount Now:maxidx]; 
     
	
	// load more
	if (count == 0 || count == _datasource.totalCount) {
		return;
	}
	
	if (row > count - 5 ) {
		
		if ( _datasource.loading ) {
			return;
		}  
		_datasource.loading = YES ;
		NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:20],nil];  
        [self loadMoreFrom:startEnds];
		//[self performSelector:@selector(loadMoreFrom:) withObject:startEnds  afterDelay:0];
	}     
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.navigationController.view.frame.origin.x <= -255) {    
        [UIView beginAnimations:nil context:nil]; 
        [UIView setAnimationDuration:0.3];             
        self.navigationController.view.frame = CGRectMake( 0, 
                                                          self.navigationController.view.frame.origin.y, 
                                                          self.navigationController.view.frame.size.width, 
                                                          self.navigationController.view.frame.size.height);
        self.tableView.scrollEnabled = YES;
        [UIView commitAnimations]; 
        NSArray *cellArray = [self.tableView visibleCells];
        for (UITableViewCell *cell in cellArray) {
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
            selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
            cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
            [selectedView release];
        }            
        return;
    }
    

    _filterView.view.hidden = YES; 
    
    [_rankView disappeared];
    _rankbtnv._selected = YES;
    [_rankbtnv doArrow]; 
    
    UIApplication *app = [UIApplication sharedApplication];
    etao4iphoneAppDelegate *delegate = (etao4iphoneAppDelegate *)app.delegate; 
    
    ETaoHistoryViewController *his = [delegate etaoHistoryViewController];
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	if ([cell isKindOfClass:[EtaoAuctionSRPTableViewCell class]]) {
        EtaoAuctionSRPTableViewCell *etaoinfo = (EtaoAuctionSRPTableViewCell*) cell; 
        if ( [etaoinfo.item isKindOfClass:[EtaoProductItem class]] ){
            EtaoProductItem *item =  (EtaoProductItem *)etaoinfo.item;  
            NSString *json = [[item toDictionary] JSONRepresentation];
            
            [his addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.pid hash]] Name:@"product" JSON:json];
            
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:item.title,@"q",item.pid,@"epid",nil];
            SearchDetailController *detail = [[[SearchDetailController alloc]initWithProduct:dict]autorelease];
            [self.navigationController pushViewController:detail animated:YES];
            
        }
        else
        {
            EtaoAuctionItem *item =  (EtaoAuctionItem *)etaoinfo.item;   
            NSString *json = [[item toDictionary] JSONRepresentation];
            [his addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.nid hash]] Name:@"auction" JSON:json];
             
            
            TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURLAndType:item.link title:item.title type:[item.userType intValue] isSupportWap:[item.isLinkWapUrl boolValue]] autorelease];
            
            webv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webv animated:YES];
        } 
	} 
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SelectIndex"];
}

@end
