#import "UnitInspection.h"
#import "FWRequestDelegate.h"
#import "Appointment+Mapping.h"
#import "NSDictionary+Extension.h"
#import "PestActivity.h"

@interface UnitInspection () {
    ItemSavedBlock _itemSavedBlock;
}

@end

@implementation UnitInspection

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[UnitInspection entityName]];
    [mapping addAttribute:[UnitInspection stringAttributeFor:@"service_time" andKeyPath:@"service_time"]];
    [mapping addAttribute:[UnitInspection intAttributeFor:@"appointment_occurrence_id" andKeyPath:@"appointment_occurrence_id"]];
    [mapping addAttribute:[UnitInspection stringAttributeFor:@"unit_number" andKeyPath:@"unit_number"]];
    [mapping addAttribute:[UnitInspection stringAttributeFor:@"tenant_name" andKeyPath:@"tenant_name"]];
    [mapping addAttribute:[UnitInspection stringAttributeFor:@"notes" andKeyPath:@"notes"]];
    [mapping addAttribute:[UnitInspection intAttributeFor:@"flat_condition_id" andKeyPath:@"flat_condition_id"]];
    [mapping addAttribute:[UnitInspection intAttributeFor:@"flat_type_id" andKeyPath:@"flat_type_id"]];
    [mapping addAttribute:[UnitInspection intAttributeFor:@"unit_status_id" andKeyPath:@"unit_status_id"]];
    [mapping addAttribute:[UnitInspection stringAttributeFor:@"tenant_signature" andKeyPath:@"tenant_signature"]];
    [mapping addAttribute:[UnitInspection intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    
    
    [mapping addToManyRelationshipMapping:[MaterialUsage defaultMapping] forProperty:@"material_usages" keyPath:@"material_usages"];
    [mapping addToManyRelationshipMapping:[PestActivity defaultMapping] forProperty:@"pests_activities" keyPath:@"pests_activities"];
    
    mapping.primaryKey=@"entity_id";
    return mapping;
}

+ (FEMMapping *)reverseMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[UnitInspection entityName]];
    NSDictionary *mapping_dict = @{@"appointment_occurrence_id":@"appointment_occurrence_id",
                                        @"unit_number":@"unit_number",
                                        @"tenant_name":@"tenant_name",
                                        @"notes":@"notes",
                                        @"flat_type_id":@"flat_type_id",
                                        @"unit_status_id":@"unit_status_id",
                                        @"flat_condition_id":@"flat_condition_id",
                                        @"notes":@"notes",
                                        @"tenant_signature":@"tenant_signature",
                                        @"service_time":@"service_time"
                                        };
//    [mapping addAttribute:[FEMAttribute mappingOfProperty:@"service_time" toKeyPath:@"service_time" dateFormat:@"hh:mm a"]];
//    [mapping addToManyRelationshipMapping:[MaterialUsage reverseMapping] forProperty:@"material_usages" keyPath:@"material_usages_attributes"];
//    [mapping addToManyRelationshipMapping:[PestActivity reverseMapping] forProperty:@"pests_activities" keyPath:@"pests_activities_attributes"];
    [mapping addAttributesFromDictionary:mapping_dict];
    return mapping;
}

- (NSMutableDictionary*)buildJson {
    if (![self.entity_status isEqualToNumber: c_UNCHANGED]) {
        NSMutableDictionary *dict = [FEMSerializer serializeObject:self usingMapping:[UnitInspection reverseMapping]].mutableCopy;
        
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
        NSMutableArray *mur_list = [MaterialUsage buildJson:self.material_usages];
        if(mur_list.count > 0)
             dict[@"material_usages_attributes"] = mur_list;
       
        NSMutableArray *pa_list = [NSMutableArray array];
        for (PestActivity *pa_r in [self.pests_activities allObjects]) {
            NSMutableDictionary *pa_dict = [pa_r buildJson];
            if (pa_dict) {
                [pa_list addObject:pa_dict];
            }
        }
        
        dict[@"pests_activities_attributes"] = pa_list;
        return dict;
    }
    return nil;
}

+ (UnitInspection *)newInspectionWithUnit:(Unit*)unit {
    UnitInspection *ir = [UnitInspection MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [ir setEntity_status:c_ADDED];
    [ir setEntity_id:[NSNumber numberWithInt:[Utils RandomId]]];
    if (unit) {
        [ir setUnit_number:unit.unit_number];
        [ir setNotes:unit.notes];
        [ir setTenant_name:unit.tenant_name];
        [ir setTenant_email_1:unit.tenant_email_1];
        [ir setTenant_email_2:unit.tenant_email_2];
        [ir setTenant_phone_1:unit.tenant_phone_1];
        [ir setTenant_phone_2:unit.tenant_phone_2];
    }
    
    return ir;
}

+ (NSArray*)unitInspectionsWithAppointmentId:(NSNumber*)appId unitStatusId:(NSNumber*)unitStatusId deleted:(BOOL)deleted {
    NSPredicate *predicate = nil;
    if (deleted) {
        predicate = [NSPredicate predicateWithFormat:@"appointment_occurrence_id == %@ AND unit_status_id == %@ AND entity_status == %@", appId, unitStatusId, c_DELETED];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"appointment_occurrence_id == %@ AND unit_status_id == %@ AND entity_status != %@", appId, unitStatusId, c_DELETED];
    }
    NSArray *results = [UnitInspection MR_findAllWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];
    return results;
}

+ (UnitInspection*)unitInspectionWithAppointmentId:(NSNumber*)appId unitNumber:(NSString*)unitNumber deleted:(BOOL)deleted {
    NSPredicate *predicate = nil;
    if (deleted) {
        predicate = [NSPredicate predicateWithFormat:@"appointment_occurrence_id == %@ AND unit_number == %@ AND entity_status == %@", appId, unitNumber, c_DELETED];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"appointment_occurrence_id == %@ AND unit_number == %@ AND entity_status != %@", appId, unitNumber, c_DELETED];
    }
    UnitInspection *record = [UnitInspection MR_findFirstWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];
    return record;
}

+ (NSArray*)getFavoriteunitInspection:(NSNumber*)appId deleted:(BOOL)deleted {
    NSPredicate *predicate = nil;
    if (deleted) {
        predicate = [NSPredicate predicateWithFormat:@"appointment_occurrence_id == %@", appId, c_DELETED];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"appointment_occurrence_id == %@", appId, c_DELETED];
    }
    NSArray *results = [UnitInspection MR_findAllWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];
    return results;
}
- (void) save
{
    if ([self.entity_status isEqualToNumber:c_UNCHANGED]) {
        [self setEntity_status:c_EDITED];
    }
    [self.appointment setEntity_status:c_EDITED];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void) discard
{
    [self.managedObjectContext rollback];
    [self.managedObjectContext refreshObject:self mergeChanges:NO];
    // To reload the object, we need to access it
    NSLog(@"%@", self.notes);
}

@end
