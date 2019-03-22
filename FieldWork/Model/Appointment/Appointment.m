#import "Appointment.h"
#import "AppointmentManager.h"
#import "Appointment+Mapping.h"
#import "Appointment+Helper.h"
#import "FWPDFForm.h"
#import "PhotoAttachment.h"
#import "Invoice.h"
#import "SyncManager.h"
#import "StageModel.h"

@interface Appointment ()
{
    AppointmentSavedBlock __saved_block;
    ItemSavedBlock __itemSavedBlock;
}
// Private interface goes here.

@end

@implementation Appointment

+ (NSString *)ServiceReportPath {
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    
    NSString *finalPath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",@"ServiceReport"]];
    return finalPath;
}

+ (NSMutableArray*) getAppointments
{
    return [[Appointment MR_findByAttribute:@"specific" withValue:[NSNumber numberWithBool:YES]] mutableCopy];
}

+(NSMutableArray *)getWorkOrderHistoryByServiceLocationId:(ServiceLocation *)ser_loc{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"starts_at < %@ AND service_location_id == %@",[NSDate date],ser_loc.entity_id];
    NSMutableArray *result= [[Appointment MR_findAllWithPredicate:predicate] mutableCopy];
    NSSortDescriptor *ageDescriptor = [[NSSortDescriptor alloc] initWithKey:@"starts_at" ascending:NO];
    NSArray *sortDescriptors = @[ageDescriptor];
    return  [[result sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
}

+ (NSMutableArray *)getWorkPoolAppointments{
    return [[Appointment MR_findByAttribute:@"specific" withValue:[NSNumber numberWithBool:NO]] mutableCopy];
}

+ (NSMutableArray *)getWorkPoolAppointmentsByDistance: (CLLocation *)currentLocation{
    NSMutableArray *arr =  [[Appointment MR_findByAttribute:@"specific" withValue:[NSNumber numberWithBool:NO]] mutableCopy];
    NSArray *filteredArray = [[NSArray alloc]init];
    filteredArray = [arr sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        ServiceLocation *s1 = [(Appointment *)a getServiceLocation];
        double firstLat = s1.latValue;
        double firstLong = s1.lngValue;
        
        ServiceLocation *s2 = [(Appointment *)b getServiceLocation];
        double secondLat = s2.latValue;
        double secondLong = s2.lngValue;
        
        CLLocation *houseLocation1 = [[CLLocation alloc] initWithLatitude:firstLat longitude:firstLong];
        CLLocationDistance meters1 = [houseLocation1 distanceFromLocation:currentLocation];
        
        CLLocation *houseLocation2 = [[CLLocation alloc] initWithLatitude:secondLat longitude:secondLong];
        CLLocationDistance meters2 = [houseLocation2 distanceFromLocation:currentLocation];
        
        if (meters1 < meters2) {
            return NSOrderedAscending;
        }else if (meters1 > meters2){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
    
    return [filteredArray mutableCopy];
}


// :: Arun Code
+ (NSMutableArray *)getWorkPoolAppointmentsByDistanceWithDate:(CLLocation *)currentLocation selectedDate:(NSDate *)s_Date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"MM/dd/yyyy"];
    NSString *myDate = [dateFormatter stringFromDate:s_Date];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"starts_at_date == %@",myDate];
    NSMutableArray *arr = [[Appointment MR_findAllWithPredicate:predicate] mutableCopy];
    
    NSArray *filteredArray = [[NSArray alloc]init];
    filteredArray = [arr sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        ServiceLocation *s1 = [(Appointment *)a getServiceLocation];
        double firstLat = s1.latValue;
        double firstLong = s1.lngValue;
        
        ServiceLocation *s2 = [(Appointment *)b getServiceLocation];
        double secondLat = s2.latValue;
        double secondLong = s2.lngValue;
        
        CLLocation *houseLocation1 = [[CLLocation alloc] initWithLatitude:firstLat longitude:firstLong];
        CLLocationDistance meters1 = [houseLocation1 distanceFromLocation:currentLocation];
        
        CLLocation *houseLocation2 = [[CLLocation alloc] initWithLatitude:secondLat longitude:secondLong];
        CLLocationDistance meters2 = [houseLocation2 distanceFromLocation:currentLocation];
        
        if (meters1 < meters2) {
            return NSOrderedAscending;
        }else if (meters1 > meters2){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
    return [filteredArray mutableCopy];
}

// :: Arun Code
+ (NSMutableArray *)getWorkPoolAppointmentsByDistanceWithDateRange:(CLLocation *)currentLocation fromDate:(NSDate *)f_Date toDate:(NSDate *)t_Date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"MM/dd/yyyy"];
    //    NSString *fromDate = [dateFormatter stringFromDate:f_Date];
    
    NSMutableArray *arr =  [[Appointment MR_findByAttribute:@"specific" withValue:[NSNumber numberWithBool:NO]] mutableCopy];
    NSLog(@"Arr= %@", [arr valueForKey:@"starts_at_date"]);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (Appointment* app in arr) {
        NSDate* appDate = [dateFormatter dateFromString:[app valueForKey:@"starts_at_date"]];
        
        if (([appDate compare:f_Date] != NSOrderedAscending)
            && ([appDate compare:t_Date] != NSOrderedDescending)) {
            [array addObject:app];
        }
    }
    //    NSMutableArray *arr = [[Appointment MR_findAllWithPredicate:predicate] mutableCopy];
    
    NSArray *filteredArray = [[NSArray alloc]init];
    filteredArray = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        ServiceLocation *s1 = [(Appointment *)a getServiceLocation];
        double firstLat = s1.latValue;
        double firstLong = s1.lngValue;
        
        ServiceLocation *s2 = [(Appointment *)b getServiceLocation];
        double secondLat = s2.latValue;
        double secondLong = s2.lngValue;
        
        CLLocation *houseLocation1 = [[CLLocation alloc] initWithLatitude:firstLat longitude:firstLong];
        CLLocationDistance meters1 = [houseLocation1 distanceFromLocation:currentLocation];
        
        CLLocation *houseLocation2 = [[CLLocation alloc] initWithLatitude:secondLat longitude:secondLong];
        CLLocationDistance meters2 = [houseLocation2 distanceFromLocation:currentLocation];
        
        if (meters1 < meters2) {
            return NSOrderedAscending;
        }else if (meters1 > meters2){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
    return [filteredArray mutableCopy];
}

+(CLLocationDistance)getDistanceForAppointment:(NSNumber *)app_id andCurrentLocation:(CLLocation *)currentLocation{
    Appointment *app = [Appointment getById:app_id];
    ServiceLocation * sl = [app getServiceLocation];
    CLLocationDegrees lat = sl.latValue;
    CLLocationDegrees lng = sl.lngValue;
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lng);
    CLLocation *houseLocation = [[CLLocation alloc] initWithCoordinate: coord altitude:1 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:[NSDate date]];
    CLLocationDistance meters = [houseLocation distanceFromLocation:currentLocation];
    return meters;
}

