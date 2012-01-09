//
//  EtaoPropertyCell.m
//  etao4iphone
//
//  Created by iTeam on 11-9-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoPropertyCell.h"


@implementation EtaoPropertyCell
@synthesize _pid,_vid,_parent,_pidvid;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code. 
	}
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated { 
    [super setSelected:selected animated:animated];
	if (self.selectionStyle == UITableViewCellSelectionStyleNone) {
		return ;
	}
 	if ( selected ) { 		
		if (self.accessoryView == nil) { 
			_pidvid._select = YES;
			[_parent._pidvid setObject:_pid forKey:[NSString stringWithFormat:@"%@:%@",_pid,_vid]];
			[_parent._tableView reloadData];
		}
		else {
			_pidvid._select = NO;
			[_parent._pidvid removeObjectForKey:[NSString stringWithFormat:@"%@:%@",_pid,_vid]];
			[_parent._tableView reloadData];
		} 
	} 
 
    // Configure the view for the selected state.
}

- (void) setPid:(EtaoPidVidItem*)pid Vid:(EtaoPidVidItem*)vid{
	if (vid.head == YES) {
		self.textLabel.text = vid.name;
		self.textLabel.textColor =  [UIColor blackColor];
		self.backgroundColor =  [UIColor colorWithRed:237/255.0f green:238/255.0f blue:240/255.0f alpha:1.0];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	else {
		self.backgroundColor = [UIColor whiteColor]; 
		self._pid = pid.key;
		self._vid = vid.key;
		self._pidvid = vid;
		self.textLabel.text =  vid.name; 
		self.textLabel.textColor =  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
		
		self.backgroundColor = [UIColor whiteColor];
		
		if (vid._select) {
			UIImageView *imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hook.png"]];
			self.accessoryView = imagev;
			[imagev release];
			self.backgroundColor = [UIColor colorWithRed:0.9921 green:0.9215 blue:0.8252 alpha:1.0];  
			
			_pidvid._select = YES;
			[_parent._pidvid setObject:_pid forKey:[NSString stringWithFormat:@"%@:%@",_pid,_vid]];
			
		}
		else {
			self.accessoryView = nil;
			self.backgroundColor = [UIColor whiteColor];
		} 
	} 
}
- (void)dealloc {
    [super dealloc];
}


@end

@implementation EtaoCategoryCell
@synthesize _parent,_item;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
	if ( selected ) 
	{  
		_parent._catid = _item.key;  
		
        EtaoSRPController  * srpController = nil;
        for (UIViewController *c  in _parent.navigationController.viewControllers) {
            if ( [c isKindOfClass:[EtaoSRPController class]]) {
                srpController = (EtaoSRPController*) c;
            }
        } 
		[srpController searchWord:_parent._keyword cat:_parent._catid ppath:_parent._ppath];
		[_parent.navigationController popToViewController:srpController animated:YES];
		
		//EtaoCategoryNavController * catNavController = [[[EtaoCategoryNavController alloc] initWithWord:_parent._keyword cat:_parent._catid pidvid:@"" ]autorelease];
		//[_parent.navigationController pushViewController:catNavController animated:YES];
	} 
}

- (void) setCat:(EtaoCategoryItem*)cat{
	self._item = cat ; 
	if ( _item.head ) {
		self.textLabel.text = _item.name;
		self.textLabel.textColor =  [UIColor blackColor];
		self.backgroundColor =  [UIColor colorWithRed:237/255.0f green:238/255.0f blue:240/255.0f alpha:1.0];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		return ;
	}
	NSMutableString * showtext = [NSMutableString stringWithFormat:@""]; 
	if (_item.catlevel == 1 ) {
		self.imageView.image = [UIImage imageNamed:@"list_01.png"];
	}
	if (_item.catlevel == 2 ) {
		self.imageView.image = [UIImage imageNamed:@"list_02.png"];
	}
	if (_item.catlevel == 3 ) {
		self.imageView.image = [UIImage imageNamed:@"list_03.png"];
	} 
	
	[showtext appendString:_item.name];
	self.textLabel.text = showtext;
	
}

- (void)dealloc {
    [super dealloc];
}


@end

@implementation EtaoBreadcrumbCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		self.textLabel.numberOfLines = 3 ;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
	if ( selected ) 
	{ 
		
	}
    // Configure the view for the selected state.
}

- (void) setPath:(NSArray*)path{
	NSMutableString * catpath = [NSMutableString stringWithFormat:@"全部分类"];
	for ( EtaoCategoryItem *s in path) {
		[catpath appendFormat:@" > %@",s.name];
	}
	self.textLabel.text = catpath;
	
}

- (void)dealloc {
    [super dealloc];
}


@end
