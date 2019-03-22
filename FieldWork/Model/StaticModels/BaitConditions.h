#import "_BaitConditions.h"

@interface BaitConditions : _BaitConditions {}
// Custom logic goes here.
+ (FEMMapping* )defaultMapping;

+ (NSMutableArray*) fetchAll;

+ (BaitConditions*) baitConditionById:(NSNumber*)bid;


@end
