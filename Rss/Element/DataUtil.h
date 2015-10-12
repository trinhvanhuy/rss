//
//  DataUtil.h
//  Rss
//
//  Created by TRINH Van Huy on 16/02/15.
//  Copyright (c) 2015 TRINH Van Huy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Element.h"

@interface DataUtil : NSObject {
    NSManagedObjectContext *context;
}
-(NSMutableArray *)loadData;
-(void)saveData: (NSMutableArray *)data;
-(void)saveElement: (Element *)elem;
-(void)deleteAll;
@end
