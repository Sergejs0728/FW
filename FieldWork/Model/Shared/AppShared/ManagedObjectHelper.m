//
//  ManagedObjectHelper.m
//  FWModel
//
//  Created by SamirMAC on 11/21/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "ManagedObjectHelper.h"

#import "Appointment.h"
#import "MaterialUsage.h"
#import "LineItem.h"
#import "InspectionRecord.h"
#import "Material.h"
#import "Pest.h"
#import "CustomerDevice.h"

@implementation ManagedObjectHelper


+ (ManagedObjectHelper*) Instance {
    static ManagedObjectHelper *__sharedDataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedDataModel = [[ManagedObjectHelper alloc] init];
    });
    
    return __sharedDataModel;
}

- (instancetype)init{
    if (self = [super init]) {
        @autoreleasepool {
//            [[NSNotificationCenter defaultCenter] addObserver: self
//                                                     selector: @selector(objectContextWillSave:)
//                                                         name: NSManagedObjectContextWillSaveNotification
//                                                       object: nil];
        }
    }
    return self;
}

- (void)objectContextWillSave:(NSNotification *)notification {
    
//    NSArray *watched_classes = @[[Appointment class], [MaterialUsage class], [LineItem class], [InspectionRecord class], [Material class], [Pest class], [CustomerDevice class]];
    
    NSManagedObjectContext* context = [notification object];
    NSSet *inserted_records = [context insertedObjects];
    
    for (NSManagedObject *record in inserted_records) {
        NSArray *properties = [[[record entity] attributesByName] allKeys];
        if ([properties containsObject:@"entity_status"]) {
            [record setValue:c_ADDED forKey:@"entity_status"];
        }
    }
    
    NSSet *updated_records = [context updatedObjects];
    for (NSManagedObject *record in updated_records) {
        NSArray *properties = [[[record entity] attributesByName] allKeys];
        if ([properties containsObject:@"entity_status"]) {
            [record setValue:c_ADDED forKey:@"entity_status"];
        }
    }

}


@end
