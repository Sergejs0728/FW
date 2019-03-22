#import "Customer.h"
#import "CDHelper.h"
#import "NSManagedObject+Mapping.h"


@interface Customer ()

// Private interface goes here.

@end

@implementation Customer

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Customer entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[Customer class]] mutableCopy];
    
    [dict removeObjectForKey:@"lat"];
    [dict removeObjectForKey:@"lng"];
    [dict removeObjectForKey:@"balance"];
    
    [mapping addAttributesFromDictionary:dict];
    
    [mapping addToManyRelationshipMapping:[ServiceLocation defaultMapping] forProperty:@"service_locations" keyPath:@"service_locations"];

    [mapping addAttribute:[Customer doubleAttributeFor:@"lat" andKeyPath:@"lat"]];
    [mapping addAttribute:[Customer doubleAttributeFor:@"lng" andKeyPath:@"lng"]];
    [mapping addAttribute:[Customer floatAttributeFor:@"balance" andKeyPath:@"balance"]];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

- (NSString *)getDisplayName {
    if ([self.customer_type isEqualToString:@"Commercial"]) {
        //NSLog(@"Name = %@", self.name);
        return self.name;
    }else {
        NSMutableString *nameString = [NSMutableString string];
        NSString *nm = @"Loading...";
        [nameString appendString:[self.first_name isEqual: [NSNull null]] || self.first_name==nil ? @"" : self.first_name];
        [nameString appendFormat:@" %@", [self.last_name isEqual: [NSNull null]] || self.last_name==nil ? @"" : self.last_name];
        
        if (self.name_prefix.length > 0) {
            nm = [NSString stringWithFormat:@"%@ %@", self.name_prefix, nameString];
        } else if (self.first_name || self.last_name) {
            nm = [NSString stringWithFormat:@"%@", nameString];
        }
        
        return nm;
    }
}

- (BOOL) isHavingCreditCardStored
{
    BOOL found = NO;
    NSMutableArray *arr = [self.payment_methods mutableCopy];
    for (NSDictionary *dict in arr) {
        NSString *val = [dict objectForKey:@"value"];
        if (val && ![val isEqual:[NSNull null]]) {
            if ([val rangeOfString:@"stripe"].location != NSNotFound) {
                found = YES;
                break;
            }
        }
    }
    return found;
}

+ (Customer *)getById:(NSNumber *)cust_id {
    return [Customer MR_findFirstByAttribute:@"entity_id" withValue:cust_id];
}

+(Customer *)newEntity{
    Customer *cust = [Customer MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [cust setEntity_status:c_ADDED];
    return cust;
}

- (NSString *)getBillingFullAddress {
    NSMutableArray *aarr = [[NSMutableArray alloc] init];
    if (self.billing_suite) [aarr addObject:self.billing_suite];
    if (self.billing_street) [aarr addObject:self.billing_street];
    if (self.billing_street2) [aarr addObject:[NSString stringWithFormat:@"%@%@", self.billing_street2, @"\n"]];
    if (self.billing_city) [aarr addObject:self.billing_city];
    if (self.billing_state) [aarr addObject:self.billing_state];
    if (self.billing_zip) [aarr addObject:self.billing_zip];
    
    return [aarr joinWithDelimeter:@","];
}

- (void) addNewPaymentMethod:(NSString*)stripe_tocken withBlock:(ItemSavedBlock)block
{
    NSDictionary *dict = @{@"stripe_card_token":stripe_tocken};
    NSString *url = [NSString stringWithFormat:API_PAYMENT_METHOD, [self.entity_id intValue]];
    [FWRequest requestWithURLPart:url method:POST dict:dict block:^(BOOL success, FWRequest *request) {
        if (success) {
            [self setPayment_methods:request.serverData];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            block(self, YES, nil);
        } else {
            block(self, NO, @"Could not upload your card information.");
        }
    }];
}

+ (NSMutableArray *)getCustomers{
     return [[Customer MR_findAll] mutableCopy];
}

- (NSString *) sortingName{
    if ([self.customer_type isEqualToString:@"Commercial"]) {
        //NSLog(@"Name = %@", self.name);
        return self.name;
    }else {
//        NSString *nm = [NSString stringWithFormat:@"%@ %@", self.first_name, self.last_name];
        NSString *nm = self.last_name;
//        if (self.name_prefix.length > 0) {
//            nm = [NSString stringWithFormat:@"%@ %@", self.name_prefix, nm];
//        }
//        
        return nm;
    }
}

+ (void)retriveCustomer:(NSNumber *)cust_id withBlock:(ItemLoadedBlock)block {
    NSString *url = [NSString stringWithFormat:API_CUSTOMER, cust_id];
    
    [FWRequest requestWithURLPart:url method:GET dict:nil block:^(BOOL success, FWRequest *request) {
        if (success) {
            NSDictionary *main = request.serverData;
            __block NSDictionary *customer = [main objectForKey:@"customer"];
            __block Customer *cust = nil;
//            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                @try {
                    cust = [FEMDeserializer objectFromRepresentation:customer mapping:[Customer defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }
                @catch (NSException *exception) {
                    [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                         @"Method":NSStringFromSelector(@selector(retriveCustomer:withBlock:)),
                                                                         @"Exception":exception.description,
                                                                         @"UserId":cust.entity_id,
                                                                         @"RequestTag":url,
                                                                         @"RequestMethod":@"GET",
                                                                         @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                }

                
//            } completion:^(BOOL contextDidSave, NSError *error) {
                if (block) {
                    block(cust, nil);
                }
                [cust loadPaymentMethods:nil];
//            }];
        }else {
            if (block) {
                block(self, request.error.description);
            }
        }
    }];
}

- (void) loadPaymentMethods:(ItemLoadedBlock)block
{
    NSString *URL = [NSString stringWithFormat:API_CUSTOMER_PAYMENT_METHODS, self.entity_id];
    
    [FWRequest requestWithURLPart:URL method:GET dict:nil block:^(BOOL success, FWRequest *request) {
        if (success) {
            if ([request.serverData isKindOfClass:[NSArray class]]) {
                NSArray *arr = request.serverData;
                [self setPayment_methods:arr];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
            if (block) {
                block(self, nil);
            }
        }else {
            if (block) {
                block(self, request.error.description);
            }
        }
    }];
}

@end
