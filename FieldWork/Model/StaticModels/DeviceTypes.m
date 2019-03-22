#import "DeviceTypes.h"
#import "CDHelper.h"

@interface DeviceTypes ()

// Private interface goes here.

@end

@implementation DeviceTypes

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[DeviceTypes entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[DeviceTypes class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[DeviceTypes MR_findAll] mutableCopy];
    return arr;
}

+ (DeviceTypes *)deviceTypeById:(NSNumber *)device_type_id {
    return [DeviceTypes MR_findFirstByAttribute:@"entity_id" withValue:device_type_id];
}

@end
