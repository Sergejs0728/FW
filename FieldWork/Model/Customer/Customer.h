#import "_Customer.h"
#import "NSMutableArray+Join.h"
#import "ServiceLocation.h"
#define ENTITY_CUSTOMER @"Customer"

@interface Customer : _Customer {}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

- (NSString *)getDisplayName;

+ (NSMutableArray *) getCustomers;

+ (Customer*) getById:(NSNumber*)cust_id;

- (NSString*) sortingName;

- (BOOL) isHavingCreditCardStored;

- (NSString *)getBillingFullAddress;

+ (Customer *)newEntity;

+ (void) retriveCustomer:(NSNumber*)cust_id withBlock:(ItemLoadedBlock)block;

- (void) loadPaymentMethods:(ItemLoadedBlock)block;

- (void) addNewPaymentMethod:(NSString*)stripe_tocken withBlock:(ItemSavedBlock)block;

@end
