    //
//  CustomSearchBarController.m
//  etao4iphone
//
//  Created by iTeam on 11-9-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomSearchBarController.h"
#import "HttpRequest.h"
#import "NSString+QueryString.h"
#import "NSObject+SBJson.h"
 
@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
	UIImage *image = [UIImage imageNamed: @"etaoNavbar1.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

@implementation CustomSearchBarController

@synthesize _textField ;
@synthesize _searchCancelBtn; 
@synthesize _searchFieldButton;
@synthesize _searchButton ;

@synthesize _loadingSuggest ;
@synthesize _suggestList; 
@synthesize _tableView;  
//@synthesize historyList = _historyList;


static NSString *inputHistoryList = @"user_input_history_list";
static NSString *clearnHistoryList = @"清除搜索历史...";

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
 
 
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView]; 
	   
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 250.0f, 30.0f)];
	self._textField = textField;
	_textField.leftViewMode = UITextFieldViewModeAlways;  
	_textField.leftView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftsearch.png"]] autorelease]; 
	_textField.borderStyle = UITextBorderStyleRoundedRect;
	_textField.autocorrectionType = UITextAutocorrectionTypeNo;
	_textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_textField.returnKeyType = UIReturnKeySearch;
	_textField.clearButtonMode = UITextFieldViewModeWhileEditing; 
	_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	_textField.placeholder = @"搜索，比价，省钱"; 
    _textField.font = [UIFont systemFontOfSize:16];
	_textField.delegate = self;
	
	[textField release];

 	UIBarButtonItem *searchFieldButton = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleBordered target:self action:@selector(searchButtonTapped:)];
	self._searchFieldButton = searchFieldButton;
	[searchFieldButton release];
	 
	UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(270.0f, 7.0f, 45, 30)];	
	self._searchButton = searchButton;
	[searchButton release];
	
	self._searchButton.hidden = YES;
	[searchButton setTitle:@"比价" forState:UIControlStateNormal];
	searchButton.titleLabel.font = [UIFont systemFontOfSize: 14];  
	[searchButton setBackgroundImage:[UIImage imageNamed:@"EtaoSearchbutton.png"] forState:UIControlStateNormal];   
	[searchButton addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	
 	
	//定义搜索点击的时候，方便取消的效果
	_searchCancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_searchCancelBtn.frame = CGRectMake(0, 0, 320, 440); 
	_searchCancelBtn.backgroundColor = [UIColor blackColor]; 
	[_searchCancelBtn addTarget:self action:@selector(SearchMarkButtonClick) forControlEvents:UIControlEventTouchDown];
	_searchCancelBtn.hidden = YES;  
    
    
    self._loadingSuggest = NO;
	
	self._suggestList = [NSMutableArray arrayWithCapacity:20];
    
    UITableView * tablev = [[UITableView alloc] initWithFrame:CGRectMake(0, 44.0f, 320, 460) style:UITableViewStylePlain];
   
    self._tableView = tablev;
    self._tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self._tableView.autoresizesSubviews = YES;
	[tablev release]; 
	
	[self._tableView setDelegate:self];  
	[self._tableView setDataSource:self];
    
    [self.view addSubview:_searchCancelBtn];
    [self.view addSubview: self._tableView];
    [self.view addSubview:self._textField];
    
    //load History input list
    //self.historyList = [NSMutableArray arrayWithCapacity:20];
    [self._suggestList setArray:[[NSUserDefaults standardUserDefaults] arrayForKey:inputHistoryList]];
    if ([self._suggestList count] > 0) {
        [self._suggestList addObject:clearnHistoryList];
    }
}


//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
////	[self.navigationController setNavigationBarHidden:NO animated:YES];
//	[self textFieldShouldEndEditing:textField];
//	return YES;
//}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    //当输入长度为0时，显示历史
        //[self._suggestList setArray:self.historyList];
        [self._suggestList setArray:[[NSUserDefaults standardUserDefaults] arrayForKey:inputHistoryList]];
        if ([self._suggestList count] > 0) {
            [self._suggestList addObject:clearnHistoryList];
        }
        
        [self._tableView reloadData];
        return YES;
  }


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	
    //当输入长度为0时，显示历史
    NSMutableString *newValue = [[_textField.text mutableCopy] autorelease];
    [newValue replaceCharactersInRange:range withString:string];
    if ([newValue length]== 0) {
        //[self._suggestList setArray:self.historyList];
        [self._suggestList setArray:[[NSUserDefaults standardUserDefaults] arrayForKey:inputHistoryList]];
        if ([self._suggestList count] > 0) {
            [self._suggestList addObject:clearnHistoryList];
        }
        
        [self._tableView reloadData];
        return YES;
    }
    
    if (self._loadingSuggest == YES) {
		return YES;
	}  
    
	[self unmark]; 
	self._tableView.hidden = NO;
	
    // add
	if (range.length == 0) {
		[self loadSuggest:[NSString stringWithFormat:@"%@%@",textField.text,string]];
	}
	else { 
		NSRange r = {0,range.location};
		[self loadSuggest:[textField.text substringWithRange:r]]; 
	}
	
	NSLog(@"searchword=%@,%@,%d,%d",textField.text,string,range.length,range.location); 
        
	return YES;
}


