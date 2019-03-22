#import "TrapTypes.h"
#import "CDHelper.h"

@interface TrapTypes ()

// Private interface goes here.

@end

@implementation TrapTypes

// Custom logic goes here.

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[TrapTypes entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[TrapTypes class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[TrapTypes MR_findAll] mutableCopy];
    return arr;
}

+ (TrapTypes *)trapTypesById:(NSNumber *)did {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"entity_id==%@",did];
    return [TrapTypes MR_findFirstWithPredicate:pre];
}

@end
