#import "InspectionPest.h"
#import "CDHelper.h"
#import "NSManagedObject+Mapping.h"
#import "NSDictionary+Extension.h"

@interface InspectionPest ()

// Private interface goes here.

@end

@implementation InspectionPest

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[InspectionPest entityName]];
    [mapping addAttribute:[InspectionPest intAttributeFor:@"pest_type_id" andKeyPath:@"pest_type_id"]];
    [mapping addAttribute:[InspectionPest intAttributeFor:@"count" andKeyPath:@"count"]];
    [mapping addAttribute:[InspectionPest intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (FEMMapping *)reverseMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[InspectionPest entityName]];
    [mapping addAttribute:[InspectionPest intAttributeFor:@"pest_type_id" andKeyPath:@"pest_type_id"]];
    [mapping addAttribute:[InspectionPest intAttributeFor:@"count" andKeyPath:@"count"]];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (InspectionPest *)newInspectionPest {
    InspectionPest *ip = [InspectionPest MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    ip.entity_status = c_ADDED;
    [ip setEntity_id:@([Utils RandomId])];
    return ip;
}

- (NSMutableDictionary*)buildJson {
    if (![self.entity_status isEqualToNumber: c_UNCHANGED]) {
        NSMutableDictionary *dict = [FEMSerializer serializeObject:self usingMapping:[InspectionPest reverseMapping]].mutableCopy;
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

- (void) discard
{
    if ([self.managedObjectContext hasChanges]) {
        [self.managedObjectContext rollback];
        [self.managedObjectContext refreshObject:self mergeChanges:NO];
        // To reload the object, we need to access it
        NSLog(@"%@", self.entity_id);
    }
}

@end
