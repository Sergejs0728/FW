#import "_InspectionRecord.h"



@interface InspectionRecord : _InspectionRecord {}


+ (FEMMapping* )defaultMapping;


+ (InspectionRecord *)newInspectionWithBarcode:(NSString*)barcode inContext:(NSManagedObjectContext*)context;

+ (InspectionRecord *)inspectionWithBarcode:(NSString*)barcode appointment:(Appointment*)app;

+ (InspectionRecord*) inspectionById:(NSNumber*)objectId;

- (NSMutableDictionary*)buildJson;

- (void) saveInspectionRecord;

- (void) discard;

@end
