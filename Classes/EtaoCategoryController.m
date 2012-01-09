//
//  EtaoCategoryController.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoCategoryController.h"
#import "EtaoCategorySession.h"
#import "ActivityIndicatorMessageView.h"
#import "EtaoCategoryItemTop.h"
#import "EtaoSRPController.h"

@interface  EtaoCategoryController()
-(void)initlizeCategorySession;
-(NSMutableArray*)getItemsArrayDataSource;
-(int)getItemsArrayAllCount;
@end


@implementation EtaoCategoryController

@synthesize etaoCategoryTableView = _etaoCategoryTableView;
@synthesize etaoCategorySession = _etaoCategorySession;
@synthesize delegate ;
@synthesize parent = _parent;

//init with nib
- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        // Do something
    }
    return self;   
}


- (id)init {
    self = [super init];
    
    if (self) {
        // Initialization code here.
    }
    return self;
} 


-(void) initlizeCategorySession {
    if(nil == _etaoCategorySession) {
        _etaoCategorySession = [[EtaoCategorySession alloc] init];
        
        _etaoCategorySession.sessionDelegate = self;
    }
}


- (void) loadView {
    [super loadView];
    
    if (nil == _etaoCategoryTableView) {
        _etaoCategoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];//self.view.frame.size.height)];
        
        _etaoCategoryTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:_etaoCategoryTableView];
        
        [_etaoCategoryTableView setDelegate:self];
        [_etaoCategoryTableView setDataSource:self];
    }
	
    [self initlizeCategorySession];
    
    ActivityIndicatorMessageView *loadv = [[[ActivityIndicatorMessageView alloc]initWithFrame:CGRectMake(120, 100, 80, 80) Message:@"正在加载"]autorelease];
    [loadv startAnimating];
    [self.view addSubview:loadv]; 
    [self.view bringSubviewToFront:loadv]; 
    self.etaoCategoryTableView.hidden = YES;
    
    [self retain];
    [_etaoCategorySession requestEtaoCategoryDate];
    
    [self setTitle:@"类目浏览"];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void) EtaoCategoryRequestDidFinish:(NSObject *)obj {
    _isLoading = NO;
    
	ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)[self.view viewWithTag:ActivityIndicatorMessageView_TAG];
	if (loadv!=nil) { 
		[loadv stopAnimating];
	} 
	self.etaoCategoryTableView.hidden = NO;
	
    if (self.etaoCategoryTableView.delegate != nil) {
        [self.etaoCategoryTableView reloadData];
    }
    
    [self release];
}


-(NSMutableArray*)getItemsArrayDataSource {
    return _etaoCategorySession.etaoCategoryProtocal.categoryArray;
}

-(NSObject*) getItemsByIndex: (int) index {
    if (_etaoCategorySession.etaoCategoryProtocal.categoryArray == nil ) {
        return 0;
    }
    
    int allRowsCount = 0;
    for (NSDictionary *itemTop in _etaoCategorySession.etaoCategoryProtocal.categoryArray) {
        if ([itemTop isKindOfClass:[EtaoCategoryItemTop class]]) {
            EtaoCategoryItemTop* topItem = (EtaoCategoryItemTop*)itemTop;
            
            if(index == allRowsCount) {
                return topItem;
            }
            
            allRowsCount++;
            
            if (topItem.isHide == NO) {
                for (NSDictionary *itemMid in [topItem categoryMidList]) {
                    if ([itemMid isKindOfClass:[EtaoCategoryItemMid class]]) {
                        EtaoCategoryItemMid* midItem = (EtaoCategoryItemMid*)itemMid;
                        
                        if(index == allRowsCount) {
                            return midItem;
                        }
                        
                        allRowsCount++;
                        
                        if (midItem.isHide == NO) {
                            for (NSDictionary *itemInfo in [midItem categoryList]) {
                                if ([itemInfo isKindOfClass:[EtaoCategoryItemInfo class]]) {
                                    EtaoCategoryItemInfo* infoItem = (EtaoCategoryItemInfo*)itemInfo;
                                    
                                    if(index == allRowsCount) {
                                        return infoItem;
                                    }
                                    
                                    allRowsCount++;
                                }       
                            }
                        }    
                    }
                    
                }
            }
        }
    }
    
    return nil;
}


