#import "_ServiceLocation.h"
#import "Contact.h"
#import "CustomerDevice.h"
#define ENTITY_SERVICE_LOCATION @"ServiceLocation"
@interface ServiceLocation : _ServiceLocation {}
// Custom logic goes here.

typedef void (^WorkOrderHistoryLoadedBlock)(id result, NSString *error);

+ (FEMMapping* )defaultMapping;

- (NSString *)getFullAddress;


+(ServiceLocation *)newEntityWithCustomer:(Customer*)cust;

+ (ServiceLocation *)getById:(NSNumber*)ser_id;

- (void)loadWorkHistory:(WorkOrderHistoryLoadedBlock)block;
@end
