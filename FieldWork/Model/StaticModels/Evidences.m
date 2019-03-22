#import "Evidences.h"
#import "CDHelper.h"

@interface Evidences ()

// Private interface goes here.

@end

@implementation Evidences

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Evidences entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[Evidences class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    
    return mapping;
}

+ (Evidences *)evidenceById:(NSNumber *)eid {
    return [Evidences MR_findFirstByAttribute:@"entity_id" withValue:eid];
}

+ (NSMutableArray *)fetchAll {
    return [[Evidences MR_findAll] mutableCopy];
}

@end
