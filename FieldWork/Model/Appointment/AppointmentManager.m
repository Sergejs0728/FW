
//  AppointmentManager.m
//  FieldWork
//
//  Created by SamirMAC on 11/24/15.
//
//

#import "AppointmentManager.h"
#import "Appointment.h"
#import "Appointment+Mapping.h"
#import "FWPDFForm.h"
#import "PhotoAttachment.h"
#import "PDFAttachment.h"
#import "SyncManager.h"
#import "StageModel.h"
#import "Estimate.h"
#import "Unit.h"

@interface AppointmentManager()
@property (nonatomic)BOOL isSync;
@property (nonatomic, strong)NSDate *selectedDate;
@end

@implementation AppointmentManager


- (instancetype)init {
    if (self = [super init]) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAppointmentsWithBlock:) name:kRELOAD_WORKORDERS_FROM_SERVER object:nil];
    }
    return self;
}

+ (id) Instance {
    static AppointmentManager *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[AppointmentManager alloc] init];
    });
    return __sharedInstance;
}

- (NSUInteger) loadedEstimatesCount
{
    return [[Estimate getEstimates] count];
}

- (NSUInteger) loadedCount
{
    return [[Appointment getAppointments] count];
}

- (NSUInteger) workPoolLoadedCount
{
    return [[Appointment getWorkPoolAppointments] count];
}


-(BOOL)scanForDirtyAppointments{
    return [Appointment isFoundDirty];
}


-(void)clearAllAppointments{
    [Appointment MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
//    [Appointment MR_truncateAll];
    
}

-(void)clearAllEstimates{
    [Estimate MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void) loadEstimateWithBlock:(ItemLoadedBlock)block
{
    _estimatesLoadedBlock = block;
    NSMutableArray *records = [Estimate getEstimates];
    if (records != nil && records.count > 0) {
        if (_estimatesLoadedBlock) {
            _estimatesLoadedBlock(records, nil);
        }
    }else{
        if ([[AppDelegate appDelegate] isReachable]) {
            FWRequest *request = [[FWRequest alloc] initWithUrl:API_ESTIMATES andDelegate:self];
            request.Tag = API_ESTIMATES;
            [request startRequest];
        }
    }
}

- (void) loadAppointmentsWithBlock:(ItemLoadedBlock)block
{
    _itemLoadedBlock = block;
    NSMutableArray *records = [Appointment getAppointments];
    if (records != nil && records.count > 0) {
        if (_itemLoadedBlock) {
            _itemLoadedBlock(records, nil);
        }
    }else{
        if ([[AppDelegate appDelegate] isReachable]) {
            if ([[ActivityIndicator currentIndicator] ishidden]) {
                [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
            }
            FWRequest *request = [[FWRequest alloc] initWithUrl:API_WORK_ORDERS andDelegate:self];
            request.Tag = API_WORK_ORDERS;
            _isSync=YES;
            [request startRequest];
        }
    }
}

- (void) loadAppointmentsWithBlock:(ItemLoadedBlock)block allDoneBlock:(AllDoneBlock)allDone{
    _allDoneBlock=allDone;
    [self loadAppointmentsWithBlock:block];
}
- (void)forcedLoadAppointmentsForDate:(NSDate*)date block:(ItemLoadedBlock)block{
    _itemLoadedBlock = block;
    if ([[AppDelegate appDelegate] isReachable]) {
        FieldWorkAccount *account = [AccountManager Instance].activeAccount;
        NSString *api_key = account.api_key;
        NSString *sdate = [date stringLocalTimeWithFormat:@"MM/dd/yyyy"];
        NSString *url_part = [NSString stringWithFormat:@"%@%@?api_key=%@",FW_API_VERSION,API_WORK_ORDERS,api_key];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"with_workpool=%@",@"false"]];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"start_date=%@", sdate]];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"end_date=%@", sdate]];
        if([[ActivityIndicator currentIndicator] ishidden]){
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        }
        FWRequest *request = [[FWRequest alloc] initWithUrl:url_part andDelegate:self];
        request.Tag = LOAD_APPONTMENT_DATEWISE;
        _isSync=YES;
        _selectedDate = date;
        [request startRequest];
    }
    else{
        NSMutableArray *records = [Appointment getAppointmentsForDate:date];
        if (_itemLoadedBlock) {
            _itemLoadedBlock(records, nil);
        }
    }
}

