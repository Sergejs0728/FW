#import "_ActivityLevel.h"

@interface ActivityLevel : _ActivityLevel
+ (FEMMapping *)defaultMapping;
+ (ActivityLevel*) activityLevelById:(NSNumber*)entity_id;
@end
