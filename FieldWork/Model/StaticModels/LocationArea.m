#import "LocationArea.h"
#import "CDHelper.h"

@interface LocationArea ()

// Private interface goes here.

@end

@implementation LocationArea

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[LocationArea entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[LocationArea class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    
    return mapping;
}

+ (LocationArea *)locationAreaById:(int)location_area_id {
    return [LocationArea MR_findFirstByAttribute:@"entity_id" withValue:[NSNumber numberWithInt:location_area_id]];
}

@end
