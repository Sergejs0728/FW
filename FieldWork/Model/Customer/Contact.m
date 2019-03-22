#import "Contact.h"
#import "CDHelper.h"

@interface Contact ()

// Private interface goes here.

@end

@implementation Contact

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Contact entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[Contact class]] mutableCopy];
    
    [mapping addAttributesFromDictionary:dict];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (NSMutableArray *)getContactByCustomerId:(int)custId{
    return [[Contact MR_findByAttribute:@"entity_id" withValue:[NSNumber numberWithInt:custId]] mutableCopy];
}


@end
