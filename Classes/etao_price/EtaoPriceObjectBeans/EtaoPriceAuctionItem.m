//
//  ETaoPriceAuctionItem.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceAuctionItem.h"

@implementation EtaoPriceAuctionItem

@synthesize  catIdPath = _catIdPath;
@synthesize  category = _category; 
@synthesize  categoryp = _categoryp;    
@synthesize  comUrl = _comUrl;
@synthesize  epid = _epid; 
@synthesize  image = _image; 
@synthesize  link = _link;
@synthesize  logo = _logo; 
@synthesize  lowestPrice = _lowestPrice;    
@synthesize  nickName = _nickName;
@synthesize  nid = _nid; 
@synthesize  priceCutratio = _priceCutratio; 
@synthesize  priceHistory = _priceHistory;
@synthesize  priceMtime = _priceMtime; 
@synthesize  priceType = _priceType;    
@synthesize  productPrice = _productPrice;
@synthesize  sellerType = _sellerType; 
@synthesize  siteName = _siteName; 
@synthesize  smallLogo = _smallLogo;
@synthesize  tagLogo = _tagLogo; 
@synthesize  title = _title;
@synthesize  wapLink = _wapLink;


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self){
        self.catIdPath = [aDecoder decodeObjectForKey:@"catIdPath"];
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.categoryp = [aDecoder decodeObjectForKey:@"categoryp"];
        self.comUrl = [aDecoder decodeObjectForKey:@"comUrl"];
        self.epid = [aDecoder decodeObjectForKey:@"epid"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.link = [aDecoder decodeObjectForKey:@"link"];
        self.logo = [aDecoder decodeObjectForKey:@"logo"];
        self.lowestPrice = [aDecoder decodeObjectForKey:@"lowestPrice"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.nid = [aDecoder decodeObjectForKey:@"nid"];
        self.priceCutratio = [aDecoder decodeObjectForKey:@"priceCutratio"];
        self.priceHistory = [aDecoder decodeObjectForKey:@"priceHistory"];
        self.priceMtime = [aDecoder decodeObjectForKey:@"priceMtime"];
        self.priceType = [aDecoder decodeObjectForKey:@"priceType"];
        self.productPrice = [aDecoder decodeObjectForKey:@"productPrice"];
        self.sellerType = [aDecoder decodeObjectForKey:@"sellerType"];
        self.siteName = [aDecoder decodeObjectForKey:@"siteName"];
        self.smallLogo = [aDecoder decodeObjectForKey:@"smallLogo"];
        self.tagLogo = [aDecoder decodeObjectForKey:@"tagLogo"];        
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.wapLink = [aDecoder decodeObjectForKey:@"wapLink"];               
                 
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_catIdPath forKey:@"catIdPath"];
    [aCoder encodeObject:_category forKey:@"category"];
    [aCoder encodeObject:_categoryp  forKey:@"categoryp "];
    [aCoder encodeObject:_comUrl forKey:@"comUrl"];
    [aCoder encodeObject:_epid forKey:@"epid"];
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeObject:_link forKey:@"link"];
    [aCoder encodeObject:_logo forKey:@"logo"];
    [aCoder encodeObject:_lowestPrice forKey:@"lowestPrice"];
    [aCoder encodeObject:_nickName forKey:@"nickName"];
    [aCoder encodeObject:_nid forKey:@"nid"];
    [aCoder encodeObject:_priceCutratio forKey:@"priceCutratio"];
    [aCoder encodeObject:_priceHistory forKey:@"priceHistory"];
    [aCoder encodeObject:_priceMtime forKey:@"priceMtime"];
    [aCoder encodeObject:_priceType forKey:@"priceType"];
    [aCoder encodeObject:_productPrice forKey:@"productPrice"];   
    [aCoder encodeObject:_sellerType forKey:@"sellerType"];
    [aCoder encodeObject:_siteName forKey:@"siteName"];
    [aCoder encodeObject:_smallLogo forKey:@"smallLogo"];
    [aCoder encodeObject:_tagLogo forKey:@"tagLogo"];
    [aCoder encodeObject:_title forKey:@"title"];     
    [aCoder encodeObject:_wapLink forKey:@"wapLink"];      
}

- (void)dealloc
{
    [_catIdPath release];
    [_category release];
    [_categoryp release];    
    [_comUrl release];
    [_epid release];
    [_image release]; 
    [_link release];
    [_logo release];
    [_lowestPrice release];    
    [_nickName release];
    [_nid release];
    [_priceCutratio release]; 
    [_priceHistory release];
    [_priceMtime release];
    [_priceType release];  
    [_productPrice release];
    [_sellerType release]; 
    [_siteName release];
    [_smallLogo release];
    [_tagLogo release]; 
    [_title release];
    [_wapLink release];
    [super dealloc];
}

- (NSString*)key{
    return [NSString stringWithFormat:@"%d",[self hash]];
}


@end