- (void) mark { 	
	if (_searchCancelBtn.alpha == 0.6) {
		return ;
	}
	_searchCancelBtn.hidden = NO;
 	_searchCancelBtn.alpha = 0.0; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	_searchCancelBtn.alpha = 0.6;
	[UIView commitAnimations];
}


- (void) unmark { 
	if (_searchCancelBtn.alpha == 0.0) {
		return ;
	}
 	_searchCancelBtn.alpha = 0.6; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	_searchCancelBtn.alpha = 0.0;
	[UIView commitAnimations];
	_searchCancelBtn.hidden = NO;  
}


- (void)SearchMarkButtonClick{
	[self unmark];
	[_textField resignFirstResponder]; 
	_searchFieldButton.title = @"搜索"; 
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


- (void) searchButtonPressed:(id)sender {  
	if ([sender isKindOfClass:[UIButton class]] ) {
		UIButton *btn = (UIButton*)sender; 
		if ([ btn.titleLabel.text isEqualToString:@"取消"]) {
			[self textFieldShouldEndEditing:self._textField];
			[self._searchButton setTitle:@"比价" forState:UIControlStateNormal];
        }
	} 
}


- (void)clearnHistoryList {
    NSMutableArray* historyList = [NSMutableArray arrayWithCapacity:20];
    [[NSUserDefaults standardUserDefaults] setObject:historyList forKey:inputHistoryList];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self._suggestList setArray:historyList];
    [_tableView reloadData];
}


- (void)searchButtonTapped:(id)sender{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		UIBarButtonItem *btn = (UIBarButtonItem*)sender;
		if ([btn.title isEqualToString:@"取消"]) { 
			btn.title = @"搜索";
			[_textField resignFirstResponder];
			[self unmark];
         } 
	} 
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self mark];
	_searchFieldButton.title = @"取消"; 
	[self._searchButton setTitle:@"取消" forState:UIControlStateNormal];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
	[_textField resignFirstResponder]; 
	[self._searchButton setTitle:@"比价" forState:UIControlStateNormal];
	[self unmark];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
 	[_textField resignFirstResponder]; 
	[self._searchButton setTitle:@"比价" forState:UIControlStateNormal];
	[self unmark];
	return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
	[self unmark];
	[self._searchButton setTitle:@"比价" forState:UIControlStateNormal];
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
        [self._suggestList removeAllObjects]; 
        for (NSArray *v in result) {
            NSLog(@"%@",[v objectAtIndex:0]);
            [self._suggestList addObject:[v objectAtIndex:0]];
        }  
        
        //去除重复的
        [self._suggestList removeObject:_textField.text];
        [self._suggestList insertObject:_textField.text atIndex:0];
        
        [self._tableView reloadData];
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
	NSLog(@"%d",[self._suggestList count]);
	return [self._suggestList count] ;
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
        
        self._tableView.hidden = NO;

        [self loadSuggest:_textField.text]; 
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell * cell = (UITableViewCell*)[self._tableView dequeueReusableCellWithIdentifier:@"cell"];
	
    if (cell == nil) {
		cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
	} 
    
	NSLog(@"%@",[self._suggestList objectAtIndex:[indexPath row]]);
	cell.textLabel.text = [self._suggestList objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    if ([cell.textLabel.text isEqualToString:clearnHistoryList]) {
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor colorWithRed:87/255.0f green:119/255.0f blue:158/255.0f alpha:1.0];
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
        //[self._searchButton setTitle:@"比价" forState:UIControlStateNormal];
    }
}


#pragma mark -
#pragma mark Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
// 	
//	if ([self._suggestList count] > indexPath.row) {
//		NSString *text = [self._suggestList objectAtIndex:indexPath.row]; 
//		[self doSearch:text]; 
//		[self._suggestList removeAllObjects];
//		[self._tableView reloadData];  
//		self._tableView.hidden = YES; 
//	}
//	[self._tableView deselectRowAtIndexPath:indexPath animated:YES]; 
//	
//}


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
	[self._tableView deselectRowAtIndexPath:indexPath animated:YES]; 	
}


- (void) requestFailed:(HttpRequest*)sender{ 
	
	self._loadingSuggest = NO;
}

 
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
//	_textField = nil;
//	_searchCancelBtn = nil ; 
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc { 
	[_searchCancelBtn release];
	[_textField release];
    [super dealloc];
}


@end
