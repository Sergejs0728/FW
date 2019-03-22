#import "_CustomerDevice.h"

#import "FWRequestKit.h"

@interface CustomerDevice : _CustomerDevice <FWRequestDelegate>
{

}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

+ (FEMMapping*)reverseMapping;


+ (CustomerDevice*) newDeviceForCustomer:(NSNumber*)customer_id forServiceLocaiton:(NSNumber*)service_location_id;

+ (NSMutableArray*) devicesByServiceLocationId:(NSNumber*) service_location_id;

+ (CustomerDevice *)deviceByBarcode:(NSString *)barcode_no andService_location:(NSNumber*)ser_loc_id;

+ (CustomerDevice *)deviceByBarcode:(NSString *)barcode_no andService_location:(NSNumber*)ser_loc_id inContext:(NSManagedObjectContext*)context;

+ (CustomerDevice *) deviceByBarcode:(NSString *) barcode_no;

+ (NSArray*)devicesForSync;

- (void) saveCustomerDevicetOnLocal;

- (void) saveCustomerDeviceToServer:(ItemSavedBlock)block;




@end