+ (Appointment*) getById:(NSNumber*)appt_id
{
    return [Appointment MR_findFirstByAttribute:@"entity_id" withValue:appt_id];
}

-(NSMutableArray *)getServiceRoutesByServiceRoutesId:(int)ServiceRoutesId{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (NSMutableArray*) getAppointmentsForDate:(NSDate*) date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay) fromDate:[date changeTimeZoneToUtc]];
    //create a date with these components
    NSDate *startDate = [calendar dateFromComponents:components];
    [components setDay:1];
    [components setMonth:0];
    [components setYear:0];
    NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"starts_at >= %@ AND starts_at < %@ AND specific == %@", [startDate changeTimeZoneToLocal], [endDate changeTimeZoneToLocal], @(YES)];
    NSMutableArray *arr = [[Appointment MR_findAllWithPredicate:predicate] mutableCopy];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"starts_at" ascending:YES];
    [arr sortUsingDescriptors:[NSArray arrayWithObject:sorter]];
    return arr;
    //        NSMutableArray *temp = [[NSMutableArray alloc] init];
    //        NSMutableArray *arr = [Appointment getAppointments];
    //        NSNumber *suplied_date = [NSNumber numberWithInt:[date dateCompareValue]];
    //        for (Appointment *appt in arr) {
    //            if ([suplied_date isEqualToNumber:[NSNumber numberWithInt:[appt.starts_at dateCompareValue]]]) {
    //                [temp addObject:appt];
    //            }
    //        }
    //        // :: To sort the temp array with respect to the time in ascending order
    //        NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"starts_at" ascending:YES];
    //        [temp sortUsingDescriptors:[NSArray arrayWithObject:sorter]];
    //        return temp;
}

+(Appointment *)newEntity{
    Appointment *appt = [Appointment MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [appt setEntity_id:[NSNumber numberWithInt:[Utils RandomId]]];
    [appt setEntity_status:c_ADDED];
    return appt;
}

+(BOOL)isFoundDirty{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"entity_status == %@",c_EDITED];
    NSArray *arr = [Appointment MR_findAllWithPredicate:predicate];
    if (arr.count == 0) {
        return false;
    }
    return true;
}

