#import "_Contact.h"

@interface Contact : _Contact {}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;
+ (NSMutableArray *)getContactByCustomerId:(int)custId;
@end
