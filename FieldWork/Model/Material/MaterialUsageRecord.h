#import "_MaterialUsageRecord.h"
#import "TargetPest.h"

@class MaterialUsage;

@interface MaterialUsageRecord : _MaterialUsageRecord {}

+ (FEMMapping* )defaultMapping;

+ (FEMMapping *)reverseMapping;

+ (MaterialUsageRecord*) materialUsageRecordByLocationAreaId:(NSNumber*) objectId;

+ (MaterialUsageRecord *)newMaterialUsageRecord;

+ (MaterialUsageRecord *)newMaterialUsageRecordInContext: (NSManagedObjectContext*)context;


@end
