//
//  DataUtil.m
//  Rss
//
//  Created by TRINH Van Huy on 16/02/15.
//  Copyright (c) 2015 TRINH Van Huy. All rights reserved.
//

#import "DataUtil.h"
#import "UIKit/UIKit.h"
@implementation DataUtil
-(id)init {
    self = [super init];
    if (self) {
        id delegate = [[UIApplication sharedApplication] delegate];
        if([delegate performSelector:@selector(managedObjectModel)]) {
            context = [delegate managedObjectContext];
        }
    }
    return self;
}
-(NSMutableArray *)loadData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Entry"];
    return [[NSMutableArray alloc] initWithArray:[[context executeFetchRequest:fetchRequest error:nil] mutableCopy]];
}
-(void)saveData : (NSMutableArray *)data{
    [self deleteAll];
    for(Element * elem in data) {
        [self saveElement:elem];
    }
}
-(void)saveElement:(Element *)elem {
    NSManagedObject *failedBankInfo = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"Entry"
                                       inManagedObjectContext:context];
    [failedBankInfo setValue:elem.title forKey:@"title"];
    [failedBankInfo setValue:elem.desc forKey:@"desc"];
    [failedBankInfo setValue:elem.date forKey:@"date"];
    [failedBankInfo setValue:elem.link forKey:@"link"];
    [failedBankInfo setValue:elem.imageLink forKey:@"imageLink"];
    [failedBankInfo setValue:elem.imageData forKey:@"imageData"];
    NSError * error = nil;
    if(![context save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
}
-(void)deleteAll {
    NSFetchRequest * allCars = [[NSFetchRequest alloc] init];
    [allCars setEntity:[NSEntityDescription entityForName:@"Entry" inManagedObjectContext:context]];
    [allCars setIncludesPropertyValues:NO];
    NSError * error = nil;
    NSArray * cars = [context executeFetchRequest:allCars error:&error];
    for (NSManagedObject * car in cars) {
        [context deleteObject:car];
    }
    NSError *saveError = nil;
    [context save:&saveError];
}
@end
