#import "_BillingTerms.h"

@interface BillingTerms : _BillingTerms {}
// Custom logic goes here.
+ (FEMMapping* )defaultMapping;

+ (NSMutableArray *) fetchAll;

+ (BillingTerms *) getbillingTermsById:(int)billing_term_id;

@end
