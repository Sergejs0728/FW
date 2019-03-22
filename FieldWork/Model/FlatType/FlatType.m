#import "FlatType.h"
#import "NSManagedObject+Mapping.h"

@interface FlatType ()

// Private interface goes here.

@end

@implementation FlatType

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[FlatType entityName]];
    [mapping addAttribute:[FlatType stringAttributeFor:@"name" andKeyPath:@"name"]];
    [mapping addAttribute:[FlatType intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    [mapping addAttribute:[FlatType intAttributeFor:@"account_id" andKeyPath:@"account_id"]];
    [mapping addAttribute:[FlatType dateTimeGMT0AttributeFor:@"updated_at" andKeyPath:@"updated_at"]];
    [mapping addAttribute:[FlatType dateTimeGMT0AttributeFor:@"created_at" andKeyPath:@"created_at"]];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[FlatType MR_findAll] mutableCopy];
    return arr;
}



+ (FlatType*) flatTypeById:(NSNumber*)type_id{
    return [FlatType MR_findFirstByAttribute:@"entity_id" withValue:type_id];
}

@end
