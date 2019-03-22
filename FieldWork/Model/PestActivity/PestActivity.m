#import "PestActivity.h"
#import "NSManagedObject+Mapping.h"
#import "NSDictionary+Extension.h"

@interface PestActivity ()

// Private interface goes here.

@end

@implementation PestActivity

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[PestActivity entityName]];
    [mapping addAttribute:[PestActivity intAttributeFor:@"activity_level_id" andKeyPath:@"activity_level_id"]];
    [mapping addAttribute:[PestActivity intAttributeFor:@"pest_type_id" andKeyPath:@"pest_type_id"]];
    [mapping addAttribute:[PestActivity intAttributeFor:@"unit_record_id" andKeyPath:@"unit_record_id"]];
    [mapping addAttribute:[PestActivity dateTimeGMT0AttributeFor:@"updated_at" andKeyPath:@"updated_at"]];
    [mapping addAttribute:[PestActivity dateTimeGMT0AttributeFor:@"created_at" andKeyPath:@"created_at"]];
    [mapping addAttribute:[PestActivity intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (FEMMapping *)reverseMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[PestActivity entityName]];
    NSDictionary *appt_mapping_dict = @{@"pest_type_id":@"pest_type_id",
                                        @"activity_level_id":@"activity_level_id",
                                        @"unit_record_id":@"unit_record_id"
                                        };
    
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    return mapping;
}

+ (PestActivity *)newPestActivityWithPestId:(NSNumber*)pestId unitRecordId:(NSNumber*)unitRecordId {
    PestActivity *record = [PestActivity MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    record.entity_id = @([Utils RandomId]);
    record.entity_status = c_ADDED;
    record.pest_type_id = pestId;
    record.unit_record_id = unitRecordId;
    return record;
}

- (Pest*) getPest
{
    return [Pest MR_findFirstByAttribute:@"entity_id" withValue:self.pest_type_id];
}

- (ActivityLevel*) getActivityLevel
{
    return [ActivityLevel MR_findFirstByAttribute:@"entity_id" withValue:self.activity_level_id];
}

- (NSMutableDictionary*)buildJson {
    if (![self.entity_status isEqualToNumber: c_UNCHANGED]) {
        NSMutableDictionary *dict = [FEMSerializer serializeObject:self usingMapping:[PestActivity reverseMapping]].mutableCopy;
        if ([self.entity_status isEqualToNumber: c_ADDED]) {
            // Remove all ids from all nested disctionary because we are adding new record
            dict = [dict dictionaryByRemovingId].mutableCopy;
        } else if ([self.entity_status isEqualToNumber: c_DELETED]) {
            // deleteing the record from server
            dict = [[NSMutableDictionary alloc] init];
            [dict setValue:self.entity_id forKey:@"id"];
            [dict setValue:[NSNumber numberWithBool:YES] forKey:@"_destroy"];
        } else {
            // Edit record
            if (self.entity_idValue > 0) {
                dict[@"id"] = self.entity_id;
            }
        }
        return dict;
    }
    return nil;
}

- (void)discard {
    if ([self.managedObjectContext hasChanges]) {
        [self.managedObjectContext rollback];
        [self.managedObjectContext refreshObject:self mergeChanges:NO];
        NSLog(@"Discarded on entity %@", self.entity_id);
    }
    
}

@end
