#import "ServiceRoutes.h"
#import "CDHelper.h"

@interface ServiceRoutes ()

// Private interface goes here.

@end

@implementation ServiceRoutes

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[ServiceRoutes entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[ServiceRoutes class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    
    return mapping;
}

+ (NSMutableArray *)fetchAll{
    return [[ServiceRoutes MR_findAllSortedBy:@"service_route_name" ascending:YES] mutableCopy];
}

+ (ServiceRoutes *)serviceRoutesById:(int)serviceRoutes_id {
    return [ServiceRoutes MR_findFirstByAttribute:@"entity_id" withValue:[NSNumber numberWithInt:serviceRoutes_id]];
    
}
+ (NSMutableArray *)fetchAllWithCurrent:(NSNumber*)service_route{
    NSMutableArray* serviceRoutesArray=  [[ServiceRoutes MR_findAllSortedBy:@"service_route_name" ascending:YES] mutableCopy];
    for(int i=0;i<serviceRoutesArray.count;i++){
        ServiceRoutes* current_route=[serviceRoutesArray objectAtIndex:i];
        if([current_route.entity_id isEqualToNumber:service_route]){
            id object = [serviceRoutesArray objectAtIndex:i];
            [serviceRoutesArray removeObjectAtIndex:i];
            [serviceRoutesArray insertObject:object atIndex:0];
        }
    }
    
    return serviceRoutesArray;
}
@end
