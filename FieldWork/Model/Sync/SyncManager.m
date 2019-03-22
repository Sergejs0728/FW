//
//  SyncManager.m
//  FieldWork
//
//  Created by TripElephant MBA on 2015-12-09.
//
//

#import "SyncManager.h"
#import "Appointment.h"
#import "ServiceLocation.h"
#import "Customer.h"
#import "PhotoAttachment.h"
#import "PDFAttachment.h"
#import "MagicalRecord.h"
#import "StageModel.h"
#import "User.h"
#import "FWPDFForm.h"

@interface SyncManager () {
    BOOL __currentlyPaused;
}
@end

@implementation SyncManager
@synthesize lastUpdateDate = _lastUpdateDate;

+ (SyncManager*) Instance {
    static SyncManager *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[SyncManager alloc] init];
    });
    
    return __sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        __needs_immediate_sync = NO;
        __currentlyPaused = NO;
    }
    return self;
}

- (NSDate *)lastUpdateDate {
    _lastUpdateDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastUpdateDate"];
    return _lastUpdateDate;
}

- (void)setLastUpdateDate:(NSDate *)lastUpdateDate {
    _lastUpdateDate = lastUpdateDate;
    [[NSUserDefaults standardUserDefaults] setValue:lastUpdateDate forKey:@"lastUpdateDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self stopUpdateTimer];
    [self startUpdateTimer];
}

- (void) startUpdateTimer
{
    [self stopUpdateTimer];
    __update_timer = [NSTimer scheduledTimerWithTimeInterval:FORCEFUL_UPDATE_INTERVAL target:self selector:@selector(onUpdateTimerCalled:) userInfo:nil repeats:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseTime) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unPauseTime) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void) stopUpdateTimer
{
    __currentlyPaused = NO;
    if (__update_timer != nil) {
        [__update_timer invalidate];
        __update_timer = nil;
    }
}

-(void)pauseTime
{
    __currentlyPaused = YES;
}

-(void)unPauseTime
{
    if (__currentlyPaused == NO) return;
    __currentlyPaused = NO;
    NSTimeInterval elapsedTime = -[self.lastUpdateDate timeIntervalSinceNow];
    if (elapsedTime >= FORCEFUL_UPDATE_INTERVAL) {
        [self stopUpdateTimer];
        [self startUpdateTimer];
        [[NSNotificationCenter defaultCenter] postNotificationName:kFORFULLY_UPDATE_APPOINTMENTS object:nil];
    }
}

- (void)onUpdateTimerCalled:(NSTimer *)timer
{
    DLog(@"Update Timer Called");
    if ([[AppDelegate appDelegate] isReachable]) {
        NSTimeInterval elapsedTime = -[self.lastUpdateDate timeIntervalSinceNow];
        if (!_is_sync_running && elapsedTime >= FORCEFUL_UPDATE_INTERVAL) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kFORFULLY_UPDATE_APPOINTMENTS object:nil];
        }
    }
}

- (void) startTimer
{
    if (__sync_timer != nil) {
        [__sync_timer invalidate];
    }
    __sync_timer = [NSTimer scheduledTimerWithTimeInterval:LONG_INTERVAL target:self selector:@selector(onTimerCalled:) userInfo:nil repeats:NO];
}

- (void) stopTimer
{
    if (__sync_timer != nil) {
        [__sync_timer invalidate];
        __sync_timer = nil;
    }
}

- (void)reachabilityChanged:(NSNotification*)note
{
    FWReachability * reach = [FWReachability reachabilityForInternetConnection];
    if ([reach isReachable]) {
        NSTimeInterval elapsedTime = -[self.lastUpdateDate timeIntervalSinceNow];
        if (__needs_immediate_sync == YES) {
            [self stopTimer];
            __sync_timer = [NSTimer scheduledTimerWithTimeInterval:SMALL_INTERVAL target:self selector:@selector(onTimerCalled:) userInfo:nil repeats:NO];
            if (elapsedTime >= FORCEFUL_UPDATE_INTERVAL) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kFORFULLY_UPDATE_APPOINTMENTS object:nil];
            }
        }
    } else {
        // do not need to do anything.
    }
}

- (void)onTimerCalled:(NSTimer *)timer
{
    DLog(@"Sync Timer Called");
    if ([[AppDelegate appDelegate] isReachable]) {
        [self startSync];
    } else {
        __needs_immediate_sync = YES;
        [self startTimer];
    }
}

