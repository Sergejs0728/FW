#import "ApplicationMethods.h"
#import "CDHelper.h"

@interface ApplicationMethods ()

// Private interface goes here.

@end

@implementation ApplicationMethods

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[ApplicationMethods entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[ApplicationMethods class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[ApplicationMethods MR_findAll] mutableCopy];
    return arr;
}

@end