-(int)getItemsArrayAllCount {
    if (_etaoCategorySession.etaoCategoryProtocal.categoryArray == nil ) {
        return 0;
    }
    
    int allRowsCount = 0;
    for (NSDictionary *itemTop in _etaoCategorySession.etaoCategoryProtocal.categoryArray) {
        if ([itemTop isKindOfClass:[EtaoCategoryItemTop class]]) {
            EtaoCategoryItemTop* topItem = (EtaoCategoryItemTop*)itemTop;
            
            allRowsCount++;
            
            if (topItem.isHide == NO) {
                for (NSDictionary *itemMid in [topItem categoryMidList]) {
                    if ([itemMid isKindOfClass:[EtaoCategoryItemMid class]]) {
                        EtaoCategoryItemMid* midItem = (EtaoCategoryItemMid*)itemMid;
                        
                        allRowsCount++;
                        
                        if (midItem.isHide == NO) {
                            for (NSDictionary *itemInfo in [midItem categoryList]) {
                                if ([itemInfo isKindOfClass:[EtaoCategoryItemInfo class]]) {
                                    //EtaoCategoryItemInfo* infoItem = (EtaoCategoryItemInfo*)itemInfo;
                                    
                                    allRowsCount++;
                                }       
                            }
                        }    
                    }
                    
                }
            }
        }
    }
    return allRowsCount;
}


- (void) EtaoCategoryRequestDidFailed:(NSObject *)obg {
	
    [self release];
    
	ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)[self.view viewWithTag:ActivityIndicatorMessageView_TAG];
	if (loadv!=nil) { 
		[loadv stopAnimating];
	} 
	self.etaoCategoryTableView.hidden = NO;
	
    //[EtaoShowAlert showAlert];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"网络不可用" message:@"无法与服务器通信，请连接到移动数据网络或者wifi." delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]autorelease];[alert show]; 
	
    _isLoading = NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;//[self getItemsArrayAllCount];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self getItemsArrayAllCount];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return 35;
    }
    
    return 0;
}


