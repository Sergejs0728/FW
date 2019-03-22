#import "Services.h"
#import "CDHelper.h"

@interface Services ()

// Private interface goes here.

@end

@implementation Services

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Services entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[Services class]] mutableCopy];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    [dict removeObjectForKey:@"price"];
    
    FEMAttribute *attribute = [[FEMAttribute alloc] initWithProperty:@"price" keyPath:@"price" map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSNumber numberWithFloat:[value floatValue]];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%.02f", [value floatValue]];
    }];
    [mapping addAttribute:attribute];
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[Services MR_findAll] mutableCopy];
    return arr;
}

@end
