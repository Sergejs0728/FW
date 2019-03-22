#import "_DilutionRates.h"

@interface DilutionRates : _DilutionRates {}
// Custom logic goes here.
+ (FEMMapping* )defaultMapping;

+ (NSMutableArray*) fetchAll;

+ (DilutionRates*) dilutionRateById:(NSNumber*)dilution_id;


@end
