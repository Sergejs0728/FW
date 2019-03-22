//
//  CustomerManager.m
//  FieldWork
//
//  Created by SAMCOM on 27/11/15.
//
//
#import "Customer.h"
#import "CustomerManager.h"
#import "Customer+Mapping.h"
#import "NSDictionary+Extension.h"
#import "Appointment.h"
#import "User.h"


@implementation CustomerManager

+ (instancetype) Instance {
    static CustomerManager *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[CustomerManager alloc] init];
    });
    return __sharedInstance;
}

- (NSUInteger) loadedCount
{
    return [[Customer getCustomers] count];
}

- (NSMutableArray *)getCustomersForAppointments:(NSMutableArray *)appointments {
    NSMutableArray *customerArray = [NSMutableArray array];
    for (Appointment *appointment in appointments) {
        Customer *customer = [appointment getCustomer];
        if (customer) [customerArray addObject:customer];
    }
    return customerArray;
}

- (void) loadCustomersAllWithBlock:(ItemLoadedBlock)block
{
    _itemLoadedBlock = block;
    NSMutableArray *records = [Customer getCustomers];
    if (records != nil && records.count > 0) {
        if (_itemLoadedBlock) {
            _itemLoadedBlock(records, nil);
        }
    }else{
        if ([[AppDelegate appDelegate] isReachable]) {
            [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
                [Customer MR_truncateAllInContext:localContext];
                FWRequest *request = [[FWRequest alloc] initWithUrl:API_ALL_CUSTOMER andDelegate:self];
                //            [request setParameter:@(1) forKey:API_PARAM_WITHOUT_CREDIT];
                request.Tag = API_ALL_CUSTOMER;
                [request startRequest];
            }];
        }
    }
}


- (void) loadCustomersWithBlock:(ItemLoadedBlock)block
{
    _itemLoadedBlock = block;
    NSMutableArray *records = [Customer getCustomers];
    if (records != nil && records.count > 0) {
        if (_itemLoadedBlock) {
            _itemLoadedBlock(records, nil);
        }
    }else{
        if ([[AppDelegate appDelegate] isReachable]) {
            [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
                [Customer MR_truncateAllInContext:localContext];
                FWRequest *request = [[FWRequest alloc] initWithUrl:API_ALL_CUSTOMER_THINNED andDelegate:self];
                //            [request setParameter:@(1) forKey:API_PARAM_WITHOUT_CREDIT];
                request.Tag = API_ALL_CUSTOMER_THINNED;
                [request startRequest];
            }];

        }
    }
}

- (void) loadCustomersWithIds: (NSMutableArray*)arr block:(ItemLoadedBlock)block
{
    
    NSMutableArray *records = [NSMutableArray array];
    for (NSNumber *customerId in arr) {
        Customer *customer = [Customer getById:customerId];
        if (customer) {
            [records addObject:customer];
        }
    }
    
    if (records != nil && records.count == arr.count) {
        _itemLoadedBlock = block;
        if (_itemLoadedBlock) {
            _itemLoadedBlock(records, nil);
        }
    }else{
        [self refreshCustomersWithIds:arr block:block];
    }
}

