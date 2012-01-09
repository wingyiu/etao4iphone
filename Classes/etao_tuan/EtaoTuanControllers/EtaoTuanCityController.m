//
//  EtaoCityPageSlideController.m
//  etao4iphone
//
//  Created by  on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EtaoTuanCityController.h"
#import "EtaoTuanNavTitleView.h"
#import "EtaoUIBarButtonItem.h"
#import "pinyin.h"
#import "EtaoTuanCommonAnimations.h"
#import "ETaoUINavigationController.h"
#import "EtaoTuanHomeViewController.h"

@implementation EtaoTuanCityController


@synthesize cities = _cities;
@synthesize keys = _keys;
@synthesize citiesSort = _citiesSort;
@synthesize citiesHot = _citiesHot;
@synthesize titleForSection = _titleForSection;
@synthesize cityTableView = _cityTableView;
@synthesize citiesSortRow = _citiesSortRow;
@synthesize citiesHotRow = _citiesHotRow;

static float leftMargin = 15.0;
static float rightMargin = 30.0;
static float topMargin = 10.0;
static float bottonMargin = 10.0;
static float frameHeight = 30.0;
static float intervalY = 15.0;
static float intervalX = 25.0;

-(void)dealloc{

    EtaoGroupBuyLocationDataSource* location = (EtaoGroupBuyLocationDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:[EtaoGroupBuyLocationDataSource keyName:nil]];
    [location removeObserver:self forKeyPath:@"status"];
    
    if (_cities != nil) {
        [_cities removeAllObjects];
        [_cities release];
        _cities = nil;
    }  
    if (_citiesHot != nil) {
        [_citiesHot removeAllObjects];
        [_citiesHot release];
        _citiesHot = nil;
    }
    if (_citiesSort != nil) {
        [_citiesSort removeAllObjects];
        [_citiesSort release];
        _citiesSort = nil;
    }
    if (_citiesHotRow != nil) {
        [_citiesHotRow removeAllObjects];
        [_citiesHotRow release];
        _citiesHotRow = nil;
    }
    if (_citiesSortRow != nil) {
        [_citiesSortRow removeAllObjects];
        [_citiesSortRow release];
        _citiesSortRow = nil;
    }
    if (_titleForSection != nil) {
        [_titleForSection removeAllObjects];
        [_titleForSection release];
        _titleForSection = nil;
    }
    if(_LatitudeAndLongtitude != nil){
        [_LatitudeAndLongtitude removeAllObjects];
        [_LatitudeAndLongtitude release];
        _LatitudeAndLongtitude = nil;
    }
    
    if (characterLabel != nil) {
        [characterLabel release];
    }
    if (_cityTableView != nil) {
        [_cityTableView release];
        _cityTableView = nil;
    }
    if (localLabel != nil) {
        [localLabel release];
        localLabel = nil;
    }

    [_keys release];
    
    [super dealloc];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(id)init{
    
    self = [super init];
    if(self){
        _need = YES;
        _isCheck = NO;
        
        self.citiesSortRow = [[[NSMutableDictionary alloc]initWithCapacity:10]autorelease];
        self.citiesHotRow = [[[NSMutableDictionary alloc]initWithCapacity:10]autorelease];        
        
        characterLabel = [[UILabel alloc]initWithFrame:CGRectMake(145, 230, 30, 29)];
        characterLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"characterLabel.png"]];
        characterLabel.opaque = NO;
        characterLabel.font = [UIFont systemFontOfSize:18];
        characterLabel.textAlignment = UITextAlignmentCenter;
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"citydict" ofType:@"plist"];
        self.cities = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]autorelease];
        self.citiesHot = [[[NSMutableArray alloc]initWithArray:[_cities objectForKey:@"HOT"]]autorelease];
        [_cities removeObjectForKey:@"HOT"];

        self.keys = [[_cities allKeys]sortedArrayUsingSelector:@selector(compare:)];
        self.citiesSort = [[[NSMutableArray alloc]init]autorelease];
        _LatitudeAndLongtitude = [[NSMutableDictionary alloc]init];
        NSMutableDictionary *citySection;
        NSArray *tmp1;
        for (NSString *key in _keys) {
            citySection = [_cities objectForKey:key];
            [_LatitudeAndLongtitude addEntriesFromDictionary:citySection];
            tmp1 = [citySection allKeys];
            for (NSString *city in tmp1) {
                [_citiesSort addObject:city];
            }
        }
        
        //tableview中每一行展示3个城市，计算这3个城市首字母，放入_titleForSection中
        self.titleForSection = [[[NSMutableArray alloc]init]autorelease];
        NSString *str;
        for (int i=0; i<([_citiesSort count]-1)/3+1; ++i) 
        {
            NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:3];
            str = @"";            
            for (int j=0; j<3; ++j) {
                if (i*3+j < [_citiesSort count]) {
                    [arr addObject:[_citiesSort objectAtIndex:i*3+j]];
                    char c = pinyinFirstLetter([[_citiesSort objectAtIndex:i*3+j] characterAtIndex:0]);//-32;
                    NSString *s = [NSString stringWithFormat:@"%c",c];
                    str = [str stringByAppendingString:s];
                    
                }
            }
            [_citiesSortRow setObject:arr forKey:[NSString stringWithFormat:@"%d", i]];
            [arr release];
            [_titleForSection addObject:str];
        }
        
        return  self;
    }
    
    return nil;
}

