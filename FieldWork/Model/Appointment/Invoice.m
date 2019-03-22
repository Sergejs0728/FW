#import "Invoice.h"
#import "CDHelper.h"
#import "NSManagedObject+Mapping.h"

#import "Payment.h"

@interface Invoice ()

// Private interface goes here.

@end

@implementation Invoice

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Invoice entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[Invoice class]] mutableCopy];
    
    [mapping addToManyRelationshipMapping:[Payment defaultMapping] forProperty:@"payments" keyPath:@"payments"];
    
    [dict removeObjectForKey:@"tax_amount"];
    [mapping addAttribute:[Invoice floatAttributeFor:@"tax_amount" andKeyPath:@"tax_amount"]];
    
    [dict removeObjectForKey:@"total"];
    [mapping addAttribute:[Invoice floatAttributeFor:@"total" andKeyPath:@"total"]];
    
    [dict removeObjectForKey:@"discount_amount"];
    [mapping addAttribute:[Invoice floatAttributeFor:@"discount_amount" andKeyPath:@"discount_amount"]];
    
    [dict removeObjectForKey:@"amount"];
    [mapping addAttribute:[Invoice floatAttributeFor:@"amount" andKeyPath:@"amount"]];
    
    [mapping addAttributesFromDictionary:dict];
    
    return mapping;
}

- (Payment*) getMobilePayment
{
    NSPredicate *pre = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        Payment *payment = (Payment*) evaluatedObject;
        if ([payment.created_from_mobile isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            return YES;
        }
        return NO;
    }];
    NSSet *temp = [self.payments filteredSetUsingPredicate:pre];
    if ([temp allObjects].count > 0) {
        return [[temp allObjects] objectAtIndex:0];
    }
    return nil;
}

+ (Invoice*) invoiceWithAppointment:(Appointment*)app
{
    Invoice *inv = [Invoice MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [inv setAppointment:app];
    return inv;
}

@end
