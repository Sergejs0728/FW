#import "_PestActivity.h"
#import "ActivityLevel.h"

@interface PestActivity : _PestActivity

+ (FEMMapping* )defaultMapping;
+ (FEMMapping *)reverseMapping;
+ (PestActivity *)newPestActivityWithPestId:(NSNumber*)pestId unitRecordId:(NSNumber*)unitRecordId;
- (Pest*) getPest;
- (ActivityLevel*) getActivityLevel;
- (NSMutableDictionary*)buildJson;
- (void)discard;

@end
