#import "_TrapConditions.h"

@interface TrapConditions : _TrapConditions {}
// Custom logic goes here.


+ (FEMMapping* )defaultMapping;

+ (NSMutableArray*) fetchAll;

+ (TrapConditions *)trapConditionById:(NSNumber *)con_id;

@end
