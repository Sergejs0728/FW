#import "_DeviceTypes.h"

@interface DeviceTypes : _DeviceTypes {}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

+ (NSMutableArray*) fetchAll;

+ (DeviceTypes*) deviceTypeById:(NSNumber*) device_type_id;

@end