- (void)loadEstimatesForDate:(NSDate*)date block:(ItemLoadedBlock)block{
    _estimatesLoadedBlock = block;
    if ([[AppDelegate appDelegate] isReachable]) {
        FieldWorkAccount *account = [AccountManager Instance].activeAccount;
        NSString *api_key = account.api_key;
        NSString *sdate = [date stringLocalTimeWithFormat:@"MM/dd/yyyy"];
        NSString *url_part = [NSString stringWithFormat:@"%@%@?api_key=%@",FW_API_VERSION,API_ESTIMATES,api_key];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"with_workpool=%@",@"false"]];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"start_date=%@", sdate]];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"end_date=%@", sdate]];
        if([[ActivityIndicator currentIndicator] ishidden]){
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        }
        FWRequest *request = [[FWRequest alloc] initWithUrl:url_part andDelegate:self];
        request.Tag = LOAD_ESTIMATE_DATEWISE;
        _isSync=YES;
        _selectedDate = date;
        [request startRequest];
    }
    else{
        NSMutableArray *records = [Appointment getAppointmentsForDate:date];
        if (_estimatesLoadedBlock) {
            _estimatesLoadedBlock(records, nil);
        }
    }
}

- (void)forcedLoadEstimatesForDate:(NSDate*)date block:(ItemLoadedBlock)block{
    _estimatesLoadedBlock = block;
    if ([[AppDelegate appDelegate] isReachable]) {
        FieldWorkAccount *account = [AccountManager Instance].activeAccount;
        NSString *api_key = account.api_key;
        NSString *sdate = [date stringLocalTimeWithFormat:@"MM/dd/yyyy"];
        NSString *url_part = [NSString stringWithFormat:@"%@%@?api_key=%@",FW_API_VERSION,API_ESTIMATES,api_key];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"with_workpool=%@",@"false"]];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"start_date=%@", sdate]];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"end_date=%@", sdate]];
        if([[ActivityIndicator currentIndicator] ishidden]){
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        }
        FWRequest *request = [[FWRequest alloc] initWithUrl:url_part andDelegate:self];
        request.Tag = LOAD_ESTIMATE_DATEWISE;
        _isSync=YES;
        _selectedDate = date;
        [request startRequest];
    }
    else{
        NSMutableArray *records = [Appointment getAppointmentsForDate:date];
        if (_estimatesLoadedBlock) {
            _estimatesLoadedBlock(records, nil);
        }
    }
}


- (void)loadAppointmentsForDate:(NSDate*)date block:(ItemLoadedBlock)block allDoneBlock:(AllDoneBlock)allDone{
    _allDoneBlock=allDone;
    [self loadAppointmentsForDate:date block:block];
}

- (void)loadAppointmentsForDate:(NSDate*)date block:(ItemLoadedBlock)block
{
    _itemLoadedBlock = block;
    NSMutableArray *records = [Appointment getAppointmentsForDate:date];
    if (records != nil && records.count > 0) {
        if (_itemLoadedBlock) {
            _itemLoadedBlock(records, nil);
        }
    }else{
        if ([[AppDelegate appDelegate] isReachable]) {
            FieldWorkAccount *account = [AccountManager Instance].activeAccount;
            NSString *api_key = account.api_key;
            NSString *sdate = [date stringLocalTimeWithFormat:@"MM/dd/yyyy"];
            //            NSString *sdate = [Utils dateFormatMMddyyyy:date];
            NSString *url_part = [NSString stringWithFormat:@"%@%@?api_key=%@",FW_API_VERSION,API_WORK_ORDERS,api_key];
            url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"with_workpool=%@",@"false"]];
            url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"start_date=%@", sdate]];
            url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"end_date=%@", sdate]];
            if([[ActivityIndicator currentIndicator] ishidden]){
                [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
            }
            FWRequest *request = [[FWRequest alloc] initWithUrl:url_part andDelegate:self];
            request.Tag = LOAD_APPONTMENT_DATEWISE;
            _selectedDate = date;
            _isSync=YES;
            [request startRequest];
        }
    }
}



- (void) loadWorkPoolAppointmentsWithBlock:(ItemLoadedBlock)block andStartDate:(NSString*)start_date andEndDate:(NSString*)end_date
{
    _itemLoadedBlock = block;
    if ([[AppDelegate appDelegate] isReachable]) {
        FieldWorkAccount *account = [AccountManager Instance].activeAccount;
        NSString *api_key = account.api_key;
        NSString *url_part = [NSString stringWithFormat:@"%@%@?api_key=%@",FW_API_VERSION,API_WORK_ORDERS,api_key];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"with_workpool=%@",@"true"]];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"start_date=%@", start_date]];
        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"end_date=%@", end_date]];
        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        FWRequest *request = [[FWRequest alloc] initWithUrl:url_part andDelegate:self];
        request.Tag = LOAD_APPOINTMENTS_ONLYWORKPOOL;
        _isSync=YES;
        [request startRequest];
    }
}