-(void)loadView{
    [super loadView];

    //加载菊花
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.frame = CGRectMake(150,10,20,20);


    _cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 37.5, self.view.frame.size.width, 380)];
    _cityTableView.delegate = self;
    _cityTableView.dataSource = self;
    
    ETPageTouchView * parentLavelView = [[[ETPageTouchView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 38)]autorelease];
    [parentLavelView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"locationbg.png"]]];
    parentLavelView.delegate = self;
    
    UIImageView* rightImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locationsearch.png"]] autorelease];
    [rightImgView setFrame:CGRectMake(self.view.frame.size.width-30, 0, 30, 30)];
    rightImgView.backgroundColor = [UIColor clearColor];
    
    localLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-30, 38)]autorelease];
    localLabel.backgroundColor = [UIColor clearColor];
    localLabel.font = [UIFont boldSystemFontOfSize:12];
    localLabel.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1];
    [localLabel addSubview:_activityView];
    _activityView.hidden = YES;

    [parentLavelView addSubview:rightImgView];
    [parentLavelView addSubview:localLabel];
    [self.view addSubview:parentLavelView]; 
    [self.view addSubview:_cityTableView];
    
    _cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [_cityTableView reloadData];
    [self SingleTouch:nil];
}


-(CLLocationCoordinate2D )getLatitudeAndLongitude:(NSString *)cityName{
    CLLocationCoordinate2D coordinate = {0,0};
    if ([cityName isKindOfClass:[NSString class]] && cityName != nil && [_LatitudeAndLongtitude objectForKey:cityName]) {
        NSArray *tmp = [NSArray arrayWithArray:[_LatitudeAndLongtitude objectForKey:cityName]] ;
        coordinate.longitude = [[tmp objectAtIndex:0]doubleValue];
        coordinate.latitude = [[tmp objectAtIndex:1]doubleValue];
        return coordinate;
    }
    return coordinate;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return (1+(([_citiesSort count]-1)/3+1));
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 1;
    }
    else
    {
        return (([_citiesSort count]-1)/3+1);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(0 == indexPath.section)
    {
        
        return  (([_citiesHot count]-1)/3+1)*frameHeight+([_citiesHot count]-1)/3*intervalY+topMargin+bottonMargin;

    }
    else {
        return (topMargin + frameHeight + bottonMargin);
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *itemCityCellId = @"itemCityCell";
    UITableViewCell *cell = (UITableViewCell*)[_cityTableView dequeueReusableCellWithIdentifier:itemCityCellId];
    if(cell == nil){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCityCellId]autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (0 == indexPath.section) {
        [self setViewHot:cell];
    }
    else{
        [self setViewNorm:cell inPath:indexPath];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section ) {
        return 28;
    }
    else if(1 == section)
    {
        return 28;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *titleLabel = [[[UILabel alloc]init]autorelease];
    titleLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sectionTitlebg.png"]];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];

    if (0 == section) {
        titleLabel.text = @"    最热城市";
    }
    else if( 1 == section){
        titleLabel.text = @"    按字母排序";
    }
    return titleLabel;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
 /*   NSMutableArray *toBeReturned = [[[NSMutableArray alloc]init]autorelease];
    for (char c='A'; c<='Z'; c++) {
        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
    }
    return toBeReturned;*/
    return _keys;
}

- (BOOL)checkCharacterLockAndisRemove
{
    if(_character_num!=0){
        _character_num--;
        return YES;
    }
    else
    {
        [EtaoTuanCommonAnimations performSelector:@selector(disScalesAnimation:) withObject:characterLabel afterDelay:0];
        [characterLabel performSelector:@selector(removeFromSuperview) withObject:self afterDelay:0.3];
        return NO;
    }
}

- (void)setCharacterAnimation:(NSString *)titleStr
{
    characterLabel.text = titleStr;
    if(characterLabel.superview ==nil){
        [[UIApplication sharedApplication].keyWindow addSubview:characterLabel];
        [EtaoTuanCommonAnimations performSelector:@selector(showScalesAnimation:) withObject:characterLabel afterDelay:0];
        [self performSelector:@selector(checkCharacterLockAndisRemove) withObject:nil afterDelay:0.8];
        
    }
    else{
        _character_num ++;
        [self performSelector:@selector(checkCharacterLockAndisRemove) withObject:nil afterDelay:0.8];
    }
}



-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    //设置动画        
    [self setCharacterAnimation:title];
    
    for (int i=0; i<[_titleForSection count]; ++i) {
        if ([[_titleForSection objectAtIndex:i]rangeOfString:title].length > 0) {
            NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:1];
            [_cityTableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        }
    }
    
    return 2;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}

- (NSArray*)_getFrames:(NSArray*)texts inCell:(UITableViewCell *)cell{ 
 	UIFont *font = [UIFont systemFontOfSize:15.0];
	NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:[texts count]];
	float total = 0.0f;
	for (NSString *s in texts ) {
		CGSize size = [s sizeWithFont:font];
		total += size.width;  
	}
    float cs = 320;
    float eachWidth = (cs-leftMargin-rightMargin-2*intervalX)/3.0;
	for ( int i = 0 ; i < [texts count] ;i++) {	
        [tmp addObject:[NSNumber numberWithFloat:eachWidth]];
	}	
	return tmp ;
}

