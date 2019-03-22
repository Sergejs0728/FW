#import "_ServiceRoutes.h"

@interface ServiceRoutes : _ServiceRoutes {}
// Custom logic goes here.
+ (FEMMapping* )defaultMapping;

+ (NSMutableArray *) fetchAll;
+ (ServiceRoutes *)serviceRoutesById:(int)serviceRoutes_id;
+ (NSMutableArray *)fetchAllWithCurrent:(NSNumber*)service_route;
@end