- (BOOL)hasDirtyAttachments {
    NSInteger dirtyCount = 0;
    NSArray *dirtyAttachments = [PDFAttachment getDirtyForAppointmentId:self.entity_id];
    dirtyCount += dirtyAttachments.count;
    NSArray *dirtyPhotos = [PhotoAttachment getDirtyForAppointmentId:self.entity_id];
    dirtyCount += dirtyPhotos.count;
    NSArray *dirtyDiagrams = [StageModel getDirtyForServiceLocation:[self getServiceLocation]];
    dirtyCount += dirtyDiagrams.count;
    return dirtyCount > 0;
}

- (void)addIdToPDFForms {
    for (FWPDFForm *form in [self.pdf_forms allObjects]) {
        form.appointment_id = self.entity_id;
    }
}

- (Customer *)getCustomer {
    return [Customer MR_findFirstByAttribute:@"entity_id" withValue:self.customer_id];
}

- (ServiceLocation*) getServiceLocation
{
    return [ServiceLocation MR_findFirstByAttribute:@"entity_id" withValue:self.service_location_id];
}

+(Appointment *)getAppointmentByServiceLocationId:(NSNumber *)service_loc_id{
    return [Appointment MR_findFirstByAttribute:@"service_location_id" withValue:service_loc_id];
}

- (NSString*)getDuration
{
    return [Utils getTimeString:[self.duration intValue]];
}

- (float)getTotalServicePrice {
    float total = 0.0;
    if (self.line_items) {
        if (self.line_items.count > 0) {
            for (LineItem *info in self.line_items) {
                if (![info.entity_status isEqualToNumber:c_DELETED]) {
                    total = total + [info.total floatValue];
                }
            }
        }
    }
    
    return total;
    
}


-(float)getTaxableLineItemPrice{
    float total = 0.0;
    if (self.line_items) {
        if (self.line_items.count > 0) {
            for (LineItem *info in self.line_items) {
                if (![info.entity_status isEqualToNumber:c_DELETED]) {
                    if ([info.taxable boolValue]) {
                        total = total + [info.total floatValue];
                    }
                }
            }
        }
    }
    NSString *value = [NSString stringWithFormat:@"%.02f", total];
    total = [value floatValue];

    
    return total;
}



- (float) getFinalTotalDue
{
    ServiceLocation *ser_loc = [self getServiceLocation];
    float total_due = 0.0;
    if (!self.hide_invoice_informationValue) {
        float total = [self getTotalServicePrice];
        float discount_amount = ((total * self.discountValue) / 100);
        total_due = (total - discount_amount) + self.tax_amountValue;
        if (self.specificValue && !ser_loc.hide_balanceValue) {
            total_due = total_due + self.balance_forwardValue;
        }
    }
    
//    NSString *value = [NSString stringWithFormat:@"%.02f", total_due];
    
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.numberStyle = NSNumberFormatterDecimalStyle;
//    formatter.maximumFractionDigits = 2;
//    formatter.roundingMode = NSNumberFormatterRoundUp;
//    NSString *value = [formatter stringFromNumber:[NSNumber numberWithFloat:total_due]];
//    
//    total_due = [formatter numberFromString:value].floatValue;
    
    
    return total_due;
}

- (void) markAppointmentAsUnchaged
{
    [self setEntity_status:c_UNCHANGED];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)calculateTaxAmountForOwnTaxtRate:(BOOL)forOwnTaxRate
{
    if (forOwnTaxRate) {
        [self calculateTax:self.tax_rate];
    } else {
        ServiceLocation *ser_location = [self getServiceLocation];
        if (ser_location.tax_rate_id != 0) {
            TaxRates * trate = [TaxRates getTaxRatesById:ser_location.tax_rate_id];
            if (trate) {
                [self calculateTax:trate];
            }
        }
    }
}

-(void)calculateTax:(TaxRates*)trate {
    float taxamount = 0.00;
    
    for (LineItem * lineItem in self.line_items) {
        if (![lineItem.entity_status isEqualToNumber:c_DELETED])
        {
            float p = lineItem.totalValue;
            float tax = 0;
            float disc = (p * self.discountValue) / 100;
            p = p - disc;
            if (lineItem.taxableValue && trate) {
                tax = p * trate.rateValue;
                taxamount = taxamount + tax;
            }
        }
    }
    [self setTax_rate_id:trate.entity_id];
    
//    // Remove 0.0000001
//    
//    NSString *value = [NSString stringWithFormat:@"%.02f", taxamount];
//    taxamount = [value floatValue];
    
    [self setTax_amount:@(taxamount)];
    if (self.invoice) {
        [self.invoice setTax_amount:@(taxamount)];
    }
}

