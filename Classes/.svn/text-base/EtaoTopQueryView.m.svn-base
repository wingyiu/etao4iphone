//
//  EtaoTopQueryView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoTopQueryView.h"
#import "EtaoShowAlert.h"
#import "EtaoQueryView.h"
#import "NSObject+SBJson.h" 
#import "EtaoSystemInfo.h"
#import "NSString+QueryString.h"
#import "ActivityIndicatorMessageView.h"

#import <QuartzCore/QuartzCore.h>
@implementation EtaoTopQueryView

@synthesize delegate,action;
@synthesize _queryView;
@synthesize _topQueryArray ;
@synthesize _queryType ;
@synthesize _idx ;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		_idx = 0 ;
        // Initialization code.
		UIImageView *head = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"EtaoHomeTopQueryViewHead.png"]];
	 	[self addSubview:head];	
		[head release];
		
		EtaoQueryView *v = [[EtaoQueryView alloc]initWithFrame:CGRectMake(0, 40.0f, 300,172)];
		self._queryView = v ; 
	 	[v release];
		
		self._topQueryArray = [NSMutableArray arrayWithCapacity:10];
		
//		NSDictionary *data = [NSDictionary dictionaryWithObject:@"rgn.mobile.decider.client" forKey:@"route"];
//		NSString *url = [NSString stringWithFormat:@"http://wap.taobao.com/rest/api2.do?api=com.taobao.client.getTms&type=tms&v=*&data=%@",[data JSONRepresentation]];
	/*
		NSString *url = [NSString stringWithFormat:@"http://wap.taobao.com/channel/rgn/mobile/decider/client.html"];
		HttpRequest *httpquery = [[[HttpRequest alloc]init]autorelease];  
		httpquery.delegate = self;
		httpquery.requestDidFinishSelector = @selector(requestFinished:);
		httpquery.requestDidFailedSelector = @selector(requestFailed:); 
	 	[httpquery load:url]; */ 

		[self addSubview:self._queryView];
		
		EtaoQueryTypeView *t = [[EtaoQueryTypeView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300,40)];
		self._queryType = t ;
		[self addSubview:t];
		[t release];
		
		UIButton *btn = [[[UIButton alloc] initWithFrame:CGRectMake(0,0,80, 40)]autorelease]; 
		[btn setBackgroundImage:[UIImage imageNamed:@"EtaoQueryTypeLeft.png"] forState:UIControlStateHighlighted];
		btn.tag = 0 ;
		[btn addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

		UIButton *btn1 = [[[UIButton alloc] initWithFrame:CGRectMake(220,0,80, 40)]autorelease]; 
		btn1.tag = 1 ;
		[btn1 setBackgroundImage:[UIImage imageNamed:@"EtaoQueryTypeRight.png"] forState:UIControlStateHighlighted];
		[btn1 addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

		[self addSubview:btn];
		[self addSubview:btn1];
		
		/*
		UIActivityIndicatorView *activityIndicator =  [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
		activityIndicator.frame = CGRectMake(self.frame.size.width /2 -15 , self.frame.size.height * 0.33, 30.0f, 30.0f);
		activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		[self addSubview:activityIndicator];
		[activityIndicator startAnimating];
		*/
		NSLog(@"%@",[self subviews]);
		
    } 
    return self;
}

