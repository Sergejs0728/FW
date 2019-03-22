#import "_TaxRates.h"

@interface TaxRates : _TaxRates {}
// Custom logic goes here.
+ (FEMMapping* )defaultMapping;

+ (NSMutableArray *)  fetchAll;

+ (TaxRates *)getTaxRatesById:(NSNumber *)tax_rate_id;

+ (TaxRates *)getTaxRatesById:(NSNumber *)tax_rate_id inContext:(NSManagedObjectContext*)context;

+ (void)retriveTaxRate:(NSNumber *)taxRateId withBlock:(ItemLoadedBlock)block;

@end
