//
//  CoreDataHelper.m
//  FieldWork
//
//  Created by Samir Kha on 18/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

//https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/CoreData/Articles/cdFetching.html

#import "CoreDataHelper.h"

static CoreDataHelper *Singlton = nil;

@interface CoreDataHelper()
{
    NSTimer *_savingTimer;
}

@property (nonatomic, retain, readwrite) NSTimer *savingTimer;

- (void) savePrivate;

@end

@implementation CoreDataHelper

@synthesize savingTimer = _savingTimer;

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

+ (CoreDataHelper*) Instance
{
    if(Singlton == nil){
        Singlton = [[CoreDataHelper alloc] init];   
    }
    return Singlton; 
    
}

- (NSMutableArray *)fetchWithTable:(NSString *)tableName {
    return [self fetchWithTable:tableName withPredicate:nil];
}

- (NSMutableArray *)fetchWithTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate {
    
    Class cls = NSClassFromString(tableName);
    
    if (predicate == nil) {
        return [[cls MR_findAll] mutableCopy];
    }else{
        return [[cls MR_findAllWithPredicate:predicate] mutableCopy];
    }
    
    
//    NSMutableArray * __autoreleasing mutableFetchResults = [[NSMutableArray alloc] init];
//    @try {
//        NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:[AppDelegate appDelegate].managedObjectContext];
//        
//        // Setup the fetch request
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:entity];
//        if (predicate) {
//            [request setPredicate:predicate];
//        }
//        
//        @synchronized([[AppDelegate appDelegate] persistentStoreCoordinator]){
//            mutableFetchResults = [[[AppDelegate appDelegate].managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
//        }
//        
//        
//    }
//    @catch (NSException *exception) {
//        
//    }
//    @finally {
//        return mutableFetchResults;
//    }
//   
//    return mutableFetchResults;
}

- (NSMutableArray *)fetchWithTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate andSortDescriptor:(NSSortDescriptor*)descriptor {
    
    Class cls = NSClassFromString(tableName);
    
    NSFetchRequest *fetchRequest = [cls MR_requestAll];
    
    if (predicate) {
        fetchRequest = [cls MR_requestAllWithPredicate:predicate];
    }
    if (descriptor) {
        [fetchRequest setSortDescriptors:@[descriptor]];
    }
    
    return [[cls MR_executeFetchRequest:fetchRequest] mutableCopy];
    
    
    
//    NSMutableArray * __autoreleasing mutableFetchResults = [[NSMutableArray alloc] init];
//    @try {
//        NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:[AppDelegate appDelegate].managedObjectContext];
//        
//        // Setup the fetch request
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:entity];
//        if (predicate) {
//            [request setPredicate:predicate];
//        }
//        if (descriptor) {
//            [request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
//        }
//        
//        @synchronized([[AppDelegate appDelegate] persistentStoreCoordinator]){
//            mutableFetchResults = [[[AppDelegate appDelegate].managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
//        }
//        
//        
//    }
//    @catch (NSException *exception) {
//        
//    }
//    @finally {
//        return mutableFetchResults;
//    }
//    
//    return mutableFetchResults;
}

- (NSMutableArray *)fetchWithTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate andColumns:(NSMutableArray*)columns {
    
    Class cls = NSClassFromString(tableName);
    
    NSFetchRequest *fetchRequest = [cls MR_requestAll];
    
    if (predicate) {
        fetchRequest = [cls MR_requestAllWithPredicate:predicate];
    }
    if (columns && columns.count > 0) {
        [fetchRequest setPropertiesToFetch:columns];
    }
    
    return [[cls MR_executeFetchRequest:fetchRequest] mutableCopy];

    
//    NSMutableArray * __autoreleasing mutableFetchResults = [[NSMutableArray alloc] init];
//    @try {
//        NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:[AppDelegate appDelegate].managedObjectContext];
//        
//        // Setup the fetch request
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:entity];
//        if (predicate) {
//            [request setPredicate:predicate];
//        }
//        if (columns && columns.count > 0) {
//            [request setPropertiesToFetch:columns];
//        }
//        
//        @synchronized([[AppDelegate appDelegate] persistentStoreCoordinator]){
//            mutableFetchResults = [[[AppDelegate appDelegate].managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
//        }
//        
//        
//    }
//    @catch (NSException *exception) {
//
//    }
//    @finally {
//        return mutableFetchResults;
//    }
//    
//    return mutableFetchResults;
}