- (NSMutableArray*) getNext{ 	
	NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:3];
	int idx = _idx - 1;
	for ( int i = 0 ; i < 3 ; i++ ){
		if (idx < 0) {
			NSDictionary *dict = [self._topQueryArray lastObject];
			[tmp addObject:[dict objectForKey:@"name"]];
			idx += 1 ;
		}
		else if (idx == [self._topQueryArray  count] ){
			idx = 0 ;
			NSDictionary *dict = [self._topQueryArray objectAtIndex:0];
			[tmp addObject:[dict objectForKey:@"name"]];
			idx += 1 ;
		}else {
			NSDictionary *dict = [self._topQueryArray objectAtIndex:idx];
			[tmp addObject:[dict objectForKey:@"name"]];
			
			idx +=1 ;
		} 
	}
	for (NSString *s in tmp) {
		NSLog(@"%@",s);
	}
	return tmp;
	
}
- (void) downButtonPressed:(id)sender
{ 	 
	if ([self._topQueryArray count] == 0) {
		return ;
	}
	if ([sender isKindOfClass:[UIButton class]]) {
		UIButton *btn = (UIButton*)sender;
		if ( btn.tag == 0 ) {
			_idx -= 1 ;
			if (_idx  < 0 ) {
				_idx =  [self._topQueryArray count] - 1  ;
			}
			[self._queryView setView:[self._topQueryArray objectAtIndex:_idx] left:NO];
			
			[self._queryType set:[self getNext] animated:YES left:NO];
		}
		else {
			_idx += 1 ;
			if (_idx >= [self._topQueryArray count] ) {
				_idx = 0  ;
			}
			[self._queryView setView:[self._topQueryArray objectAtIndex:_idx] left:YES];
			[self._queryType set:[self getNext] animated:YES left:YES];
		} 
		
	}
//	if (self.delegate && self.action && [delegate respondsToSelector:self.action]) {
//		[delegate performSelectorOnMainThread:self.action withObject:sender waitUntilDone:YES];
//	}
}

- (void) setInfo:(NSString*)jsonContent{
	
    NSDictionary *json = [jsonContent JSONValue]; 
	
	NSArray *queryArray = [json objectForKey:@"items"];
 		
	for (NSDictionary *dict in queryArray) {
		[self._topQueryArray addObject:dict];
	} 
	
	[self._queryView setView:[self._topQueryArray objectAtIndex:_idx] left:YES];
	NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:3];
	int idx = _idx - 1;
	for ( int i = 0 ; i < 3 ; i++ ){
		if (idx < 0) {
			NSDictionary *dict = [self._topQueryArray lastObject];
			[tmp addObject:[dict objectForKey:@"name"]];
			idx += 1 ;
		}
		else if (idx == [self._topQueryArray  count] ){
			idx = 0 ;
			NSDictionary *dict = [self._topQueryArray objectAtIndex:0];
			[tmp addObject:[dict objectForKey:@"name"]];
			idx += 1 ;
		}else {
			NSDictionary *dict = [self._topQueryArray objectAtIndex:idx];
			[tmp addObject:[dict objectForKey:@"name"]];
			
			idx +=1 ;
		} 
	}
	[self._queryType setView:tmp ];  
}

- (void) requestFinished:(HttpRequest*)sender { 
	NSLog(@"%@",[self subviews]);
	for (UIView *v in [self subviews] ) {
		if ([v isKindOfClass:[UIActivityIndicatorView class]]) {
			UIActivityIndicatorView * activityIndicator = (UIActivityIndicatorView*)v;
			[activityIndicator stopAnimating];
			[activityIndicator removeFromSuperview];

		}
	}
			 
 	HttpRequest * request = (HttpRequest *)sender;  
 	NSString *ncontent = [request.jsonString stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\""];
 	
	EtaoSystemInfo *etaoSystem = [EtaoSystemInfo sharedInstance];
	[etaoSystem setValue:ncontent forKey:@"TopQueryAtHomePage_Json"];
	[etaoSystem save]; 
 	[self setInfo:ncontent]; 
	
}


- (void) requestFailed:(HttpRequest*)sender{ 
	for (UIView *v in [self subviews] ) {
		if ([v isKindOfClass:[UIActivityIndicatorView class]]) {
			UIActivityIndicatorView * activityIndicator = (UIActivityIndicatorView*)v;
			[activityIndicator stopAnimating];
			[activityIndicator removeFromSuperview];
			
		}
	}
			 
	//[EtaoShowAlert showAlert];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"网络不可用" message:@"无法与服务器通信，请连接到移动数据网络或者wifi." delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]autorelease];[alert show]; 
	
	EtaoSystemInfo *etaoSystem = [EtaoSystemInfo sharedInstance];
	
	NSString *jsonContent = [etaoSystem.sysdict objectForKey:@"TopQueryAtHomePage_Json"];
	if (jsonContent != nil) {
		[self setInfo:jsonContent];
	}
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[_queryView release];
	[_topQueryArray release]; 
	[_queryType release]; 
    [super dealloc];
}


@end
