//
//  EtaoUISearchDisplayController.m
//  etaoetao
//
//  Created by GuanYuhong on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EtaoUISearchDisplayController.h"
#import "HttpRequest.h"
#import "EtaoUIBarButtonItem.h"
#import "NSString+QueryString.h"
#import "NSObject+SBJson.h"


@implementation UITextField (MyTextField)

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect leftBounds = CGRectMake(bounds.origin.x + 7.5, bounds.origin.y+7.5, 17.5,17.5);
    return leftBounds;
}

@end


@implementation EtaoUISearchDisplayController

@synthesize textField = _textField;
@synthesize tableView = _tableView; 
@synthesize suggestList = _suggestList; 
@synthesize searchBarButton = _searchBarButton ;
@synthesize navItems = _navItems;
@synthesize _loadingSuggest;
@synthesize _withSearch ;
@synthesize delegate; 
@synthesize didtextFieldInputDidEnd;
@synthesize didtextFieldWordSelected;
@synthesize didtextFieldInputDidStart;
@synthesize didtextFieldInputDidCancel ;
@synthesize didsearchButtonDidClick;

static NSString *inputHistoryList = @"user_input_history_list";
static NSString *clearnHistoryList = @"清除搜索历史...";

- (id)initWithTextField:(UITextField *)textField tableView:(UITableView *)tableview NavItem:(UINavigationItem *)navItems withSearchButton:(BOOL) btn{
    self = [super init];
    if (self) { 
		self.textField = textField;
        self.tableView = tableview;
        self.searchBarButton =  [[[EtaoUIBarButtonItem alloc] initWithTitle:@"搜索"  bkColor:[UIColor whiteColor] target:self action:@selector(searchBarButtonClick:)]autorelease]; ;  
    
        self.navItems = navItems;
        self._withSearch = btn;
        
        _textField.leftViewMode = UITextFieldViewModeAlways;   
        _textField.leftView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search.png"]] autorelease];  
        _textField.borderStyle = UITextBorderStyleNone;  
        _textField.layer.cornerRadius = 2.0;
        
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing; 
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.placeholder = @"搜索，比较，省钱"; 
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.delegate = self;
        
//        UIImageView* searchImgIco = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search.png"]]autorelease];
//        [[textField superview] addSubview:searchImgIco];
        
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.autoresizesSubviews = YES;
        _tableView.delegate = self ;
        _tableView.dataSource = self ; 
        
        
        self.suggestList = [NSMutableArray arrayWithCapacity:20]; 
        //load History input list
        //self.historyList = [NSMutableArray arrayWithCapacity:20];
        [_suggestList setArray:[[NSUserDefaults standardUserDefaults] arrayForKey:inputHistoryList]];
        if ([_suggestList count] > 0) {
            [_suggestList addObject:clearnHistoryList];
        }
        
        [self setDidtextFieldWordSelected:@selector(textFieldWordSelected:)];
        [self setDidtextFieldInputDidEnd:@selector(textFieldInputDidEnd:)];
        [self setDidtextFieldInputDidStart:@selector(textFieldInputDidStart:)];
        [self setDidtextFieldInputDidCancel:@selector(textFieldInputDidCancel:)];
        [self setDidsearchButtonDidClick:@selector(searchButtonDidClick:)];
        
        if (btn == YES) { 
            _navItems.rightBarButtonItem = _searchBarButton ;
        }
        
        return self;  
    }
	return nil; 
    
} 

- (void) dealloc {
    _tableView.delegate = nil ;
    _tableView.dataSource = nil ; 
    [_suggestList release];
    [_searchBarButton release];
    [_textField release];
    [_tableView release];
    [super dealloc];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    //当输入长度为0时，显示历史
    //[self._suggestList setArray:self.historyList];
    [_suggestList setArray:[[NSUserDefaults standardUserDefaults] arrayForKey:inputHistoryList]];
    if ([_suggestList count] > 0) {
        [_suggestList addObject:clearnHistoryList];
    }
    
    [_tableView reloadData];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	
    //当输入长度为0时，显示历史
    NSMutableString *newValue = [[_textField.text mutableCopy] autorelease];
    [newValue replaceCharactersInRange:range withString:string];
    if ([newValue length]== 0) {
        //[self._suggestList setArray:self.historyList];
        [_suggestList setArray:[[NSUserDefaults standardUserDefaults] arrayForKey:inputHistoryList]];
        if ([_suggestList count] > 0) {
            [_suggestList addObject:clearnHistoryList];
        }
        
        [_tableView reloadData];
        return YES;
    }
    
    if (self._loadingSuggest == YES) {
		return YES;
	}  
     
	_tableView.hidden = NO;
	
    // add
	if (range.length == 0) {
		[self loadSuggest:[NSString stringWithFormat:@"%@%@",_textField.text,string]];
	}
	else { 
		NSRange r = {0,range.location};
		[self loadSuggest:[_textField.text substringWithRange:r]]; 
	}
	 
    
	return YES;
}
 

