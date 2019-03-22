#import "Measurements.h"
#import "CDHelper.h"

@interface Measurements ()

// Private interface goes here.

@end

@implementation Measurements

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Measurements entityName]];
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:@"measurement" keyPath:@"" map:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    } reverseMap:NULL];
    [mapping addAttribute:attr];
    
    mapping.primaryKey = @"measurement";
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[Measurements MR_findAll] mutableCopy];
    return arr;
}

@end
