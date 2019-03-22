#import "MaterialUsage.h"
#import "CDHelper.h"
#import "Appointment.h"
#import "NSDictionary+Extension.h"

@interface MaterialUsage ()

// Private interface goes here.

@end

@implementation MaterialUsage


+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[MaterialUsage entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[MaterialUsage class]];
    [mapping addAttributesFromDictionary:dict];
    
    [mapping addToManyRelationshipMapping:[MaterialUsageRecord defaultMapping] forProperty:@"material_usage_records" keyPath:@"material_usage_records"];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+(FEMMapping *)reverseMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[MaterialUsage entityName]];
    NSDictionary *appt_mapping_dict = @{@"material_id":@"material_id",
                                        @"entity_id":@"id"
                                        };
    
    [mapping addToManyRelationshipMapping:[MaterialUsageRecord reverseMapping] forProperty:@"material_usage_records" keyPath:@"material_usage_records_attributes"];
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    return mapping;
}

+ (MaterialUsage *)createWithMaterialId:(NSNumber *)material_id {
    MaterialUsage *usage = [MaterialUsage MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [usage setMaterial_id:material_id];
    [usage setEntity_id:[NSNumber numberWithInt:[Utils RandomId]]];
    [usage setEntity_status:c_ADDED];
    return usage;
}

+ (NSMutableArray *) buildJson:(NSSet*)records
{
    NSMutableArray *mat_array = [[NSMutableArray alloc] init];
    for (MaterialUsage *mat_usage in records) {
        if (![mat_usage.entity_status isEqualToNumber: c_UNCHANGED]) {
            NSMutableDictionary *mat_usage_json = [FEMSerializer serializeObject:mat_usage usingMapping:[MaterialUsage reverseMapping]].mutableCopy;
            if ([mat_usage.entity_status isEqualToNumber: c_ADDED]) {
                mat_usage_json = [mat_usage_json dictionaryByRemovingId].mutableCopy;
            } else if ([mat_usage.entity_status isEqualToNumber: c_DELETED]){
                mat_usage_json = [[NSDictionary alloc] initWithDestroy:mat_usage.entity_id].mutableCopy;
            } else {
                // Edited - Delete existing and add new one.
                mat_usage_json = [mat_usage_json dictionaryByRemovingId].mutableCopy;
                NSDictionary *delete_existing = [[NSDictionary alloc] initWithDestroy:mat_usage.entity_id];
                if (delete_existing) [mat_array addObject:delete_existing];
            }
            if (mat_usage_json) [mat_array addObject:mat_usage_json];
        }
    }
    return mat_array;
}

- (float)getTotalQty {
    float qty = 0;
    float total_qty = 0;
    NSMutableArray *selectedLocations = [[NSMutableArray alloc] init];
    NSMutableArray *tempUsage = [[self.material_usage_records allObjects] mutableCopy];
    for (MaterialUsageRecord *mr in tempUsage) {
        total_qty = qty = [mr.amount floatValue];
        if (mr && ![mr.location_area_id isEqualToNumber:[NSNumber numberWithInt:0]] && mr.location_area_id) {
            [selectedLocations addObject:mr.location_area_id];
        }
    }
    
    // Show the total qty of all locations.
    if (selectedLocations.count > 0) {
        total_qty  = qty * selectedLocations.count;
    }
    return total_qty;
}

- (void)discard {
    if ([self.managedObjectContext hasChanges]) {
        [self.managedObjectContext rollback];
        [self.managedObjectContext refreshObject:self mergeChanges:NO];
        NSLog(@"Discarded on entity %@", self.entity_id);
    }
    
}

- (void)saveMaterialUsage {
    if ([self.entity_status isEqualToNumber:c_UNCHANGED]) {
        [self setEntity_status:c_EDITED];
    }
    [self.appointment setEntity_status:c_EDITED];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
