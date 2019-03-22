#import "_DeviceArea.h"
#import "FWRequestKit.h"

@interface DeviceArea : _DeviceArea
// Custom logic goes here.
+ (FEMMapping* )defaultMapping;

+ (DeviceArea*) deviceAreaById:(int)device_area_id;

+ (NSArray *) getAllDeviceAreas;

@end