-(void)setViewHot:(UITableViewCell *)cell
{
    for (UIView *view in [cell subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
   
    for (int i=0; i<([_citiesHot count]-1)/3+1; ++i) {
        
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:3];
        for (int k=0; k<3&&i*3+k<[_citiesHot count]; ++k) {
            [tmp addObject:[_citiesHot objectAtIndex:i*3+k]];
        }
        NSArray *frameW = [self _getFrames:tmp inCell:cell];
        
        float y = i*frameHeight+topMargin+i*intervalY;
        float xsum = leftMargin;
        for (int j=0; j<3 && i*3+j<[_citiesHot count]; ++j) {
            float x0 = [[frameW objectAtIndex:j]floatValue];
            UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
            CGRect frame = CGRectMake(xsum, y, x0, frameHeight);
            [btn0 setFrame:frame];
            
            [btn0.layer setMasksToBounds:YES];
            [btn0.layer setCornerRadius:6.0];
            [btn0.layer setBorderWidth:1.0];
            [btn0.layer setBorderColor:[[UIColor colorWithRed:0.889 green:0.880 blue:0.880 alpha:1.0]CGColor]];
    
            [btn0 setTitle:[_citiesHot objectAtIndex:i*3+j] forState:UIControlStateNormal];
            [btn0 setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forState:UIControlStateNormal];
			[btn0 setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.971 green:0.971 blue:0.971 alpha:1.0] ]forState:UIControlStateNormal];
			[btn0 setBackgroundImage:[self imageWithColor:[UIColor grayColor] ] forState:UIControlStateSelected];
            [btn0.titleLabel setFont:[UIFont systemFontOfSize:14]];
            
            [btn0 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn0];
            
            xsum = btn0.frame.origin.x + x0 + intervalX;
        }
    } 
}

