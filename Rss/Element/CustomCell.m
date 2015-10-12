//
//  CustomCell.m
//  Rss
//
//  Created by TRINH Van Huy on 15/02/15.
//  Copyright (c) 2015 TRINH Van Huy. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
-(id)initWithElement:(Element *)elem {
    self = [super init];
    if(self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat cellWidth = screenRect.size.width;
        CGFloat cellHeight = screenRect.size.height * 0.2;
        CGFloat imageSize = screenRect.size.height * 0.17;
        CGFloat elementHeight = cellHeight /5;
        CGFloat elementWidth = cellWidth - imageSize - cellWidth * 0.01;

        [self setFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
        
        UILabel * lbDescription = [[UILabel alloc] initWithFrame:CGRectMake(imageSize, elementHeight, elementWidth, elementHeight * 3)];
        lbDescription.text = elem.desc;
        [lbDescription setFont:[UIFont fontWithName:@"TrebuchetMS-Italic" size:elementHeight / 2]];
        [lbDescription setTextColor:[UIColor darkGrayColor]];
        lbDescription.numberOfLines = 0;
        [self addSubview:lbDescription];
        
        UILabel * lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageSize, elementHeight /3, elementWidth, elementHeight)];
        lbTitle.text = elem.title;
        [lbTitle setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:elementHeight / 2]];
        [self addSubview:lbTitle];
       
        UILabel * lbDate = [[UILabel alloc] initWithFrame:CGRectMake(imageSize, elementHeight * 4 - elementHeight /3, elementWidth, elementHeight)];
        lbDate.text = elem.date;
        [lbDate setFont:[UIFont fontWithName:@"TrebuchetMS-Italic" size:elementHeight / 2]];
        [lbDate setTextColor:[UIColor lightGrayColor]];
        [self addSubview:lbDate];
        
        
        UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageWithData:elem.imageData]];
        image.layer.cornerRadius = 5;
        image.layer.masksToBounds = YES;
        [image setFrame:CGRectMake(elementHeight /3, elementHeight * (1.0 - 0.3), imageSize - elementHeight /1.5, imageSize - elementHeight /1.5)];
        [self addSubview:image];
        
    }
    return self;
}
-(void)styleFor:(BOOL) isOdd {
    if(isOdd) {
        [self setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    }
}
@end
