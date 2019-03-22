#import "ActivityLevel.h"
#import "NSManagedObject+Mapping.h"

@interface ActivityLevel ()

// Private interface goes here.

@end

@implementation ActivityLevel
+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[ActivityLevel entityName]];
    [mapping addAttribute:[ActivityLevel stringAttributeFor:@"name" andKeyPath:@"name"]];
    [mapping addAttribute:[ActivityLevel intAttributeFor:@"account_id" andKeyPath:@"account_id"]];
    [mapping addAttribute:[ActivityLevel dateTimeGMT0AttributeFor:@"updated_at" andKeyPath:@"updated_at"]];
    [mapping addAttribute:[ActivityLevel dateTimeGMT0AttributeFor:@"created_at" andKeyPath:@"created_at"]];
    [mapping addAttribute:[ActivityLevel intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    mapping.primaryKey=@"entity_id";
    return mapping;
}



+ (ActivityLevel*) activityLevelById:(NSNumber*)entity_id {
    return [ActivityLevel MR_findFirstByAttribute:@"entity_id" withValue:entity_id];
}

@end