- (void) refreshCustomersWithIds: (NSMutableArray*)arr block:(ItemLoadedBlock)block
{

    if (arr.count) {
        NSMutableString *params = [NSMutableString string];
        for (NSNumber *customerId in arr) {
            if (customerId) {
                if (params.length) {
                    [params appendFormat:@"&cid[]=%@", customerId];
                } else {
                    [params appendFormat:@"cid[]=%@", customerId];
                }
            }
        }
        NSString *urlString = [NSString stringWithFormat:@"%@?%@&without_credit=1", API_ALL_CUSTOMER, params];
        [FWRequest requestWithURLPart:urlString method:GET dict:nil block:^(BOOL success, FWRequest *request) {
            if (success) {
//                [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"entity_id IN %@", arr];
                [Customer MR_deleteAllMatchingPredicate:predicate];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                NSArray *cstmrs = [FEMDeserializer collectionFromRepresentation:request.serverData mapping:[Customer defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                if (block) {
                    block(cstmrs, nil);
                }
//                }];
            } else {
                if (block) {
                    NSArray* customers=[Customer getCustomers];
                    block(customers, request.error.description);
                }
            }
        }];
    } else {
        if (block) {
            NSArray* customers=[Customer getCustomers];
            block(customers, nil);
        }
    }
}

- (void) refreshCustomersWithBlock:(ItemLoadedBlock)block
{
    _itemLoadedBlock = block;
    if ([[AppDelegate appDelegate] isReachable]) {
        FWRequest *request = [[FWRequest alloc] initWithUrl:API_ALL_CUSTOMER_THINNED andDelegate:self];
//        [request setParameter:@(1) forKey:API_PARAM_WITHOUT_CREDIT];
        request.Tag = API_ALL_CUSTOMER_THINNED;
        [request startRequest];
    }
}

-(void)clearAllCustomerandDevices{
    [Customer MR_truncateAll];
    [CustomerDevice MR_truncateAll];
}

- (void) addNewCustomer:(Customer*)cust withBlock:(ItemSavedBlock)block
{
    if (![[AppDelegate appDelegate] isReachable]) {
        block(self, NO, @"Internet connection is not available.");
    }
    
    _itemSavedBlock = block;
    
    NSMutableDictionary *dict = [[FEMSerializer serializeObject:cust usingMapping:[Customer reverseMappingCustomer]] mutableCopy];
    [dict removeObjectForKey:@"id"];
    [dict removeObjectForKey:@"payment_methods"];
    NSArray *slAttributes = dict[@"service_locations_attributes"];
    for (NSMutableDictionary *slaDict in slAttributes) {
        NSDictionary *addressDict = [NSDictionary dictionaryWithDictionary:slaDict[@"address"]];
        [slaDict removeObjectForKey:@"address"];
        slaDict[@"address_attributes"] = addressDict;
    }
//    dict = [dict replaceKeyName:@"address" with:@"address_attributes"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    if (dict) {
        
        NSString *url = url = [NSString stringWithFormat:API_CUSTOMER, cust.entity_id];;
        RequestMethod method = PUT;
        if ([cust.entity_id intValue] <= 0) {
            url = API_ALL_CUSTOMER;
            method = POST;
            dict = [[dict dictionaryByRemovingId] mutableCopy];
        }
        NSDictionary *main = @{@"customer":dict};
        
        [FWRequest requestWithURLPart:url method:method dict:main block:^(BOOL success, FWRequest *request) {
            if (success) {
                [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
                    NSDictionary *dict = [request.serverData objectForKey:@"customer"];
                    BOOL saved = YES;
                    @try {
                        [FEMDeserializer fillObject:cust fromRepresentation:dict mapping:[Customer defaultMapping]];
                    } @catch (NSException *exception) {
                        saved = NO;
                        [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                             @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                             @"Exception":exception.description,
                                                                             @"UserId":cust.entity_id,
                                                                             @"RequestTag":url,
                                                                             @"RequestMethod":method==POST ? @"POST" : @"PUT",
                                                                             @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                    } @finally {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (_itemSavedBlock) {
                                _itemSavedBlock(cust, saved, nil);
                            }
                        });
                    }
                }];
            } else {
                if (_itemSavedBlock) {
                    _itemSavedBlock(self, NO, [request.error.userInfo objectForKey:@"message"]);
                }
            }
        }];
        
        
    }
}


#pragma mark - FWRequestDelegate

- (void)RequestDidSuccess:(FWRequest *)request {
    if (request.IsSuccess) {
        if ([request.Tag isEqualToString:API_ALL_CUSTOMER_THINNED]) {
            [Customer MR_truncateAll];
            NSMutableArray *arr = request.serverData;
            _objectsCount = arr.count;
            NSInteger step = 50;
            for (NSInteger i=0; i<arr.count; i+=step) {
                NSMutableArray *ids = [NSMutableArray array];
                for (NSInteger j=i; (j<i+step & j<arr.count); j++) {
                    NSDictionary* dict = arr[j];
                    NSNumber *customerId = dict[@"id"];
                    if (customerId) {
                        [ids addObject:customerId];
                    }
                }
                [self refreshCustomersWithIds:ids block:_itemLoadedBlock];
            }
        }
        else if ([request.Tag isEqualToString:API_ALL_CUSTOMER]) {
            __block NSArray *cstmrs=[NSArray new];
//            [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
                cstmrs = [FEMDeserializer collectionFromRepresentation:request.serverData mapping:[Customer defaultMapping]context:[NSManagedObjectContext MR_defaultContext]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                    if (_itemLoadedBlock) {
                        _itemLoadedBlock(cstmrs, nil);
                    }
                });
//            }];          
        }
        
    }
}

- (void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error{
    if ([request.Tag isEqualToString:API_ALL_CUSTOMER_THINNED]) {
        NSMutableArray* records=[Appointment getAppointments];
        if (_itemLoadedBlock) {
            _itemLoadedBlock(records, error);
        }
    }
  
}

@end
