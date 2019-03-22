#import "_FlatType.h"

@interface FlatType : _FlatType
+ (FEMMapping* )defaultMapping;

+ (NSMutableArray *)fetchAll;

+ (FlatType*) flatTypeById:(NSNumber*)type_id;

@end
