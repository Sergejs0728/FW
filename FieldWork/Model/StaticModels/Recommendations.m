#import "Recommendations.h"
#import "CDHelper.h"

@interface Recommendations ()

// Private interface goes here.

@end

@implementation Recommendations

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Recommendations entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[Recommendations class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[Recommendations MR_findAll] mutableCopy];
    return arr;
}

+ (Recommendations*) recommendationById:(NSNumber*) rec_id
{
    return [Recommendations MR_findFirstByAttribute:@"entity_id" withValue:rec_id];
}

+ (NSMutableArray*) recommendationByIds:(NSArray*) ids
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"entity_id IN %@", ids];
    return [[Recommendations MR_findAllWithPredicate:pre] mutableCopy];
}

@end
