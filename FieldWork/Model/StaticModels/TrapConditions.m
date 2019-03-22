#import "TrapConditions.h"
#import "CDHelper.h"

@interface TrapConditions ()

// Private interface goes here.

@end

@implementation TrapConditions

// Custom logic goes here.

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[TrapConditions entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[TrapConditions class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[TrapConditions MR_findAll] mutableCopy];
    return arr;
}

+ (TrapConditions *)trapConditionById:(NSNumber *)con_id {
    return [TrapConditions MR_findFirstByAttribute:@"entity_id" withValue:con_id];
}

@end