- (void) startSync{
    if ([[AppDelegate appDelegate] isReachable] && [User getUser]) {
        [[StaticModelLoader Instance] loadStatuses];
        DLog(@"Sync startSync");
        if (!self.is_sync_running) {
            // find edited appointment. We will only sync one appointment on one timer called event.
            NSMutableArray *appointments = [[Appointment MR_findAllSortedBy:@"last_sync_date"
                                                                  ascending:YES
                                                              withPredicate:[NSPredicate predicateWithFormat:@"entity_status == %@", c_EDITED]
                                                                  inContext:[NSManagedObjectContext MR_defaultContext]]
                                            mutableCopy];
            if (appointments && appointments.count > 0) {
                Appointment *appt = appointments.firstObject;
                // then check whether user is working in that appointment or not. Only start sync that appointment which is not currently being used.
                if ([AppDelegate appDelegate].working_appointment_id == nil || ![appt.entity_id isEqualToNumber:[AppDelegate appDelegate].working_appointment_id]) {
                    // start sync and then break the loop. The next appointment will be sync next time.
                    DLog(@"Syncing Work Order : %@", appt.entity_id);
                    self.is_sync_running = YES;
                    [appt saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
                        if (is_saved) {
                            DLog(@"Syncing Completed for Work Order : %@", appt.entity_id);
                            self.is_sync_running = NO;
                            [appt setLast_sync_date:[NSDate date]];
                            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                            __sync_timer = [NSTimer scheduledTimerWithTimeInterval:SMALL_INTERVAL target:self selector:@selector(onTimerCalled:) userInfo:nil repeats:NO];
                        }
                        
                    }];
                    // now we know there are more with dirty flag, so schedule time with less interval, in mean time the current one will be completed.
                    [self stopTimer];
                } else {
                    DLog(@"User is working in this Work Order : %@", appt.entity_id);
                    __sync_timer = [NSTimer scheduledTimerWithTimeInterval:SMALL_INTERVAL target:self selector:@selector(onTimerCalled:) userInfo:nil repeats:NO];
                }
            } else {
                DLog(@"Sync - No Dirty Appointments");
            }
        } else {
            DLog(@"Sync in progress");
            [self startTimer];
        }
    }
}


-(NSInteger)syncPlans{
    if ([[AppDelegate appDelegate] isReachable]) {
        DLog(@"Sync  Plans");
        
        NSArray* stages=[StageModel stagesForSync];
        for (StageModel* stage in stages) {
                [stage uploadPlan];
        }
        NSInteger count =stages.count;
        stages=[StageModel stagesToDelete];
        for (StageModel* stage in stages) {
           NSManagedObjectContext* localContext =[stage managedObjectContext];
            [stage deleteOnServerBlock:^{
                [stage MR_deleteEntityInContext:localContext];
            }];
        }
        return count;
    }
    return 0;
}

-(NSInteger)syncPDFAttachments{
    if ([[AppDelegate appDelegate] isReachable]) {
        DLog(@"Sync attachments startSync");
        NSArray *attachments = [PDFAttachment getAttachmentsForSync];
        if (attachments.count) {
            for (PDFAttachment* attachment in attachments) {
                FWPDFForm *form = [FWPDFForm getById:attachment.pdf_form_id appointmentId:attachment.appointment_occurrence_id];
                if (form.use_acrobatValue) {
                    [attachment  uploadWithPDF];
                }
                else{
                    [attachment postPDFAttachment];
                    
                }
                
            }
        }
        return attachments.count;
    }
    return 0;
}

- (NSInteger)syncPhotos {
    if ([[AppDelegate appDelegate] isReachable]) {
        DLog(@"Sync photos startSync");
        NSArray *photos = [PhotoAttachment getPhotosForSync];
        if (photos.count) {
//            NSInteger syncedCount = MIN(10, photos.count);
            NSInteger syncedCount = photos.count;
            for (NSInteger i=0; i< syncedCount; i++) {
                PhotoAttachment *photo = photos[i];
                [photo setSync_status:c_SYNC];
            }
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            for (NSInteger i=0; i< syncedCount; i++) {
                PhotoAttachment *photo = photos[i];
                [photo upload];
            }
            
//
//            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//                        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//                            NSArray *photos = [PhotoAttachment MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"entity_status != %@ AND sync_status == %@", c_DELETED, c_DIRTY] inContext:localContext];
//                            for (PhotoAttachment *photo in photos) {
//                                [photo setSync_status:c_SYNC];
//                            }
//                        } completion:^(BOOL contextDidSave, NSError *error) {
//                            NSArray *photos = [PhotoAttachment getPhotosForSync];
//                            for (PhotoAttachment *photo in photos) {
//                                [photo upload];
//                            }
//                        }];
        } else {
            NSLog(@"no photos to upload");
        }
        [self startTimer];
        return photos.count;
    }
    return 0;
}


- (NSInteger)syncTraps {
    if ([[AppDelegate appDelegate] isReachable]) {
        DLog(@"Sync traps startSync");
        NSArray *traps = [CustomerDevice devicesForSync];
        if (traps.count) {
            for (CustomerDevice *trap in traps) {
                [trap saveCustomerDeviceToServer:nil];
                
            }
        }
        return traps.count;
    }
    return 0;
}


@end
