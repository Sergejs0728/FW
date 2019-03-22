#import "_TrapTypes.h"

@interface TrapTypes : _TrapTypes {}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

+ (NSMutableArray*) fetchAll;

+ (TrapTypes *)trapTypesById:(NSNumber *)did;

@end
