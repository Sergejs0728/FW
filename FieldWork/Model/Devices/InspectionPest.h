#import "_InspectionPest.h"

@interface InspectionPest : _InspectionPest {}
// Custom logic goes here.
+ (FEMMapping* )defaultMapping;

+ (FEMMapping *)reverseMapping;

+ (InspectionPest*) newInspectionPest;

- (NSMutableDictionary*)buildJson;

- (void) discard;

@end