- (void)saveInputText :(NSString*)inputText {
    //首位去除空格后，长度为0，
    NSString* str = [inputText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; 
    if ([str length] == 0) {
        return;
    }
    
    NSMutableArray* historyList = [NSMutableArray arrayWithCapacity:20];
    [historyList setArray:[[NSUserDefaults standardUserDefaults] arrayForKey:inputHistoryList]];
    
    for (NSString *v in historyList) {
        if ([v isKindOfClass:[NSString class]] == YES) {
            
            if([str isEqualToString:v]) {
                [historyList removeObject:v];
                break;
            }
        }
    }
    
    [historyList insertObject:str atIndex:0];
    
    if ([historyList count] > 10 ) {
        [historyList removeLastObject];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:historyList forKey:inputHistoryList];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

 
- (void)clearnHistoryList {
    NSMutableArray* historyList = [NSMutableArray arrayWithCapacity:20];
    [[NSUserDefaults standardUserDefaults] setObject:historyList forKey:inputHistoryList];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_suggestList setArray:historyList];
    [_tableView reloadData];
}

- (void) setButtonText:(NSString*)text{
    self.searchBarButton =  [[[EtaoUIBarButtonItem alloc] initWithTitle:text  bkColor:[UIColor whiteColor] target:self action: @selector(searchBarButtonClick:)]autorelease];  
    [_navItems setRightBarButtonItem:_searchBarButton animated:NO] ; 
}

- (void) searchBarButtonClick:(EtaoUIBarButtonItem*)sender{
    
    if (self.delegate && self.didsearchButtonDidClick && [self.delegate respondsToSelector:self.didsearchButtonDidClick]) {  
        [self.delegate performSelectorOnMainThread:self.didsearchButtonDidClick withObject:sender waitUntilDone:YES];
    } 
    
    if ([_searchBarButton.title isEqualToString:@"取消"]) {
        if (self.delegate && self.didtextFieldInputDidCancel && [self.delegate respondsToSelector:self.didtextFieldInputDidCancel]) {  
            [self.delegate performSelectorOnMainThread:self.didtextFieldInputDidCancel withObject:nil waitUntilDone:YES];
        } 
        if (!_withSearch) { 
            [_navItems setRightBarButtonItem:nil animated:NO] ;
        }
        else{
            self.searchBarButton =  [[[EtaoUIBarButtonItem alloc] initWithTitle:@"搜索"  bkColor:[UIColor whiteColor] target:self action:@selector(searchBarButtonClick:)]autorelease]; 
            [_navItems setRightBarButtonItem:_searchBarButton animated:YES] ;
        }
    } 
    else if ([_searchBarButton.title isEqualToString:@"搜索"]) {
        if (_textField.text== nil || [_textField.text isEqualToString:@""]) {
            return ;
        }
        if (self.delegate && self.didtextFieldInputDidCancel && [self.delegate respondsToSelector:self.didtextFieldInputDidCancel]) {  
            [self.delegate performSelectorOnMainThread:self.didtextFieldInputDidEnd withObject:_textField.text waitUntilDone:YES];
        }  
        if (!_withSearch) { 
            [_navItems setRightBarButtonItem:nil animated:NO] ;
        }
        else{
            self.searchBarButton =  [[[EtaoUIBarButtonItem alloc] initWithTitle:@"搜索"  bkColor:[UIColor whiteColor] target:self action: @selector(searchBarButtonClick:)]autorelease];  
            [_navItems setRightBarButtonItem:_searchBarButton animated:YES] ; 
        }
    }
    
    [_textField resignFirstResponder];  
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && self.didtextFieldInputDidStart && [self.delegate respondsToSelector:self.didtextFieldInputDidStart]) { 
        NSLog(@"HttpRequest call");  
        [self.delegate performSelectorOnMainThread:self.didtextFieldInputDidStart withObject:textField.text waitUntilDone:YES];
    }  
    
    self.searchBarButton =  [[[EtaoUIBarButtonItem alloc] initWithTitle:@"取消"  bkColor:[UIColor whiteColor] target:self action:@selector(searchBarButtonClick:)]autorelease];   
    [_navItems setRightBarButtonItem:_searchBarButton animated:YES] ;
      
    [_suggestList setArray:[[NSUserDefaults standardUserDefaults] arrayForKey:inputHistoryList]];
    if ([_suggestList count] > 0) {
        [_suggestList addObject:clearnHistoryList];
    }
    [_tableView reloadData];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
	[_textField resignFirstResponder];   
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text== nil || [textField.text isEqualToString:@""]) {
        return YES;
    }
    if (self.delegate && self.didtextFieldInputDidEnd && [self.delegate respondsToSelector:self.didtextFieldInputDidEnd]) {  
        [self.delegate performSelectorOnMainThread:self.didtextFieldInputDidEnd withObject:textField.text waitUntilDone:YES];
    } 
    
    [self saveInputText:_textField.text];     
 	[_textField resignFirstResponder];  
    
    if (!_withSearch) {
        [_navItems setRightBarButtonItem:nil animated:NO] ;
    } 
    else
    {
    if ([_searchBarButton.title isEqualToString:@"取消"]) {
        if (self.delegate && self.didtextFieldInputDidCancel && [self.delegate respondsToSelector:self.didtextFieldInputDidCancel]) {  
            [self.delegate performSelectorOnMainThread:self.didtextFieldInputDidCancel withObject:nil waitUntilDone:YES];
        } 
        self.searchBarButton =  [[[EtaoUIBarButtonItem alloc] initWithTitle:@"搜索"  bkColor:[UIColor whiteColor] target:self action:@selector(searchBarButtonClick:)]autorelease]; 
        [_navItems setRightBarButtonItem:_searchBarButton animated:YES] ;
    }  
    }
    
	return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{  
	return YES;	
}