- (id)fetchSingleWithTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate {
    
    
    Class cls = NSClassFromString(tableName);
    
    if (predicate == nil) {
        return [cls MR_findFirst];
    }else{
        return [cls MR_findFirstWithPredicate:predicate];
    }
    
//    NSMutableArray * __autoreleasing mutableFetchResults = [[NSMutableArray alloc] init];
//    @try {
//        NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:[AppDelegate appDelegate].managedObjectContext];
//        
//        // Setup the fetch request
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:entity];
//        if (predicate) {
//            [request setPredicate:predicate];
//        }
//        
//        @synchronized([[AppDelegate appDelegate] persistentStoreCoordinator]){
//            mutableFetchResults = [[[AppDelegate appDelegate].managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
//        }
//        if (mutableFetchResults && mutableFetchResults.count > 0) {
//            return [mutableFetchResults objectAtIndex:0];
//        }
//        
//    }
//    @catch (NSException *exception) {
//        DLog(@"Exception : fetchSingleWithTable : %@", exception);
//    }
//    @finally {
//        
//    }
//    
//    return nil;
}

- (int)countForTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate {
    
    Class cls = NSClassFromString(tableName);
    
    if (predicate) {
        return [[cls MR_numberOfEntitiesWithPredicate:predicate] intValue];
    }else{
        return [[cls MR_numberOfEntities] intValue];
    }
    
    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:[AppDelegate appDelegate].managedObjectContext];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entity];
//    if (predicate) {
//        [request setPredicate:predicate];
//    }
//    
//    int count = (int)[[AppDelegate appDelegate].managedObjectContext countForFetchRequest:request error:nil];
//    
//    return count;
}

- (BOOL)isExists:(NSString *)tableName predicate:(NSPredicate *)predicate {
    int cnt = [self countForTable:tableName withPredicate:predicate];
    if (cnt > 0) {
        return YES;
    }
    return NO;
}

- (NSManagedObject *)newEntityWithTableName:(NSString *)tabelName{
    
    Class cls = NSClassFromString(tabelName);
    return [cls MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    
//    return [NSEntityDescription insertNewObjectForEntityForName:tabelName inManagedObjectContext:[AppDelegate appDelegate].managedObjectContext];
}

- (BOOL)deleteFromData:(NSManagedObject *)obj {
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [obj MR_deleteEntityInContext:localContext];
    }];
    [self saveContext];
    return YES;
    
    
//    [[AppDelegate appDelegate].managedObjectContext deleteObject:obj];
//    NSError *error;
//    [[AppDelegate appDelegate].managedObjectContext save:&error];
//    if (error) {
//        return NO;
//    }
//    return YES;
}

- (void)saveContext {
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
//    if (_savingTimer == nil) {
//        //DLog(@"Timer Set");
//        NSTimeInterval time = 0.1;
//        //_savingTimer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(savePrivate) userInfo:nil repeats:NO];
//    }
//    [[AppDelegate appDelegate] saveContext];
}

- (void)savePrivate {
        // DLog(@"Timer Called");
    
    
    if (_savingTimer) {
        [_savingTimer invalidate];
        _savingTimer = nil;
    }
}

- (BOOL)deleteAll:(NSString *)tableName {
    
    Class cls = NSClassFromString(tableName);
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [cls MR_truncateAll];
    }];
    [self saveContext];
    return YES;
    
//    NSMutableArray *arr = [self fetchWithTable:tableName];
//    if (arr) {
//        for (NSManagedObject *obj in arr) {
//            
//            [[AppDelegate appDelegate].managedObjectContext deleteObject:obj];
//        }
//        
//        NSError *error;
//        if (![[AppDelegate appDelegate].managedObjectContext save:&error]) {
//            NSLog(@"Error deleting %@ - error:%@",tableName,error);
//            return NO;
//        }
//        return YES;
//    }
//    return NO;
}

- (BOOL)deleteAll:(NSString *)tableName withPredicate:(NSPredicate *)predicate{
    
    //MR_deleteAllMatchingPredicate
    
    Class cls = NSClassFromString(tableName);
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [cls MR_deleteAllMatchingPredicate:predicate];
    }];
    [self saveContext];
    return YES;
    
//    NSMutableArray *arr = [self fetchWithTable:tableName withPredicate:predicate];
//    if (arr) {
//        for (NSManagedObject *obj in arr) {
//            
//            [[AppDelegate appDelegate].managedObjectContext deleteObject:obj];
//        }
//        
//        NSError *error;
//        if (![[AppDelegate appDelegate].managedObjectContext save:&error]) {
//            NSLog(@"Error deleting %@ - error:%@",tableName,error);
//            return NO;
//        }
//        return YES;
//    }
//    return NO;
}

@end
