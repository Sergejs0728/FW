//
//  CoreDataHelper.h
//  FieldWork
//
//  Created by Samir Kha on 18/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


@interface CoreDataHelper : NSObject
{
    
}

+ (CoreDataHelper*) Instance;

- (NSMutableArray*) fetchWithTable:(NSString*) tableName;
- (NSMutableArray*) fetchWithTable:(NSString*) tableName withPredicate:(NSPredicate*) predicate;
- (NSMutableArray *)fetchWithTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate andSortDescriptor:(NSSortDescriptor*)descriptor;
- (NSMutableArray *)fetchWithTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate andColumns:(NSMutableArray*)columns ;
- (id)fetchSingleWithTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate ;
- (int)countForTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate;
- (NSManagedObject*) newEntityWithTableName:(NSString*) tabelName;
- (BOOL) deleteFromData:(NSManagedObject*) obj;
- (void) saveContext;
- (BOOL) deleteAll:(NSString*) tableName;
- (BOOL)deleteAll:(NSString *)tableName withPredicate:(NSPredicate *)predicate;
- (BOOL) isExists:(NSString*) tableName predicate:(NSPredicate*) predicate;

@end
