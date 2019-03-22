#import "_Evidences.h"

@interface Evidences : _Evidences {}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

+ (Evidences*) evidenceById:(NSNumber*)eid;

+ (NSMutableArray*) fetchAll;

@end
