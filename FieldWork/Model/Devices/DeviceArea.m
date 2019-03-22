#import "DeviceArea.h"
#import "CDHelper.h"

@interface DeviceArea ()
{
    ItemSavedBlock __save_block;
}

// Private interface goes here

@end

@implementation DeviceArea

// Custom logic goes here.
+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[DeviceArea entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[DeviceArea class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    
    return mapping;
}

+ (DeviceArea *)deviceAreaById:(int)device_area_id {
    return [DeviceArea MR_findFirstByAttribute:@"entity_id" withValue:[NSNumber numberWithInt:device_area_id]];
}

+ (NSArray *) getAllDeviceAreas {
    return [DeviceArea MR_findAll];
}

@end

