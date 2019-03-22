#import "MaterialUsageRecord.h"
#import "CDHelper.h"
#import "NSManagedObject+Mapping.h"

#import "MaterialUsage.h"

@interface MaterialUsageRecord ()

// Private interface goes here.

@end

@implementation MaterialUsageRecord

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[MaterialUsageRecord entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[MaterialUsageRecord class]] mutableCopy];
    
    [dict removeObjectForKey:@"amount"];
    
    [mapping addAttributesFromDictionary:dict];
    
    [mapping addAttribute:[MaterialUsageRecord floatAttributeFor:@"amount" andKeyPath:@"amount"]];
    
    [mapping addToManyRelationshipMapping:[TargetPest defaultMapping] forProperty:@"target_pests" keyPath:@"target_pests"];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (FEMMapping *)reverseMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[MaterialUsageRecord entityName]];
    NSDictionary *appt_mapping_dict = @{@"location_area_id":@"location_area_id",
                                        @"dilution_rate_id":@"dilution_rate_id",
                                        @"application_method":@"application_method",
                                        @"application_method_id":@"application_method_id",
                                        @"amount":@"amount",
                                        @"measurement":@"measurement",
                                        @"application_device_type_id":@"application_device_type_id",
                                        @"lot_number":@"lot_number",
                                        @"entity_id":@"id"
                                        };
    
    [mapping addToManyRelationshipMapping:[TargetPest reverseMapping] forProperty:@"target_pests" keyPath:@"target_pests_attributes"];
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    return mapping;
    
}

+ (MaterialUsageRecord*) getById:(NSNumber*) objectId
{
    return [MaterialUsageRecord MR_findFirstByAttribute:@"entity_id" withValue:objectId ];
}

+ (MaterialUsageRecord*) materialUsageRecordByLocationAreaId:(NSNumber*) objectId
{
    return [MaterialUsageRecord MR_findFirstByAttribute:@"location_area_id" withValue:objectId ];
}

+ (MaterialUsageRecord *)newMaterialUsageRecordInContext: (NSManagedObjectContext*)context {
    MaterialUsageRecord *record = [MaterialUsageRecord MR_createEntityInContext:context];
    [record setEntity_idValue:[Utils RandomId]];
    return record;
}

+ (MaterialUsageRecord *)newMaterialUsageRecord  {
    return [self newMaterialUsageRecordInContext:[NSManagedObjectContext MR_defaultContext]];
}

@end
