#import "_TargetPest.h"


@interface TargetPest : _TargetPest {}

+ (FEMMapping* )defaultMapping;

+(FEMMapping *)reverseMapping;

+ (TargetPest *)newTargetPestWithPestId:(NSNumber *)pest_id;

+ (TargetPest *)newTargetPestWithPestId:(NSNumber *)pest_id inContext:(NSManagedObjectContext*)context;

- (Pest*) getPest;

+ (NSMutableArray *) getPestIdsByTargetPests:(NSMutableArray *)arr;

@end