- (void) loadSuggest:(NSString*)text {
	[self retain];
	_loadingSuggest = YES;
	NSString *url = [NSString stringWithFormat:@"http://suggest.taobao.com/sug?code=utf-8&q=%@",[text stringForHttpRequest]];
	HttpRequest *httpquery = [[[HttpRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
	[httpquery load:url]; 
}


- (void) requestFinished:(HttpRequest*)sender {
    
    NSMutableString *newValue = [[_textField.text mutableCopy] autorelease];
    //[newValue replaceCharactersInRange:range withString:string];
    
    if ([newValue length] != 0) {
        HttpRequest * request = (HttpRequest *)sender; 
        NSDictionary *json = [request.jsonString JSONValue];
        //	NSLog(@"json=%@",json);
        NSArray *result = [json objectForKey:@"result"];
        //	NSLog(@"result=%@",result);
        [_suggestList removeAllObjects]; 
        for (NSArray *v in result) {
            NSLog(@"%@",[v objectAtIndex:0]);
            [_suggestList addObject:[v objectAtIndex:0]];
        }  
        
        //去除重复的
        [_suggestList removeObject:_textField.text];
        [_suggestList insertObject:_textField.text atIndex:0];
        
        [_tableView reloadData];
    }
    self._loadingSuggest = NO;
	
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_suggestList count] ;
}


-(void) changeInputText:(id)sender {
    UIButton *imgView = (UIButton *)sender;
    UITableViewCell *imgCell = (UITableViewCell *)[imgView superview];
    
    //获取表视图的一行id
    NSUInteger buttonRow = [[_tableView indexPathForCell:imgCell] row];
    
    if (buttonRow < [_suggestList count]) {
        [_textField setText:[_suggestList objectAtIndex:buttonRow]];
        
        if (_loadingSuggest == YES) {
            return;
        }  
        
        _tableView.hidden = NO;
        
        [self loadSuggest:_textField.text]; 
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell * cell = (UITableViewCell*)[_tableView dequeueReusableCellWithIdentifier:@"cell"];
	
    if (cell == nil) {
		cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
	} 
     
	cell.textLabel.text = [_suggestList objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    if ([cell.textLabel.text isEqualToString:clearnHistoryList]) {
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor colorWithRed:48/255.0f green:112/255.0f blue:149/255.0f alpha:1.0];
        cell.accessoryView = nil;
        return cell;
    }
    else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    if([_textField.text isEqualToString:cell.textLabel.text]) {
        cell.accessoryView = nil;
    }
    else {
        UIImage *buttonUpImage = [UIImage imageNamed:@"changetext.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0, 0.0, buttonUpImage.size.width, buttonUpImage.size.height);
        [button setBackgroundImage:buttonUpImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeInputText:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.accessoryView = button;
    }
    
	return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        [_textField resignFirstResponder];
        self.searchBarButton =  [[[EtaoUIBarButtonItem alloc] initWithTitle:@"搜索"  bkColor:[UIColor whiteColor] target:self action:@selector(searchBarButtonClick:)]autorelease]; ;   
        _navItems.rightBarButtonItem = _searchBarButton;  
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([_suggestList count] > indexPath.row) {
		NSString *text = [_suggestList objectAtIndex:indexPath.row];
        
        //清除搜索历史
        if ([text isEqualToString:clearnHistoryList]) {
            [self clearnHistoryList];
            
            [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ClearnHistory"];
            return;
        }
        
		_textField.text = text;
		[self textFieldShouldReturn:_textField];
	}
      
	[_tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}



@end
