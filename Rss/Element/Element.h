//
//  Element.h
//  Rss
//
//  Created by TRINH Van Huy on 15/02/15.
//  Copyright (c) 2015 TRINH Van Huy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@interface Element : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * imageLink;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSData * imageData;
-(id)initWith: (NSString *)_title Des:  (NSString* ) _description ImageLink: (NSString* ) _imageLink Link:  (NSString* ) _link Date:  (NSString* ) _date;
@end
