#import "Conditions.h"
#import "CDHelper.h"

@interface Conditions ()

// Private interface goes here.

@end

@implementation Conditions

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Conditions entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[Conditions class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[Conditions MR_findAll] mutableCopy];
    return arr;
}

+ (Conditions *)conditionById:(NSNumber *)con_id {
    return [Conditions MR_findFirstByAttribute:@"entity_id" withValue:con_id];
}

+ (NSMutableArray *)conditionByIds:(NSArray *)ids {
    NSMutableArray *result = [NSMutableArray array];
    if (ids) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"entity_id in %@", ids];
        result = [[Conditions MR_findAllWithPredicate:pre] mutableCopy];
    }
    return result;
}

@end