- (void)loadAppointmentsWeekForDate:(NSDate*)date block:(ItemLoadedBlock)block {
    _itemLoadedBlock = block;
    if ([[AppDelegate appDelegate] isReachable]) {
        //        NSDate *daysAgo = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
        //                                                                       value:-2
        //                                                                      toDate:date
        //                                                                     options:0];
        //        NSString *daysAgoString = [Utils dateFormatMMddyyyy:daysAgo];
        //        NSDate *daysAfter = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
        //                                                                      value:6
        //                                                                     toDate:date
        //                                                                    options:0];
        //        NSString *daysAfterString = [Utils dateFormatMMddyyyy:daysAfter];
        //        FieldWorkAccount *account = [AccountManager Instance].activeAccount;
        //        NSString *api_key = account.api_key;
        //        NSString *url_part = [NSString stringWithFormat:@"%@%@?api_key=%@",FW_API_VERSION,API_WORK_ORDERS,api_key];
        //        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"with_workpool=%@",@"false"]];
        //        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"start_date=%@", daysAgoString]];
        //        url_part = [url_part URLStringByAppendingQueryString:[NSString stringWithFormat:@"end_date=%@", daysAfterString]];
        if ([[ActivityIndicator currentIndicator] ishidden]) {
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        }
        FWRequest *request = [[FWRequest alloc] initWithUrl:API_WORK_ORDERS andDelegate:self];
        request.Tag = LOAD_APPONTMENT_DATEWISE;
        _selectedDate = date;
        _isSync=YES;
        [request startRequest];
    }
}


- (void) refreshAppointmentsWithBlock:(ItemLoadedBlock)block
{
    _itemLoadedBlock = block;
    if ([[AppDelegate appDelegate] isReachable]&&([AccountManager Instance].activeAccount )) {
        FWRequest *request = [[FWRequest alloc] initWithUrl:API_WORK_ORDERS andDelegate:self];
        request.Tag = API_WORK_ORDERS;
        if ([[ActivityIndicator currentIndicator] ishidden]) {
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        }
        _isSync=YES;
        [request startRequest];
    }
}

- (void) forcefullyRefreshAppointmentsWithBlock:(ItemLoadedBlock)block
{
    _itemLoadedBlock = block;
    if ([[AppDelegate appDelegate] isReachable]) {
        FWRequest *request = [[FWRequest alloc] initWithUrl:API_WORK_ORDERS andDelegate:self];
        request.Tag = REFRESH_APPOINTMENTS_FORCEFULLY;
        if ([[ActivityIndicator currentIndicator] ishidden]) {
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        }
        _isSync=YES;
        [request startRequest];
    }
}

- (int) startSyncWithUpdateBlock:(SyncUpdateBlock)block
{
    if(_isSync){
        _isSync=YES;
        NSMutableArray *all_appointments = [Appointment getAppointments];
        NSArray *arr = [all_appointments filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            Appointment *appt = (Appointment*) evaluatedObject;
            if ([appt.entity_status isEqualToNumber:c_EDITED]) {
                return YES;
            }
            return NO;
        }]];
        if (arr.count > 0) {
            NSMutableArray *appt_ids = [[arr valueForKey:@"entity_id"] mutableCopy];
            for (Appointment *appt in arr) {
                [appt saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
                    _isSync=NO;
                    if (is_saved) {
                        [appt_ids removeObject:appointment_id];
                        block(arr.count - appt_ids.count, is_saved, appointment_id);
                    }
                }];
            }
        }
        return (int)arr.count;
    }
    return 0;
}

-(NSString *)formatError:(NSDictionary *)dict{
    __block NSString *result;
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL * stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = obj;
            result = [NSString stringWithFormat:@"%@ = %@",key,[arr componentsJoinedByString:@"\n"]];
            [result stringByAppendingString:@"\n"];
        }
    }];
    return result;
}


#pragma mark - FWRequestDelegate