- (void) saveAppointmentOnLocal
{
    [self setEntity_status:c_EDITED];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
}

- (void) saveAppointmentOnServerWithBlock:(AppointmentSavedBlock)save_block
{
    self.is_sync=@(YES);
    [self setStarts_at_date:[Utils dateFormatMMddyyyy:[[NSDate date] changeTimeZoneToLocal]]];
    __saved_block = save_block;
    NSMutableDictionary *json = [self buildJson];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    RequestMethod method = PUT;
    NSString *url = [NSString stringWithFormat:API_WORK_ORDER, self.entity_id];
    NSDictionary *main = @{@"work_order":json};
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:main
                                                        options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                          error:nil];
    
    NSString *jsonString2 = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    FWRequest *request = [[FWRequest alloc] initWithUrl:url andDelegate:self andMethod:method];
    request.Tag = API_WORK_ORDERS;
    [request setPostParameters:[main mutableCopy]];
    NSInteger countWait = 0;
    countWait += [[SyncManager Instance] syncPlans];
    countWait += [[SyncManager Instance] syncPhotos];
    countWait += [[SyncManager Instance] syncPDFAttachments];
    countWait += [[SyncManager Instance] syncTraps];
//    [[SyncManager Instance] startSync];
    //TODO: (temp solution) give time for saving pdf attachments
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(countWait * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [request startRequest];
    });
    
}

- (void) saveWorkPoolAppointmentOnServerWithBlock:(AppointmentSavedBlock)save_block
{
    self.is_sync=@(YES);
    __saved_block = save_block;
    NSMutableDictionary *json = [self workPoolWordOrderJson];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    RequestMethod method = PUT;
    NSString *url = [NSString stringWithFormat:API_WORK_ORDER, self.entity_id];
    NSDictionary *main = @{@"force_update_time":[NSNumber numberWithBool:YES],@"work_order":json};
    FWRequest *request = [[FWRequest alloc] initWithUrl:url andDelegate:self andMethod:method];
    request.Tag = API_WORK_ORDERS;
    [request setPostParameters:[main mutableCopy]];
    [request startRequest];
}

- (void)addNewWorkOrderWithBklock:(ItemSavedBlock)block {
    self.is_sync=@(YES);
    __itemSavedBlock = block;
    
    NSMutableDictionary *json = [self newWordOrderJson];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    RequestMethod method = POST;
    NSString *url = API_WORK_ORDERS;
    
    NSDictionary *main = @{@"work_order":json};
    FWRequest *request = [[FWRequest alloc] initWithUrl:url andDelegate:self andMethod:method];
    request.Tag = ADD_NEW_WORK_ORDER_TAG;
    [request setPostParameters:[main mutableCopy]];
    [request startRequest];
    
}

#pragma mark - FWRequestDelegate

