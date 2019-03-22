#import "BaitConditions.h"
#import "CDHelper.h"

@interface BaitConditions ()

// Private interface goes here.

@end

@implementation BaitConditions

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[BaitConditions entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[BaitConditions class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[BaitConditions MR_findAll] mutableCopy];
    return arr;
}

+ (BaitConditions *)baitConditionById:(NSNumber *)bid {
    return [BaitConditions MR_findFirstByAttribute:@"entity_id" withValue:bid];
}

@end
