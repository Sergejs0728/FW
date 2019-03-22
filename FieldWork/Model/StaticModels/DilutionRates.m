#import "DilutionRates.h"
#import "CDHelper.h"

@interface DilutionRates ()

// Private interface goes here.

@end

@implementation DilutionRates

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[DilutionRates entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[DilutionRates class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {

    NSMutableArray *arr = [[DilutionRates MR_findAll] mutableCopy];
    return arr;
}

+ (DilutionRates *)dilutionRateById:(NSNumber *)dilution_id {
    return [DilutionRates MR_findFirstByAttribute:@"entity_id" withValue:dilution_id];
}

@end
