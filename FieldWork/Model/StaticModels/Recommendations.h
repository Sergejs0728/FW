#import "_Recommendations.h"

@interface Recommendations : _Recommendations {}
// Custom logic goes here.
+ (FEMMapping* )defaultMapping;

+ (NSMutableArray*) fetchAll;

+ (Recommendations*) recommendationById:(NSNumber*) rec_id;

+ (NSMutableArray*) recommendationByIds:(NSArray*) ids;

@end
