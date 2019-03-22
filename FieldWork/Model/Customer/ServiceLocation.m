#import "ServiceLocation.h"

#import "Appointment.h"
#import "Appointment+Mapping.h"
#import "CDHelper.h"
#import "FWPDFForm.h"
#import "StageModel.h"
#import "PhotoAttachment.h"
#import "PDFAttachment.h"
#import "NSManagedObject+Mapping.h"
#import "NSString+Extension.h"
#import "StageModel.h"
#import "Unit.h"

@interface ServiceLocation ()<FWRequestDelegate>
{
    WorkOrderHistoryLoadedBlock _WorkOrderLoadedBlock;
}
// Private interface goes here.

@end

@implementation ServiceLocation

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[ServiceLocation entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[ServiceLocation class]] mutableCopy];
    
    [dict removeObjectForKey:@"address.lat"];
    [dict removeObjectForKey:@"address.lng"];
    [dict removeObjectForKey:@"hide_balance"];
    
    [mapping addAttributesFromDictionary:dict];
    
    [mapping addToManyRelationshipMapping:[Contact defaultMapping] forProperty:@"contacts" keyPath:@"contacts"];
    [mapping addToManyRelationshipMapping:[CustomerDevice defaultMapping] forProperty:@"devices" keyPath:@"devices"];
    
    [mapping addAttribute:[ServiceLocation doubleAttributeFor:@"lat" andKeyPath:@"address.lat"]];
    [mapping addAttribute:[ServiceLocation doubleAttributeFor:@"lng" andKeyPath:@"address.lng"]];
    [mapping addAttribute:[ServiceLocation boolAttributeFor:@"hide_balance" andKeyPath:@"hide_balance"]];
    [mapping addToManyRelationshipMapping:[StageModel defaultMapping] forProperty:@"floors" keyPath:@"floor_plans"];
    [mapping addToManyRelationshipMapping:[Unit defaultMapping] forProperty:@"flats" keyPath:@"flats"];

    mapping.primaryKey = @"entity_id";

    return mapping;
}
+(ServiceLocation *)newEntityWithCustomer:(Customer*)cust{
    ServiceLocation *ser_loc = [ServiceLocation MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [ser_loc setCustomer:cust];
    [cust addService_locationsObject:ser_loc];
    return ser_loc;
}

- (void)loadWorkHistory:(WorkOrderHistoryLoadedBlock)block
{
    _WorkOrderLoadedBlock = block;
    NSMutableArray *records = [Appointment getWorkOrderHistoryByServiceLocationId:self];
    if (records != nil && records.count >0) {
        if (_WorkOrderLoadedBlock) {
            _WorkOrderLoadedBlock(records,nil);
        }
    }
    if ([[AppDelegate appDelegate] isReachable])
    {
        NSString *url = [NSString stringWithFormat:API_WORK_ORDER_HISTORY,[self.customer_id intValue],[self.entity_id intValue]];
        url = [url URLStringByAppendingQueryString:[NSString stringWithFormat:@"start_date=%@&end_date=%@",[NSDate systemDateWithFormatter:MMDDYYYY AddingDay:0],[NSDate systemDateWithFormatter:MMDDYYYY AddingDay:-100]]];
        FWRequest *request = [[FWRequest alloc] initWithUrl:url andDelegate:self];
        request.Tag = API_WORK_ORDER_HISTORY;
        [request startRequest];
    }
}

- (NSString *)getFullAddress {
    
    NSString *finalAddress= @"";
    NSString *street_two = self.street2;
    if ([self.street isEqualToString:self.street2]) {
        street_two = @"";
    }
    
    if (self.street && self.street.length > 0) {
        finalAddress = [NSString stringWithFormat:@"%@",self.street];
    }
    
    if (self.street2 && self.street2.length > 0) {
        finalAddress = [NSString stringWithFormat:@"%@%@%@", finalAddress, finalAddress.length > 0 ? @"\n" : @"" ,street_two];
    }
    if (self.city && self.city.length > 0) {
        finalAddress = [NSString stringWithFormat:@"%@\n%@", finalAddress, self.city];
    }
    if (self.state && self.state.length > 0) {
        finalAddress = [NSString stringWithFormat:@"%@, %@", finalAddress, self.state];
    }
    if (self.zip && self.zip.length > 0) {
        finalAddress = [NSString stringWithFormat:@"%@ %@", finalAddress, self.zip];
    }
    return finalAddress;
}

+ (ServiceLocation *)getById:(NSNumber *)ser_id {
    return [ServiceLocation MR_findFirstByAttribute:@"entity_id" withValue:ser_id];
}

#pragma mark - FWRequestDelegate
-(void)RequestDidSuccess:(FWRequest *)request{
    if ([request.Tag isEqual:API_WORK_ORDER_HISTORY]) {
//        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            NSMutableArray *arr = request.serverData;
            NSMutableArray *appts = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in arr) {
                int app_id = [[dict objectForKey:@"id"] intValue];
                Appointment *app = [Appointment MR_findFirstByAttribute:@"entity_id" withValue:[NSNumber numberWithInt:app_id]];
                @try {
                    if (app) {
                        if ([app.entity_status isEqualToNumber:c_UNCHANGED]) {
                            Appointment *temp = [FEMDeserializer objectFromRepresentation:dict mapping:[Appointment defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
                            [temp addIdToPDFForms];
                            [temp setEntity_status:c_UNCHANGED];
                            [appts addObject:temp];
                            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                        }
                    } else {
                        Appointment *temp = [FEMDeserializer objectFromRepresentation:dict mapping:[Appointment defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
                        [temp setEntity_status:c_UNCHANGED];
                        [temp addIdToPDFForms];
                        [appts addObject:temp];
                        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

                    }
                } @catch (NSException *exception) {
                    [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                         @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                         @"Exception":exception.description,
                                                                         @"UserId":self.entity_id,
                                                                         @"RequestTag":request.Tag,
                                                                         @"RequestMethod":@"GET",
                                                                         @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                } @finally {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (_WorkOrderLoadedBlock) {
                            _WorkOrderLoadedBlock(appts, nil);
                        }
                    });
                }
            }
            
//        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *appointments = [Appointment getAppointments];
            for (Appointment *appt in appointments) {
                if (![appt.entity_status isEqualToNumber:c_UNCHANGED]) {
                    continue;
                }
                if (appt.pdf_forms.count > 0) {
                    for (FWPDFForm *pdf in [appt.pdf_forms allObjects]) {
                        [pdf downloadWithAppointment:appt];
                    }
                }
                if (appt.photo_attachments.count > 0) {
                    for (PhotoAttachment *pa in [appt.photo_attachments allObjects]) {
                        [pa downloadWithCompletionHandler:nil];
                    }
                }
                if (appt.attachments.count > 0) {
                    for (PDFAttachment *attachment in appt.attachments) {
                        [attachment download];
                    }
                }
                //                [[appt getCustomer] loadPaymentMethods:nil];
            }
        });
        
    }
}


-(void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error{
    if (_WorkOrderLoadedBlock) {
        _WorkOrderLoadedBlock(nil,error);
    }
}



//- (void) uploadPlans
//{
//    
//    if (self.) {
//        <#statements#>
//    }
//    
//    if (self.appointment_occurrence_idValue != 0) {
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//        [dict setValue:self.comments forKey:@"photo_attachment[comments]"];
//        NSString *file_path = [self ImageFilePath];
//        RequestMethod method = POST;
//        NSString *server_url = [NSString stringWithFormat:@"work_orders/%d/photo_attachments", self.appointment_occurrence_idValue];
//        if ([self.entity_status isEqualToNumber:c_EDITED]) {
//            method = PUT;
//            server_url = [NSString stringWithFormat:@"work_orders/%d/photo_attachments/%d", self.appointment_occurrence_idValue, self.entity_idValue];
//        }
//        // Somehow the appointment relation is breaking after upload call, so will hold the appointment and attach the relation again.
//        __block Appointment *relation_appt = self.appointment;
//        NSLog(@"uploading photo %@ ...", [self ImageFilePath]);
//        [FWRequest uploadFile:file_path file_name:@"image.jpg" withFormaData:dict onServerUrl:server_url withMethod:method withCompletionBlock:^(FWRequest *request) {
//            if (request.IsSuccess) {
//                [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//                    NSDictionary *main = request.serverData;
//                    NSDictionary *attachment = [main objectForKey:@"photo_attachment"];
//                    PhotoAttachment *photo = [self MR_inContext:localContext];
//                    NSNumber *localId = photo.entity_id;
//                    @try {
//                        PhotoAttachment *uploadedPhoto = [FEMDeserializer fillObject:photo fromRepresentation:attachment mapping:[PhotoAttachment defaultMapping]];
//                        [self renameImagesFrom:localId to:uploadedPhoto.entity_id];
//                        photo.appointment = [relation_appt MR_inContext:localContext];
//                        [photo setEntity_status:c_UNCHANGED];
//                        [photo setSync_status:c_UNCHANGED];
//                    } @catch (NSException *exception) {
//                        [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
//                                                                             @"Method":NSStringFromSelector(@selector(upload)),
//                                                                             @"Exception":exception.description,
//                                                                             @"UserId":self.entity_id,
//                                                                             @"RequestTag":server_url,
//                                                                             @"ServerDataClass":NSStringFromClass([request.serverData class])}];
//                    }
//                } completion:^(BOOL contextDidSave, NSError *error) {
//                    //                [self downloadWithCompletionHandler:nil];
//                    NSLog(@"photo uploaded %@", [self ImageFilePath]);
//                }];
//            }
//            else {
//                [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//                    PhotoAttachment *photo = [self MR_inContext:localContext];
//                    [photo setAppointment_occurrence_id:self.appointment_occurrence_id];
//                    photo.appointment = [self.appointment MR_inContext:localContext];
//                    [photo setSync_status:c_DIRTY];
//                    //                [photo.appointment.photo_attachmentsSet addObject:photo];
//                    //                [photo.appointment setEntity_status:c_EDITED];
//                    //                [photo.appointment setError_sync_message:@"Photo didn't upload."];
//                } completion:^(BOOL contextDidSave, NSError *error) {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:kWORKORDER_DETAIL_UPDATE_SECTION object:self userInfo:nil];
//                    //                [self upload];
//                    [[SyncManager Instance] syncPhotos];
//                    NSLog(@"photo uploading error %@", request.error.description);
//                }];
//                
//                //            NSString *message = [NSString stringWithFormat:@"Photo for order #%@ didn't upload. Trying again...", self.appointment_occurrence_id];
//                //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FieldWork"
//                //                                                            message:message
//                //                                                           delegate:nil
//                //                                                  cancelButtonTitle:@"OK"
//                //                                                  otherButtonTitles:nil];
//                //            [alert show];
//            }
//        }];
//    }
//    
//}



@end
