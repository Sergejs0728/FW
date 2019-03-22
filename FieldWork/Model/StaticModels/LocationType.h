#import "_LocationType.h"

#import "LocationArea.h"

@interface LocationType : _LocationType {}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

+ (NSMutableArray *)getLocationTypes;

+ (LocationType *)getLocationTypeById:(int)location_type_id;

+ (NSMutableArray*) getLocationAreasByLocationTypeId:(int)location_type_id;

- (void)addLocationArea:(NSString *)name block:(ItemLoadedBlock)block;

@end
