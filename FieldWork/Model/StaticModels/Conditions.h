#import "_Conditions.h"

@interface Conditions : _Conditions {}
// Custom logic goes here.
+ (FEMMapping* )defaultMapping;

+ (NSMutableArray*) fetchAll;

+ (Conditions*) conditionById:(NSNumber*) con_id;

+ (NSMutableArray*) conditionByIds:(NSArray*) ids;

@end
