#import "CustomerDevice.h"
#import "CDHelper.h"
#import "InspectionRecord.h"

@interface CustomerDevice ()
{
    ItemSavedBlock __save_block;
}


@end

@implementation CustomerDevice

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[CustomerDevice entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[CustomerDevice class]] mutableCopy];
    
    [mapping addAttributesFromDictionary:dict];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (FEMMapping*)reverseMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[CustomerDevice entityName]];
    NSDictionary *dict = @{@"barcode" : @"barcode", @"building" : @"building", @"floor" : @"floor", @"location_details" : @"location_details", @"trap_type_id" :@"trap_type_id", @"number" : @"number"};
    [mapping addAttributesFromDictionary:dict];
    return mapping;
}

+ (CustomerDevice*) newDeviceForCustomer:(NSNumber*)customer_id forServiceLocaiton:(NSNumber*)service_location_id
{
    ServiceLocation *ser = [ServiceLocation getById:service_location_id];
    
    CustomerDevice *device = [CustomerDevice MR_createEntity];
    [device setEntity_idValue:[Utils RandomId]];
    [device setEntity_status:c_ADDED];
    [device setCustomer_id:customer_id];
    [device setService_location_id:service_location_id];
    // If you dont add device in service location, you can not get record by service_location.devices
    if (ser) {
        [ser addDevicesObject:device];
    }
    
    return device;
}

+ (CustomerDevice *)deviceByBarcode:(NSNumber *)barcode_no{
    return [CustomerDevice MR_findFirstByAttribute:@"barcode" withValue:barcode_no];
}

+ (NSMutableArray*) devicesByServiceLocationId:(NSNumber*) service_location_id
{
    return [[CustomerDevice MR_findByAttribute:@"service_location_id" withValue:service_location_id] mutableCopy];
}

+ (CustomerDevice *)deviceByBarcode:(NSString *)barcode_no andService_location:(NSNumber*)ser_loc_id {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"barcode==%@ AND service_location_id=%@",barcode_no,ser_loc_id];
    return [CustomerDevice MR_findFirstWithPredicate:pre];
}

+ (CustomerDevice *)deviceByBarcode:(NSString *)barcode_no andService_location:ser_loc_id inContext:(NSManagedObjectContext*)context {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"barcode==%@ AND service_location_id=%@",barcode_no,ser_loc_id];
    return [CustomerDevice MR_findFirstWithPredicate:pre inContext:context];
}

+ (NSArray*)devicesForSync
{
//    NSArray *traps = [CustomerDevice MR_findAllInContext:[NSManagedObjectContext MR_defaultContext]];
//    traps = [traps filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"entity_status == %@ OR entity_status == %@", c_ADDED, c_EDITED]];
    NSArray *results = [results filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        CustomerDevice *trap = (CustomerDevice *) evaluatedObject;
        if ([trap.entity_status isEqual:c_EDITED]) {
            return YES;
        }
        if ([trap.entity_status isEqual:c_ADDED]) {
            InspectionRecord *record = [InspectionRecord MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"barcode==%@", trap.barcode]];
            return record==nil;
        }
        return NO;
    }]];
    return results;
}

- (void) saveCustomerDevicetOnLocal
{
    
    [self setEntity_status:c_ADDED];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    
}


- (void) saveCustomerDeviceToServer:(ItemSavedBlock)block
{
    __save_block = block;
    NSMutableDictionary *json = [FEMSerializer serializeObject:self usingMapping:[CustomerDevice reverseMapping]].mutableCopy;
    
    NSString *url = [NSString stringWithFormat:API_SAVE_CUSTOMER_DEVICE, self.customer_idValue, self.service_location_idValue];
    RequestMethod method = POST;
    NSString *tag = API_SAVE_CUSTOMER_DEVICE;
    if (self.entity_idValue > 0) {
        method = PUT;
        url = [NSString stringWithFormat:API_UPDATE_CUSTOMER_DEVICE, self.customer_idValue, self.service_location_idValue, self.entity_idValue];
        tag = API_UPDATE_CUSTOMER_DEVICE;
        json[@"id"] = self.entity_id;
    }
    FWRequest *request = [[FWRequest alloc] initWithUrl:url andDelegate:self andMethod:method];
    request.Tag = tag;
    [request setPostParameters:[json mutableCopy]];
    [request startRequest];
}

#pragma mark - FWRequestDelegate
- (void)RequestDidSuccess:(FWRequest *)request {
    if ([request.Tag isEqualToString:API_SAVE_CUSTOMER_DEVICE] || [request.Tag isEqualToString:API_UPDATE_CUSTOMER_DEVICE]) {
        if (request.IsSuccess) {
            if (self.entity_idValue <= 0) {
                [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
                    [FEMDeserializer fillObject:self fromRepresentation:request.serverData mapping:[CustomerDevice defaultMapping]];
                }];
            } else {
                self.entity_status = c_UNCHANGED;
                [self.managedObjectContext MR_saveOnlySelfAndWait];
            }
            if (__save_block) {
                __save_block(self, YES, nil);
            }
        } else {
            if (__save_block) {
                __save_block(nil, NO, [request errorMessageFromError:request.error]);
            }
        }
        
    }
}

- (void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error {
    if (__save_block) {
        __save_block(nil, NO, [request errorMessageFromError:request.error]);
    }
}

@end