- (void)RequestDidSuccess:(FWRequest *)request {
    self.is_sync=@(NO);
    if (request.IsSuccess) {
        if ([request.Tag isEqualToString:API_WORK_ORDERS] && request.methodType == PUT) {
            NSDictionary *dict = request.serverData;
            if (dict == nil) {
                if (__saved_block) {
                    __saved_block(NO, self.entity_id);
                }
                return;
            }
            NSDictionary *work_order = [dict objectForKey:@"work_order"];
//                        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            
            NSManagedObjectContext* localContext=[NSManagedObjectContext MR_defaultContext];
            Appointment *app = [self MR_inContext:localContext];
            [localContext MR_deleteObjects:app.inspection_records];
            [localContext MR_deleteObjects:app.material_usages];
            [localContext MR_deleteObjects:app.line_items];

            [localContext MR_deleteObjects:app.unit_records];
            // Delete only deleted object from local database, added and edited records will be updated - see PhotoAttachment class for understanding.
            [localContext MR_deleteObjects:[app.photo_attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                PhotoAttachment *pa = (PhotoAttachment*)evaluatedObject;
                if ([pa.entity_status isEqualToNumber:c_DELETED]) {
                    return YES;
                }
                return NO;
            }]]];
            [localContext MR_saveToPersistentStoreAndWait];
            
            //            } completion:^(BOOL contextDidSave, NSError *error) {
            BOOL saved = YES;

            // Delete only deleted object from local database, added and edited records will be updated - see PhotoAttachment class for understanding.
            @try {
                [FEMDeserializer fillObject:self fromRepresentation:work_order mapping:[Appointment defaultMapping]];
                [self addIdToPDFForms];
                [localContext MR_saveToPersistentStoreAndWait];
                
            } @catch (NSException *exception) {
                saved = NO;
                [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                     @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                     @"Exception":exception.description,
                                                                     @"UserId":self.entity_id,
                                                                     @"RequestTag":API_WORK_ORDERS,
                                                                     @"RequestMethod":@"PUT",
                                                                     @"ServerDataClass":NSStringFromClass([request.serverData class])}];
            } @finally {
//            [localContext MR_deleteObjects:[app.photo_attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
//                PhotoAttachment *pa = (PhotoAttachment*)evaluatedObject;
//                if ([pa.entity_status isEqualToNumber:c_DELETED]) {
//                    return YES;
//                }
//                return NO;
//            }]]];
                [PhotoAttachment removeDeleteAttachmentsForAppontment:app];
            [localContext MR_saveToPersistentStoreAndWait];
            
            //            } completion:^(BOOL contextDidSave, NSError *error) {
                            self.error_sync_message = @"";
//                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                if (__saved_block) {
                    __saved_block(saved, self.entity_id);
                }
            }
            //            }];
        }
        if ([request.Tag isEqualToString:ADD_NEW_WORK_ORDER_TAG]) {
            NSDictionary *dict = request.serverData;
            NSDictionary *work_order = [dict objectForKey:@"work_order"];
            NSManagedObjectContext* localContext=[NSManagedObjectContext MR_defaultContext];
            //            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            Appointment *app = [self MR_inContext:localContext];
            [localContext MR_deleteObjects:app.inspection_records];
            [localContext MR_deleteObjects:app.material_usages];
            [localContext MR_deleteObjects:app.unit_records];
            [localContext MR_deleteObjects:app.line_items];
            // Delete only deleted object from local database, added and edited records will be updated - see PhotoAttachment class for understanding.
//            [localContext MR_deleteObjects:[app.photo_attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
//                PhotoAttachment *pa = (PhotoAttachment*)evaluatedObject;
//                if ([pa.entity_status isEqualToNumber:c_DELETED]) {
//                    return YES;
//                }
//                return NO;
//            }]]];
            [PhotoAttachment removeDeleteAttachmentsForAppontment:app];
            //            } completion:^(BOOL contextDidSave, NSError *error) {
            [localContext MR_saveToPersistentStoreAndWait];
            BOOL saved = YES;
            @try {
                [FEMDeserializer fillObject:self fromRepresentation:work_order mapping:[Appointment defaultMapping]];
                [self addIdToPDFForms];
            } @catch (NSException *exception) {
                saved = NO;
                [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                     @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                     @"Exception":exception.description,
                                                                     @"UserId":self.entity_id,
                                                                     @"RequestTag":ADD_NEW_WORK_ORDER_TAG,
                                                                     @"RequestMethod":@"POST",
                                                                     @"ServerDataClass":NSStringFromClass([request.serverData class])}];
            } @finally {
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                if (__itemSavedBlock) {
                    __itemSavedBlock(self, saved, nil);
                }
            }
            //            }];
        }
    }else{
        if ([request.Tag isEqualToString:API_WORK_ORDERS] && request.methodType == PUT) {
            if (__saved_block) {
                __saved_block(YES, self.entity_id);
            }
        }
        
        if ([request.Tag isEqualToString:ADD_NEW_WORK_ORDER_TAG]) {
            if (__itemSavedBlock) {
                __itemSavedBlock(self, NO, @"Could not save your work order, please try again.");
            }
        }
    }
}

-(void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error{
    self.is_sync=@(NO);
    if ([request.Tag isEqualToString:API_WORK_ORDERS] && request.methodType == PUT) {
        self.error_sync_message = error;
        [self markAppointmentAsUnchaged];
        
        UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        if (__saved_block) {
            __saved_block(NO, self.entity_id);
        }
    }
    
    if ([request.Tag isEqualToString:ADD_NEW_WORK_ORDER_TAG]) {
        if (__itemSavedBlock) {
            __itemSavedBlock(nil, NO, @"Could not save your work order, please try again.");
        }
    }
}

-(void)showAlert:(NSString *)error{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