- (void)RequestDidSuccess:(FWRequest *)request {
    [[ActivityIndicator currentIndicator] displayCompleted];
    [[ActivityIndicator currentIndicator] hide];
    if (request.IsSuccess) {
        if ([request.Tag isEqualToString:API_WORK_ORDERS] || [request.Tag isEqualToString:LOAD_APPONTMENT_DATEWISE]) {
            [SyncManager Instance].lastUpdateDate = [NSDate date];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshEnded" object:nil];
            //            [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            
            if ([request.Tag isEqualToString:API_WORK_ORDERS]) {
                [Appointment MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            } else {
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay) fromDate:[_selectedDate changeTimeZoneToUtc]];
                //create a date with these components
                NSDate *startDate = [calendar dateFromComponents:components];
                [components setDay:1];
                [components setMonth:0];
                [components setYear:0];
                NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"starts_at >= %@ AND starts_at < %@ AND specific == %@", [startDate changeTimeZoneToLocal], [endDate changeTimeZoneToLocal], @(YES)];
                [Appointment MR_deleteAllMatchingPredicate:predicate];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
//            NSMutableArray* tempAppointments=[[Appointment MR_findAll] mutableCopy];
//            [tempAppointments filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//                Appointment* app=evaluatedObject;
//                NSLog(@"entity status %@",app.entity_status);
//                return  ([app.entity_status isEqualToNumber:c_EDITED]);
//            }]];
//            
//            NSMutableArray* serverAppontments= [request.serverData mutableCopy];
//            [serverAppontments filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//                NSDictionary* app=evaluatedObject;
//                for (Appointment* tempApp in tempAppointments) {
//                    if ([[app objectForKey:@"id"] isEqualToNumber:tempApp.entity_id]) {
//                        return NO;
//                    }
//                }
//              return YES;
//            }]];
            NSArray *appts = [FEMDeserializer collectionFromRepresentation:request.serverData mapping:[Appointment defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

            for (Appointment *app in appts) {
                [app setEntity_status:c_UNCHANGED];
                if (app.pdf_forms.count > 0) {
                    for (FWPDFForm *pdf in [app.pdf_forms allObjects]) {
                        pdf.appointment_id = app.entity_id;
                        [pdf downloadWithAppointment:app];
                    }
                }
                if (app.photo_attachments.count > 0) {
                    for (PhotoAttachment *pa in [app.photo_attachments allObjects]) {
                        [pa downloadWithCompletionHandler:nil];
                    }
                }
                if (app.attachments.count > 0) {
                    for (PDFAttachment *attachment in app.attachments) {
                        [attachment download];
                    }
                }
            }
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            _isSync=NO;
            if (_itemLoadedBlock) {
                _itemLoadedBlock(appts, nil);
            }
            //            NSMutableArray *arr = request.serverData;
            //            NSMutableArray *appts = [[NSMutableArray alloc] init];
            //            for (NSDictionary *dict in arr) {
            //                int app_id = [[dict objectForKey:@"id"] intValue];7878
            //                Appointment *app = [Appointment MR_findFirstByAttribute:@"entity_id" withValue:[NSNumber numberWithInt:app_id]];
            //                @try {
            //                    if (app) {
            //
            //                        if ([app.entity_status isEqualToNumber:c_UNCHANGED]) {
            //                            Appointment *temp = [FEMDeserializer objectFromRepresentation:dict mapping:[Appointment defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
            //                            [temp setEntity_status:c_UNCHANGED];
            //                            [appts addObject:temp];
            //                        }
            //                    } else {
            //                        Appointment *temp = [FEMDeserializer objectFromRepresentation:dict mapping:[Appointment defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
            //                        [temp setEntity_status:c_UNCHANGED];
            //                        [appts addObject:temp];
            //                    }
            //                } @catch (NSException *exception) {
            //                    [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
            //                                                                         @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
            //                                                                         @"Exception":exception.description,
            //                                                                         @"UserId":app.entity_id,
            //                                                                         @"RequestTag":request.Tag,
            //                                                                         @"RequestMethod":@"GET",
            //                                                                         @"ServerDataClass":NSStringFromClass([request.serverData class])}];
            //                } @finally {
            //
            //
            //                }
            //
            //            }
            //            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            //            if (arr.count == 0) {
            //                dispatch_async(dispatch_get_main_queue(), ^{
            //                    if (_itemLoadedBlock) {
            //                        _itemLoadedBlock(appts, nil);
            //
            //                    }
            //                });
            //            }
            //            }];
      
        }
        if ([request.Tag isEqualToString:REFRESH_APPOINTMENTS_FORCEFULLY]) {
            [SyncManager Instance].lastUpdateDate = [NSDate date];
            [Appointment MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
            NSArray *appts = [FEMDeserializer collectionFromRepresentation:request.serverData mapping:[Appointment defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
            [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
            dispatch_async(dispatch_get_main_queue(), ^{
                _isSync=NO;
                if (_itemLoadedBlock) {
                    _itemLoadedBlock(appts, nil);
                }
            });
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *appointments = [Appointment getAppointments];
                for (Appointment *appt in appointments) {
                    if (appt.pdf_forms.count > 0) {
                        for (FWPDFForm *pdf in [appt.pdf_forms allObjects]) {
                            pdf.appointment_id = appt.entity_id;
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
                }
            });
        }
        
        if ([request.Tag isEqualToString:LOAD_APPOINTMENTS_ONLYWORKPOOL]) {
            NSArray *appts = [FEMDeserializer collectionFromRepresentation:request.serverData mapping:[Appointment defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
            [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
            NSArray *appointments = [Appointment getAppointments];
            for (Appointment *appt in appointments) {
                if (appt.pdf_forms.count > 0) {
                    for (FWPDFForm *pdf in [appt.pdf_forms allObjects]) {
                        pdf.appointment_id = appt.entity_id;
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
                //                    [[appt getCustomer] loadPaymentMethods:nil];
            }
            _isSync=NO;
            if (_itemLoadedBlock) {
                _itemLoadedBlock(appts, nil);
            }
        }
    }
    
        if ([request.Tag isEqualToString:API_ESTIMATES]||[request.Tag isEqualToString:LOAD_ESTIMATE_DATEWISE]) {
                [SyncManager Instance].lastUpdateDate = [NSDate date];
                [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
                    [Estimate MR_truncateAllInContext:localContext];
                    NSMutableArray *arr = request.serverData;
                    NSMutableArray *appts = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in arr) {
                        int est_id = [[dict objectForKey:@"id"] intValue];
                        Estimate *est = [Estimate MR_findFirstByAttribute:@"entity_id" withValue:[NSNumber numberWithInt:est_id]];
                        @try {
                            if (est) {
                                if ([est.entity_status isEqualToNumber:c_UNCHANGED]) {
                                    Estimate *temp = [FEMDeserializer objectFromRepresentation:dict mapping:[Estimate defaultMapping] context:localContext];
                                    [temp setEntity_status:c_UNCHANGED];
                                    [temp didSave];
                                    [appts addObject:temp];
                                }
                            } else {
                                Estimate *temp = [FEMDeserializer objectFromRepresentation:dict mapping:[Estimate defaultMapping] context:localContext];
                                [temp setEntity_status:c_UNCHANGED];
                                [appts addObject:temp];
                            }
                        } @catch (NSException *exception) {
                            [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                                 @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                                 @"Exception":exception.description,
                                                                                 @"UserId":est.objectID,
                                                                                 @"RequestTag":request.Tag,
                                                                                 @"RequestMethod":@"GET",
                                                                                 @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                        } @finally {
//                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (_estimatesLoadedBlock) {
                                    _estimatesLoadedBlock(appts, nil);
                                }
//                            });
                        }
                    }
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *estimates = [Estimate getEstimates];
                    for (Estimate *est in estimates) {
                        if (![est.entity_status isEqualToNumber:c_UNCHANGED]) {
                            continue;
                        }
                        if (est.pdf_forms.count > 0) {
                            for (FWPDFForm *pdf in [est.pdf_forms allObjects]) {
                                [pdf downloadWithEstimate:est];
                            }
                        }
                        if (est.photo_attachments.count > 0) {
                            for (PhotoAttachment *pa in [est.photo_attachments allObjects]) {
                                [pa downloadWithCompletionHandler:nil];
                            }
                        }
                        if (est.attachments.count > 0) {
                            for (PDFAttachment *attachment in est.attachments) {
                                [attachment download];
                            }
                        }
                    }
                });
        }
    if (_allDoneBlock){
        _allDoneBlock();
        _allDoneBlock=nil;
    }
}

- (void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error{
    [[ActivityIndicator currentIndicator] hide];
//    NSMutableArray *records = [Appointment getAppointments];
//    NSMutableArray *estimates = [Estimate getEstimates];

    _isSync=NO;
    NSLog(@"fail %@",error);
    if (_itemLoadedBlock) {
        _itemLoadedBlock(nil, error);
    }
    if (_estimatesLoadedBlock){
        _estimatesLoadedBlock(nil, error);
    }
}

-(BOOL)isSync{
    return _isSync;
}

@end
