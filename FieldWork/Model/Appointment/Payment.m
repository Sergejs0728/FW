#import "Payment.h"
#import "CDHelper.h"

#import "NSManagedObject+Mapping.h"

@interface Payment ()

// Private interface goes here.

@end

@implementation Payment

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Payment entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[Payment class]] mutableCopy];
    
    [dict removeObjectForKey:@"amount"];
    [mapping addAttribute:[Payment floatAttributeFor:@"amount" andKeyPath:@"amount"]];
    
    [dict removeObjectForKey:@"payment_date"];
    [mapping addAttribute:[Payment dateTimeAttributeFor:@"payment_date" andKeyPath:@"payment_date"]];
    
    [mapping addAttributesFromDictionary:dict];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (Payment *)newPayment {
    Payment *payment = [Payment MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [payment setEntity_id:[NSNumber numberWithInt:[Utils RandomId]]];
    [payment setCreated_from_mobile:[NSNumber numberWithBool:YES]];
    [payment setPayment_date:[NSDate date2]];
//    [payment ]
    return payment;
}

@end
