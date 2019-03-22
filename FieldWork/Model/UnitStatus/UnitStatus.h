#import "_UnitStatus.h"

@interface UnitStatus : _UnitStatus
+ (FEMMapping *)defaultMapping;
+ (NSMutableArray *)fetchAll;
+ (UnitStatus*) unitStatusByName:(NSString*)name;
+ (UnitStatus*) unitStatusById:(NSNumber*)object_id;
+ (NSNumber*) servicedUnitStatusId;
@end
