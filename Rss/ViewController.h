//
//  ViewController.h
//  Rss
//
//  Created by TRINH Van Huy on 14/02/15.
//  Copyright (c) 2015 TRINH Van Huy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"
#import "Element.h"
#import "DataUtil.h"
#import "CustomCell.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSURLConnectionDataDelegate>{
    NSString * linkRSS;
    NSMutableData * receiveData;
    TBXML * tbxml;
    NSMutableArray * arrayItem;
    __weak IBOutlet UITableView *mainTableView;
    UIRefreshControl * refreshControl;
    DataUtil * dataUtil;
}


@end

