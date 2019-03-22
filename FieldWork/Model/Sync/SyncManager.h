//
//  SyncManager.h
//  FieldWork
//
//  Created by TripElephant MBA on 2015-12-09.
//
//

#import <Foundation/Foundation.h>

#define SMALL_INTERVAL              10
#define LONG_INTERVAL               15
#define FORCEFUL_UPDATE_INTERVAL    1800000000

@interface SyncManager : NSObject
{
    NSTimer *__sync_timer;
    NSTimer *__update_timer;
    
    BOOL __needs_immediate_sync;
}

@property (nonatomic, assign) BOOL is_sync_running;
@property (nonnull, strong) NSDate *lastUpdateDate;

+ (SyncManager*) Instance;

- (void)reachabilityChanged:(NSNotification*)note;

- (void) onTimerCalled:(NSTimer*)timer;

- (void) startTimer;

- (void) stopTimer;

- (void) startSync;

-(NSInteger)syncPlans;

- (NSInteger)syncPhotos;

-(NSInteger)syncPDFAttachments;

- (NSInteger)syncTraps;

- (void) startUpdateTimer;

- (void) stopUpdateTimer;

@end
