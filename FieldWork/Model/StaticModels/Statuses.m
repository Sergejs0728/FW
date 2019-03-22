#import "Statuses.h"
#import "CDHelper.h"

@interface Statuses ()

// Private interface goes here.

@end

@implementation Statuses

// Custom logic goes here.

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Statuses entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[Statuses class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"status_value";
    
    return mapping;
}

+ (NSMutableArray *)getStatues {
    return [[Statuses MR_findAll] mutableCopy];
}


@end
