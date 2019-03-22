#import "_MaterialUsage.h"
#import "MaterialUsageRecord.h"


@interface MaterialUsage : _MaterialUsage {}

+ (FEMMapping* )defaultMapping;

+(FEMMapping *)reverseMapping;

+ (MaterialUsage*) createWithMaterialId:(NSNumber*)material_id;

+ (NSMutableArray *) buildJson:(NSSet*)records;

- (float) getTotalQty;

- (void) discard;

- (void) saveMaterialUsage;

@end
