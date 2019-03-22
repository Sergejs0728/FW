#import "_Estimate.h"
#import "NSManagedObject+MagicalRecord.h"

typedef void (^EstimateSavedBlock)(BOOL is_saved, NSNumber* est_id);
@interface Estimate : _Estimate <FWRequestDelegate>

+ (NSMutableArray*) getEstimates;
+ (BOOL)isFoundDirty;
+ (FEMMapping* )defaultMapping;
+ (NSMutableArray*) getEstimatesForDate:(NSDate*) date;
- (Customer *)getCustomer;
- (ServiceLocation*) getServiceLocation;
- (NSString*)getDurationString;
-(NSDate*)getEndTime;
-(NSString*)startsAtString;
-(NSString*)endTimeString;
+ (Estimate*) getById:(NSNumber*)est_id;
+ (FEMMapping *)reverseMappingEstimate;
+ (FEMMapping *)reverseMappingLineItems;
+ (NSMutableArray*) getEstimatesForDate:(NSDate*) date;
- (void) calculateTaxAmount;
- (void) saveEstimateOnLocal;
- (void) saveEstimateOnServerWithBlock:(EstimateSavedBlock)save_block;
- (void) calculateTaxAmount;
- (float) getFinalTotalDue;
@end
