//
//  Element.m
//  Rss
//
//  Created by TRINH Van Huy on 15/02/15.
//  Copyright (c) 2015 TRINH Van Huy. All rights reserved.
//

#import "Element.h"

@implementation Element
@synthesize title, desc, imageLink, link, date, imageData;
-(id)initWith: (NSString *)_title Des:  (NSString* ) _description ImageLink: (NSString* ) _imageLink Link:  (NSString* ) _link Date:  (NSString* ) _date{
    self = [super init];
    if (self) {
        self.title = _title;
        self.desc = _description;
        self.imageLink = _imageLink;
        self.link = _link;
        self.date = _date;
        self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageLink]];
    }
    return self;
}
@end
