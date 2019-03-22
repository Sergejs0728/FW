#import "FlatConditions.h"
#import "NSManagedObject+Mapping.h"

@interface FlatConditions ()

// Private interface goes here.

@end

@implementation FlatConditions
+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[FlatConditions entityName]];
    [mapping addAttribute:[FlatConditions stringAttributeFor:@"name" andKeyPath:@"name"]];
    [mapping addAttribute:[FlatConditions intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    [mapping addAttribute:[FlatConditions intAttributeFor:@"account_id" andKeyPath:@"account_id"]];
    [mapping addAttribute:[FlatConditions dateTimeGMT0AttributeFor:@"updated_at" andKeyPath:@"updated_at"]];
    [mapping addAttribute:[FlatConditions dateTimeGMT0AttributeFor:@"created_at" andKeyPath:@"created_at"]];
    mapping.primaryKey = @"entity_id";

    return mapping;
}
+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[FlatConditions MR_findAll] mutableCopy];
    return arr;
}

+ (FlatConditions*) flatConditionsById:(NSNumber*)object_id {
    return [FlatConditions MR_findFirstByAttribute:@"entity_id" withValue:object_id];
}
@end
