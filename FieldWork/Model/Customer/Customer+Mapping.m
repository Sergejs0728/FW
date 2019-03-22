//
//  Customer+Mapping.m
//  FieldWork
//
//  Created by SamirMAC on 1/20/16.
//
//

#import "Customer+Mapping.h"
#import "CDHelper.h"
#import "NSManagedObject+Mapping.h"

@implementation Customer (Mapping)



+ (FEMMapping *) reverseMappingCustomer {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Customer entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[Customer class]] mutableCopy];
    
    [dict removeObjectForKey:@"lat"];
    [dict removeObjectForKey:@"lng"];
    [dict removeObjectForKey:@"balance"];
    [dict removeObjectForKey:@"customer_name"];
    [dict removeObjectForKey:@"inspections_enabled"];
    [dict removeObjectForKey:@"email_marketing"];
    [dict removeObjectForKey:@"account_number"];
    
    [mapping addAttributesFromDictionary:dict];
    
    [mapping addToManyRelationshipMapping:[Customer reverseMappingServiceLocation] forProperty:@"service_locations" keyPath:@"service_locations_attributes"];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (FEMMapping *)reverseMappingServiceLocation {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[ServiceLocation entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[ServiceLocation class]] mutableCopy];
    
    [dict removeObjectForKey:@"lat"];
    [dict removeObjectForKey:@"lng"];
    [dict removeObjectForKey:@"customer_id"];
    
    [mapping addAttributesFromDictionary:dict];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

@end
