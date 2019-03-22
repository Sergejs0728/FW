#import "InspectionRecord.h"
#import "CDHelper.h"
#import "MaterialUsage.h"
#import "InspectionPest.h"
#import "NSManagedObject+Mapping.h"
#import "Appointment.h"
#import "NSDictionary+Extension.h"

@interface InspectionRecord ()

// Private interface goes here.

@end

@implementation InspectionRecord

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[InspectionRecord entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[InspectionRecord class]] mutableCopy];
    
    [dict removeObjectForKey:@"scanned_on"];
    
    [mapping addAttributesFromDictionary:dict];
    
    [mapping addToManyRelationshipMapping:[MaterialUsage defaultMapping] forProperty:@"material_usages" keyPath:@"material_usages"];
    [mapping addToManyRelationshipMapping:[InspectionPest defaultMapping] forProperty:@"pests_records" keyPath:@"pests_records"];
    
    [mapping addAttribute:[InspectionRecord dateTimeAttributeFor:@"scanned_on" andKeyPath:@"scanned_on"]];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}


+(FEMMapping *)reverseMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[InspectionRecord entityName]];
    NSDictionary *appt_mapping_dict = @{@"barcode":@"barcode",
                                        @"location_area_id":@"location_area_id",
                                        @"trap_number":@"trap_number",
                                        @"trap_type_id":@"trap_type_id",
                                        // @"scanned_on":@"scanned_on",
                                        @"trap_condition_id":@"trap_condition_id",
                                        @"bait_condition_id":@"bait_condition_id",
                                        @"removed":@"removed",
                                        @"exception":@"exception",
                                        @"notes":@"notes",
                                        @"evidence_ids":@"evidence_ids",
                                        @"floor":@"floor",
                                        @"location_details":@"location_details",
                                        @"building" : @"building"
                                        };
    
    [mapping addAttribute:[FEMAttribute mappingOfProperty:@"scanned_on" toKeyPath:@"scanned_on" dateFormat:@"yyyy-MM-dd'T'HH:mm'Z'"]];
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    
//    [mapping addToManyRelationshipMapping:[MaterialUsage reverseMapping] forProperty:@"material_usages" keyPath:@"material_usages_attributes"];
//    [mapping addToManyRelationshipMapping:[InspectionPest defaultMapping] forProperty:@"pests_records" keyPath:@"pests_records_attributes"];
    
    return mapping;
}

+ (InspectionRecord *)newInspectionWithBarcode:(NSString*)barcode inContext:(NSManagedObjectContext*)context {
    InspectionRecord *ir = [InspectionRecord MR_createEntityInContext:context];
    [ir setBarcode:barcode];
    [ir setEntity_status:c_ADDED];
    [ir setEntity_id:[NSNumber numberWithInt:[Utils RandomId]]];
    return ir;
}

+ (InspectionRecord *)inspectionWithBarcode:(NSString*)barcode appointment:(Appointment*)app {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"barcode == %@", barcode];
    InspectionRecord *ir = [[app.inspection_records allObjects] filteredArrayUsingPredicate:predicate].firstObject;
    return ir;
}

+ (InspectionRecord*) inspectionById:(NSNumber*)objectId {
    return [InspectionRecord MR_findFirstByAttribute:@"entity_id" withValue:objectId];
}

- (NSMutableDictionary*)buildJson {
    if (![self.entity_status isEqualToNumber: c_UNCHANGED]) {
        NSMutableDictionary *dict = [FEMSerializer serializeObject:self usingMapping:[InspectionRecord reverseMapping]].mutableCopy;
        
        if ([self.entity_status isEqualToNumber: c_ADDED]) {
            // Remove all ids from all nested disctionary because we are adding new record
            dict = [dict dictionaryByRemovingId].mutableCopy;
            if (self.trap_idValue > 0) {
                dict[@"trap_id"] = self.trap_id;
            }
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
            if (self.trap_idValue > 0) {
                dict[@"trap_id"] = self.trap_id;
            }
        }
        NSMutableArray *mur_list = [MaterialUsage buildJson:self.material_usages];
        if(mur_list.count > 0)
            dict[@"material_usages_attributes"] = mur_list;
        
        NSMutableArray *pr_list = [NSMutableArray array];
        for (InspectionPest *ip in [self.pests_records allObjects]) {
            NSMutableDictionary *ip_dict = [ip buildJson];
            if (ip_dict) {
                [pr_list addObject:ip_dict];
            }
        }
        if(pr_list.count > 0)
            dict[@"pests_records_attributes"] = pr_list;
        return dict;
    }
    return nil;
}


- (void) saveInspectionRecord
{
    if ([self.entity_status isEqualToNumber:c_UNCHANGED]) {
        [self setEntity_status:c_EDITED];
    }
    [self.appointment setEntity_status:c_EDITED];
    [self.managedObjectContext MR_saveOnlySelfAndWait];
}

- (void) discard
{
    if (self.managedObjectContext) {
        [self.managedObjectContext rollback];
        [self.managedObjectContext refreshObject:self mergeChanges:NO];
        // To reload the object, we need to access it
        NSLog(@"%@", self.entity_id);
    }
}

@end
