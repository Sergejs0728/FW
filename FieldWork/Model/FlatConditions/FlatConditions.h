#import "_FlatConditions.h"

@interface FlatConditions : _FlatConditions
+ (FEMMapping *)defaultMapping;
+ (NSMutableArray *)fetchAll;
+ (FlatConditions*) flatConditionsById:(NSNumber*)object_id;
@end
