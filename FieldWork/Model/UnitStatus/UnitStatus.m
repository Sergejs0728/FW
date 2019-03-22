#import "UnitStatus.h"
#import "NSManagedObject+Mapping.h"

@interface UnitStatus ()

// Private interface goes here.

@end

@implementation UnitStatus

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[UnitStatus entityName]];
    [mapping addAttribute:[UnitStatus stringAttributeFor:@"name" andKeyPath:@"name"]];
    [mapping addAttribute:[UnitStatus intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    [mapping addAttribute:[UnitStatus intAttributeFor:@"account_id" andKeyPath:@"account_id"]];
    [mapping addAttribute:[UnitStatus dateTimeGMT0AttributeFor:@"updated_at" andKeyPath:@"updated_at"]];
    [mapping addAttribute:[UnitStatus dateTimeGMT0AttributeFor:@"created_at" andKeyPath:@"created_at"]];
    mapping.primaryKey = @"entity_id";
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[UnitStatus MR_findAll] mutableCopy];
    return arr;
}

+ (UnitStatus*) unitStatusById:(NSNumber*)object_id {
    return [UnitStatus MR_findFirstByAttribute:@"entity_id" withValue:object_id];
}

+ (UnitStatus*) unitStatusByName:(NSString*)name {
    return [UnitStatus MR_findFirstByAttribute:@"name" withValue:name];
}

+ (NSNumber*) servicedUnitStatusId {
    UnitStatus *type = [self unitStatusByName:@"Serviced"];
    return type.entity_id;
}
@end