- (UIImage*) getCellIcoFromIndex:(EtaoCategoryItemTop*)categoryItemTop {
    if ([categoryItemTop.name isEqualToString:@"服装服饰"]) {
        return [UIImage imageNamed:@"list_fuzhuan.png"];
    } else if ([categoryItemTop.name isEqualToString:@"鞋帽箱包"]) {
        return [UIImage imageNamed:@"list_xiemao.png"];
    } else if ([categoryItemTop.name isEqualToString:@"3C数码"]) {
        return [UIImage imageNamed:@"list_3csm.png"];
    } else if ([categoryItemTop.name isEqualToString:@"珠宝配饰"]) {
        return [UIImage imageNamed:@"list_zhubao.png"];
    } else if ([categoryItemTop.name isEqualToString:@"家用电器"]) {
        return [UIImage imageNamed:@"list_jydq.png"];
    } else if ([categoryItemTop.name isEqualToString:@"美容化妆"]) {
        return [UIImage imageNamed:@"list_mrhz.png"];
    } else if ([categoryItemTop.name isEqualToString:@"运动户外"]) {
        return [UIImage imageNamed:@"list_hwyd.png"];
    } else if ([categoryItemTop.name isEqualToString:@"母婴用品"]) {
        return [UIImage imageNamed:@"list_muying.png"];
    } else if ([categoryItemTop.name isEqualToString:@"生活家居"]) {
        return [UIImage imageNamed:@"list_jaju.png"];
    } else  
        
        return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSString *itemCellId = [NSString stringWithFormat:@"itemCell_%d%d",indexPath.section, indexPath.row];	
    
    UITableViewCell * cell = [self.etaoCategoryTableView dequeueReusableCellWithIdentifier:itemCellId];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellId] autorelease];
        
        UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
        selectedView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0];
        cell.selectedBackgroundView = selectedView;
    }
    else {
        for (UIView *v in [cell subviews]) {
            if ([v isKindOfClass:[UILabel class]] | [v isKindOfClass:[UIImageView class]]
                | [v isKindOfClass:[UIButton class]]) {
                [v removeFromSuperview];
            }
        }
    }
    
    
    UILabel *ParameterInfo = [[[UILabel alloc] initWithFrame:CGRectMake(20, 8, 280, cell.bounds.size.height-16)] autorelease];
    ParameterInfo.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    ParameterInfo.backgroundColor = [UIColor clearColor];
    ParameterInfo.font = [UIFont systemFontOfSize:17];
    ParameterInfo.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    ParameterInfo.numberOfLines = 0;
    
    ParameterInfo.textColor = [UIColor blackColor]; 
    ParameterInfo.textAlignment = UITextAlignmentLeft;
    
    NSObject* obj = [self getItemsByIndex:indexPath.row];
    
    if ([obj isKindOfClass:[EtaoCategoryItemTop class]]) {
        [ParameterInfo setText:[(EtaoCategoryItemTop*)obj name]];
        
        UIImageView* imgView = [[[UIImageView alloc]initWithImage:[self getCellIcoFromIndex:(EtaoCategoryItemTop*)obj]]autorelease];
        [imgView setFrame:CGRectMake(10, 10, imgView.frame.size.width, imgView.frame.size.height)];
        [cell addSubview:imgView];    
        
        [ParameterInfo setFrame:CGRectMake(10+imgView.frame.size.width+10, 8, 280, cell.bounds.size.height-16)];
        cell.accessoryView = nil;
        
        cell.backgroundView = nil;
        
    }else if([obj isKindOfClass:[EtaoCategoryItemMid class]]) {
        UIImageView* imgView = nil;
        
        if ([(EtaoCategoryItemMid*)obj isHide] == YES ) {
            imgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_sub.png"]]autorelease];
        }else {
            imgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_arrow.png"]]autorelease];
        }
        
        ParameterInfo.font = [UIFont systemFontOfSize:16];
        
        [imgView setFrame:CGRectMake(30, 20, imgView.frame.size.width, imgView.frame.size.height)];
        [cell addSubview:imgView];
        
        [ParameterInfo setFrame:CGRectMake(30+imgView.frame.size.width+10, 9, 240, cell.bounds.size.height-16)];
        
        [ParameterInfo setText:[(EtaoCategoryItemMid*)obj name]];
        
        cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_arrow2.png"]]autorelease];;
        
        cell.backgroundView = nil;
        
        UIButton* button = [[[UIButton alloc] initWithFrame:CGRectMake(cell.frame.size.width-40, 0, 40, cell.frame.size.height)]autorelease];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(jumpToSrpFromItemMid:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        
    }else if([obj isKindOfClass:[EtaoCategoryItemInfo class]]) {
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        backView.backgroundColor = [UIColor colorWithRed:246/255.0f green:246/255.0f blue:248/255.0f alpha:1.0];
        cell.backgroundView = backView;   //设置选中后cell的背景颜色
        [backView release];
        
        ParameterInfo.font = [UIFont systemFontOfSize:15];
        
        [ParameterInfo setFrame:CGRectMake(50, 9, 280, cell.bounds.size.height-16)];
        
        [ParameterInfo setText:[(EtaoCategoryItemInfo*)obj name]];
        cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_arrow2.png"]]autorelease];
    }
    
    [cell addSubview:ParameterInfo];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.etaoCategoryTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSObject* obj = [self getItemsByIndex:indexPath.row];
    
    if ([obj isKindOfClass:[EtaoCategoryItemTop class]]) {
        if([(EtaoCategoryItemTop*)obj isHide] == YES) {
            ((EtaoCategoryItemTop*)obj).isHide = NO;
            
            EtaoCategoryItemTop* itemTop = (EtaoCategoryItemTop*)obj;
            
            NSMutableArray* array = [[NSMutableArray alloc] init];
            
            for (int itemp=0; itemp<[itemTop count]; itemp++) {
                NSIndexPath* __indexPath = [NSIndexPath indexPathForRow:indexPath.row+itemp+1 inSection:0];        
                [array addObject:__indexPath];
                
                
                ((EtaoCategoryItemMid*)[[itemTop categoryMidList] objectAtIndex:itemp]).isHide = YES;
            }
            
            [self getItemsArrayAllCount];
            
            [self.etaoCategoryTableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
            
            [array release];
            
        }else {
            EtaoCategoryItemTop* itemTop = (EtaoCategoryItemTop*)obj;
            
            NSMutableArray* array = [[NSMutableArray alloc] init];
            
            for (int itemp=0; itemp<[itemTop count]; itemp++) {
                NSIndexPath* __indexPath = [NSIndexPath indexPathForRow:indexPath.row+itemp+1 inSection:0];        
                [array addObject:__indexPath];
                
                EtaoCategoryItemMid* itemMid = [[itemTop categoryMidList] objectAtIndex:itemp];
                
                if (itemMid.isHide == NO) {
                    itemMid.isHide = YES;
                    NSMutableArray* arrayMid = [[NSMutableArray alloc] init];
                    
                    [self getItemsArrayAllCount];
                    
                    for (int itemp_Mid=0; itemp_Mid<[itemMid count]; itemp_Mid++) {
                        NSIndexPath* __indexPath = [NSIndexPath indexPathForRow:indexPath.row+itemp+itemp_Mid+1 inSection:0];        
                        [arrayMid addObject:__indexPath];
                    }
                    
                    [self.etaoCategoryTableView beginUpdates];
                    [self.etaoCategoryTableView deleteRowsAtIndexPaths:arrayMid withRowAnimation:UITableViewRowAnimationFade];
                    [self.etaoCategoryTableView endUpdates];
                    
                    [arrayMid release];
                }
            }
            
            ((EtaoCategoryItemTop*)obj).isHide = YES; 
            
            
            [self getItemsArrayAllCount];
    
            [self.etaoCategoryTableView beginUpdates];
            [self.etaoCategoryTableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
            [self.etaoCategoryTableView endUpdates];   
            
            [array release];
            
        }        
    }else if([obj isKindOfClass:[EtaoCategoryItemMid class]]) {
        if([(EtaoCategoryItemMid*)obj isHide] == YES) {

            ((EtaoCategoryItemMid*)obj).isHide = NO;
            
            EtaoCategoryItemMid* itemMid = (EtaoCategoryItemMid*)obj;
            
            [self getItemsArrayAllCount];
            
            NSMutableArray* array = [[NSMutableArray alloc] init];
            
            for (int itemp=0; itemp<[itemMid count]; itemp++) {
                NSIndexPath* __indexPath = [NSIndexPath indexPathForRow:indexPath.row+itemp+1 inSection:0];        
                [array addObject:__indexPath];
            }
            
            [self.etaoCategoryTableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];

            [self.etaoCategoryTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];

            [array release];
            
        }else {
            ((EtaoCategoryItemMid*)obj).isHide = YES; 
            EtaoCategoryItemMid* itemMid = (EtaoCategoryItemMid*)obj;
            
            [self getItemsArrayAllCount];
            
            NSMutableArray* array = [[NSMutableArray alloc] init];
            
            for (int itemp=0; itemp<[itemMid count]; itemp++) {
                NSIndexPath* __indexPath = [NSIndexPath indexPathForRow:indexPath.row+itemp+1 inSection:0];        
                [array addObject:__indexPath];
            }
            
            [self.etaoCategoryTableView beginUpdates];
            [self.etaoCategoryTableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
            [self.etaoCategoryTableView endUpdates];  
            
            [self.etaoCategoryTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            [array release];
        }
        
        
        
    }else if([obj isKindOfClass:[EtaoCategoryItemInfo class]]) {
        EtaoCategoryItemInfo* itemInfo = (EtaoCategoryItemInfo*)obj;
        EtaoSRPController * srp = [[[EtaoSRPController alloc] init]autorelease]; 
        srp._keyword = itemInfo.name ;
        [srp searchWord:itemInfo.name cat:itemInfo.cat ppath:@""];   
        if (_parent!=nil ) {
            [_parent.navigationController pushViewController:srp animated:YES];
        }
        else{
            [self.navigationController pushViewController:srp animated:YES];
        }
        
    }
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SelectIndex"];
}


- (IBAction) jumpToSrpFromItemMid:(id)sender {
    
    UITableViewCell *buttonCell = (UITableViewCell *)[sender superview];
    
    NSObject* obj = [self getItemsByIndex:[[self.etaoCategoryTableView indexPathForCell:buttonCell] row]];
    
    if([obj isKindOfClass:[EtaoCategoryItemMid class]]) {
        
        EtaoCategoryItemMid* itemMid = (EtaoCategoryItemMid*)obj;
        EtaoSRPController * srp = [[[EtaoSRPController alloc] init]autorelease]; 
        srp._keyword = itemMid.name ;
        [srp searchWord:itemMid.name cat:itemMid.cat ppath:@""];   
        if (_parent!=nil ) {
            [_parent.navigationController pushViewController:srp animated:YES];
        }
        else{
            [self.navigationController pushViewController:srp animated:YES];
        }
    }
    
}


- (void) dealloc {
    [_etaoCategoryTableView release];
    [_etaoCategorySession release];
    
    [super dealloc];
}
@end

