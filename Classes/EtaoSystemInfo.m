//
//  EtaoSystemInfo.m
//  etao4iphone
//
//  Created by iTeam on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoSystemInfo.h"
#import "ASIHTTPRequest.h"
#import "UIDeviceHardware.h"


@implementation EtaoSystemInfo


@synthesize uuid ;
@synthesize sysdict ;
@synthesize version ;
@synthesize clt_act;
@synthesize userLocation ,userLocationDetail;


static EtaoSystemInfo* etaoSysInstance = nil;
static NSString *etaoSysPath = @"etao.ini";


- (id)init
{
	if ( (self = [super init]) )
    { 
		self.sysdict = [NSMutableDictionary dictionaryWithCapacity:10];
	 	uuid = [UIDevice currentDevice].uniqueIdentifier; 		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
		NSString *documentsDir = [paths objectAtIndex:0];
		NSString *fullPath = [documentsDir stringByAppendingPathComponent:etaoSysPath];
		NSDictionary *tmp = [NSDictionary dictionaryWithContentsOfFile:fullPath];
		if (tmp != nil){
			[self.sysdict setDictionary:tmp];
		}
		  
		NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
		self.version = [infoDict objectForKey:@"CFBundleVersion"];//版本号
		NSLog(@"%@",version);
		  		
	}
	return self;
}

- (void) dealloc
{ 
	[super dealloc];
}


- (BOOL) save {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	NSString *fullPath = [documentsDir stringByAppendingPathComponent:etaoSysPath];  
	return [self.sysdict writeToFile: fullPath  atomically:YES];	
	
}

- (void) setValue:(id)value forKey:(NSString *)key{
	if (sysdict != nil) {
		[self.sysdict setValue:value forKey:key];
	}
}

+ (EtaoSystemInfo*)sharedInstance{
	
	if ( nil == etaoSysInstance )
    {
        etaoSysInstance = [[EtaoSystemInfo alloc] init];
    }
	
    return  etaoSysInstance;
	
}


- (void)statUserAction:(NSString *)act {
    
    UIDevice *device = [UIDevice currentDevice];
    UIDeviceHardware *hdware = [[UIDeviceHardware alloc] init];
    NSString *osVer = [[NSString stringWithFormat:@"%@-%@@%@", device.systemName, device.systemVersion, [hdware platform]]
                       stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [hdware release];
    
    clt_act = act;
    NSString *url = [NSString stringWithFormat:@"http://m.taobao.com/syscheck.htm?ttid=%@&imei=%@&clt_act=%@&env=%@",
                     __TTID__,
                     [[UIDevice currentDevice].uniqueIdentifier stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                     act,
                     osVer];
    
    NSLog(@"Stat user action: %@", url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request startAsynchronous];
}


@end
