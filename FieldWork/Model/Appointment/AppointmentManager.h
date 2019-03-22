//
//  AppointmentManager.h
//  FieldWork
//
//  Created by SamirMAC on 11/24/15.
//
//

#import <Foundation/Foundation.h>
#import "NSString+Extension.h"

typedef void(^SyncUpdateBlock)(NSUInteger completed_appointments, BOOL is_success, NSNumber *appointment_id);
typedef void(^AllDoneBlock)();


#define REFRESH_APPOINTMENTS_FORCEFULLY         [NSString stringWithFormat:@"%@-Refresh", API_WORK_ORDERS]
#define LOAD_APPOINTMENTS_ONLYWORKPOOL         [NSString stringWithFormat:@"%@-OnlyWorkPool", API_WORK_ORDERS]

#define LOAD_ESTIMATE_DATEWISE               [NSString stringWithFormat:@"%@-OnlyDateWise", API_ESTIMATES]

#define LOAD_APPONTMENT_DATEWISE               [NSString stringWithFormat:@"%@-OnlyDateWise", API_WORK_ORDERS]
//#define LOAD_ESTIMATES_DATEWISE                [NSString stringWithFormat:@"%@-OnlyDateWise", API_ESTIMATES]


@interface AppointmentManager : NSObject <FWRequestDelegate>
{
    ItemLoadedBlock _itemLoadedBlock;
    ItemLoadedBlock _estimatesLoadedBlock;
    AllDoneBlock _allDoneBlock;
}

+ (id) Instance;

- (void) loadAppointmentsWithBlock:(ItemLoadedBlock)block;

- (void) forcedLoadAppointmentsForDate:(NSDate*)date block:(ItemLoadedBlock)block;

//- (void)forcedLoadEstimatesForDate:(NSDate*)date block:(ItemLoadedBlock)block;
//
//- (void)loadEstimatesForDate:(NSDate*)date block:(ItemLoadedBlock)block;

- (void) loadAppointmentsWithBlock:(ItemLoadedBlock)block allDoneBlock:(AllDoneBlock)allDone;

- (void) loadWorkPoolAppointmentsWithBlock:(ItemLoadedBlock)block andStartDate:(NSString*)start_date andEndDate:(NSString*)end_date;

- (void) refreshAppointmentsWithBlock:(ItemLoadedBlock)block;

- (void) forcefullyRefreshAppointmentsWithBlock:(ItemLoadedBlock)block;

- (BOOL)scanForDirtyAppointments;

- (NSString *)formatError:(NSDictionary *)dict;

- (void)loadAppointmentsForDate:(NSDate*)date block:(ItemLoadedBlock)block;

- (void)loadAppointmentsForDate:(NSDate*)date block:(ItemLoadedBlock)block allDoneBlock:(AllDoneBlock)allDone;


- (void)loadAppointmentsForDate:(NSString *)sdate WithBlock:(ItemLoadedBlock)block;

- (void)loadAppointmentsWeekForDate:(NSDate*)date block:(ItemLoadedBlock)block;

- (NSUInteger) loadedCount;

- (NSUInteger) workPoolLoadedCount;

-(void)clearAllAppointments;

//- (void) loadEstimateWithBlock:(ItemLoadedBlock)block;

- (BOOL)isSync;

@end