-(void)setViewNorm:(UITableViewCell *)cell inPath:(NSIndexPath *)indexPath
{
    
    for (UIView *view in [cell subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
/*
    NSMutableArray *citesInRow = [[[NSMutableArray alloc]init]autorelease];
    for (int i=0; i<3 && (indexPath.row*3+i)<[_citiesSort count]; ++i) {
        [citesInRow addObject:[_citiesSort objectAtIndex:(indexPath.row*3+i)]];
    }
*/    
    NSArray *wordForWidth = [self _getFrames:[_citiesSortRow objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]] inCell:cell];
    float y = topMargin;
    float xsum = leftMargin;
    for (int i=0; i<[[_citiesSortRow objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]] count]; ++i) {
        float x0 = [[wordForWidth objectAtIndex:i]floatValue];
        UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(xsum, y, x0, frameHeight);
        btn0.frame = frame;
        [btn0.layer setMasksToBounds:YES];
        [btn0.layer setCornerRadius:6.0];
        [btn0.layer setBorderWidth:1.0];
        [btn0.layer setBorderColor:[[UIColor colorWithRed:0.889 green:0.880 blue:0.880 alpha:1.0]CGColor]];
        [btn0 setTitle:[[_citiesSortRow objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]] objectAtIndex:i] forState:UIControlStateNormal];
        [btn0.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn0 setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forState:UIControlStateNormal];
        [btn0 setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.971 green:0.971 blue:0.971 alpha:1.0]] forState:UIControlStateNormal];
        [btn0 setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateSelected];
        [btn0 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn0];
        
        xsum = btn0.frame.origin.x + x0 + intervalX;
    }

    
}

#pragma mark -v Watch
/* 监视相关*/

- (void)watchWithKey:(NSString *)key{
    EtaoGroupBuyAuctionDataSource* datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:key];
    [datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
}

- (void)watchWithDatasource:(id)datasource{
    [datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
}
#pragma mark city_button listening

//主nav返回
- (void) UIBarButtonHomeClick:(UIBarButtonItem*)sender{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];  
} 

//点击城市button
-(void)btnClick:(UIButton *)btn
{
    _userLocationCity = btn.titleLabel.text;
    EtaoGroupBuyLocationDataSource* datasource = [[ETDataCenter dataCenter]getDataSourceWithKey:[EtaoGroupBuyLocationDataSource keyName:nil]];
    [datasource changeLocation:nil andCity:_userLocationCity andPosition:nil];
    [[self parentViewController] dismissModalViewControllerAnimated:YES]; 
}

#pragma mark touch to get GPS
//点击定位栏
- (void)SingleTouch:(id)sender{    
    EtaoGroupBuyLocationDataSource* datasource = [[ETDataCenter dataCenter]getDataSourceWithKey:[EtaoGroupBuyLocationDataSource keyName:nil]];
    if(datasource.status ==ET_DS_GROUPBUY_LOCATION_GPSFAIL){
        localLabel.text = [NSString stringWithFormat:@"  定位失败，您上次的位置：%@",datasource.currentPosition];
    }
    else{
        localLabel.text = @"  您当前的位置：";
        _activityView.hidden = NO;
        [_activityView startAnimating];
        [self performSelector:@selector(check) withObject:nil afterDelay:2];
    }

}

- (void)check{
    EtaoGroupBuyLocationDataSource* datasource = [[ETDataCenter dataCenter] getDataSourceWithKey:[EtaoGroupBuyLocationDataSource keyName:nil]];
    _activityView.hidden = YES;
    [_activityView stopAnimating];
    localLabel.text = [NSString stringWithFormat:@"  定位成功，您的位置：%@",datasource.currentPosition];
}

#pragma mark -v datasource event respond function

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isKindOfClass:[EtaoGroupBuyLocationDataSource class]]){
        ET_DS_GROUPBUY_LOCATION_STATUS new_status = [[change objectForKey:@"new"] intValue];
        ET_DS_GROUPBUY_LOCATION_STATUS old_status = [[change objectForKey:@"old"] intValue];
        EtaoGroupBuyLocationDataSource* datasource = object;
        switch (new_status) {
            case ET_DS_GROUPBUY_LOCATION_CHANGE: //定位成功
                if(old_status == ET_DS_GROUPBUY_LOCATION_OK){
                    _activityView.hidden = YES;
                    [_activityView stopAnimating];
                    localLabel.text = [NSString stringWithFormat:@"  定位成功，您的位置：%@",datasource.currentPosition];
                }
                break;
            default:
                break;
        }
    }
}



@end
