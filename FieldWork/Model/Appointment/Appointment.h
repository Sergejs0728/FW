#import "_Appointment.h"

#import "LineItem.h"
#import "MaterialUsage.h"

#import "FWRequestKit.h"

#import "Customer.h"
#import "ServiceLocation.h"
#import "TaxRates.h"

#define ENTITY_APPOINTMENT @"Appointment"

#define ADD_NEW_WORK_ORDER_TAG @"ADD_NEW_WORK_ORDER_TAG"

typedef void (^AppointmentSavedBlock)(BOOL is_saved, NSNumber* appointment_id);

typedef enum _CaptureMode
{
    CustomerMode,
    TechnicianMode,
    SimpleSignatureMode
} CaptureMode;

@interface Appointment : _Appointment <FWRequestDelegate>
{
    
}
    // Custom logic goes here.


- (ServiceLocation*) getServiceLocation;

+ (NSMutableArray*) getAppointments;

+ (NSMutableArray *)getWorkPoolAppointments;

+ (NSMutableArray *)getWorkPoolAppointmentsByDistance: (CLLocation *)currentLocation;
+ (NSMutableArray *)getWorkPoolAppointmentsByDistanceWithDate: (CLLocation *)currentLocation selectedDate:(NSDate *)s_Date;
+ (NSMutableArray *)getWorkPoolAppointmentsByDistanceWithDateRange:(CLLocation *)currentLocation fromDate:(NSDate *)f_Date toDate:(NSDate *)t_Date;
+ (NSString *)ServiceReportPath;

+ (CLLocationDistance)getDistanceForAppointment:(NSNumber *)app_id andCurrentLocation:(CLLocation *)currentLocation;

+ (Appointment*) getById:(NSNumber*)appt_id;

+ (Appointment *)getAppointmentByServiceLocationId:(NSNumber *)service_loc_id;

+ (NSMutableArray *)getWorkOrderHistoryByServiceLocationId:(ServiceLocation *)ser_loc;

- (NSMutableArray*) getServiceRoutesByServiceRoutesId:(int)ServiceRoutesId;

+ (NSMutableArray*) getAppointmentsForDate:(NSDate*) date;

+ (Appointment *)newEntity;

- (void)addIdToPDFForms;

- (Customer*) getCustomer;

- (NSString*)getDuration;

- (float)getTotalServicePrice;

- (float) getFinalTotalDue;

-(float)getTaxableLineItemPrice;

- (void)calculateTaxAmountForOwnTaxtRate:(BOOL)forOwnTaxRate;

- (void) saveAppointmentOnLocal;

- (void) saveAppointmentOnServerWithBlock:(AppointmentSavedBlock)save_block;

- (void) addNewWorkOrderWithBklock:(ItemSavedBlock)block;

- (void) saveWorkPoolAppointmentOnServerWithBlock:(AppointmentSavedBlock)save_block;

+(BOOL)isFoundDirty;

- (BOOL)hasDirtyAttachments;
@end
