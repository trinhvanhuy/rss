//
//  CustomCell.h
//  Rss
//
//  Created by TRINH Van Huy on 15/02/15.
//  Copyright (c) 2015 TRINH Van Huy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"
@interface CustomCell : UITableViewCell
-(id)initWithElement: (Element *) elem;
@property (nonatomic, strong) Element * currentElement;
-(void)styleFor:(BOOL) isOdd;
@end
