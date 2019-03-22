#import "_UnitInspection.h"
#import "Unit.h"
#import "CDHelper.h"
#import "NSManagedObject+Mapping.h"
#import "MaterialUsage.h"
#import "InspectionPest.h"
#import "Appointment.h"


@interface UnitInspection : _UnitInspection

+ (FEMMapping *)defaultMapping;

+ (FEMMapping *)reverseMapping;

- (NSMutableDictionary*)buildJson;

+ (UnitInspection *)newInspectionWithUnit:(Unit*)unit;

+ (NSArray*)unitInspectionsWithAppointmentId:(NSNumber*)appId unitStatusId:(NSNumber*)unitStatusId deleted:(BOOL)deleted;

+ (UnitInspection*)unitInspectionWithAppointmentId:(NSNumber*)appId unitNumber:(NSString*)unitNumber deleted:(BOOL)deleted;


+ (NSArray*)getFavoriteunitInspection:(NSNumber*)appId deleted:(BOOL)deleted;

- (void) save;

- (void) discard;

@end
