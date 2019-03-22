//
//  TrapInspectionViewController.h
//  FieldWork
//
//  Created by Alex on 30.06.17.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "InspectionRecord.h"

#define UPDATE_DEVICES          @"UPDATE_DEVICES"

@interface TrapInspectionViewController : CommonAppointmentViewController
@property (nonatomic, strong) InspectionRecord *inspectionRecord;
@property (nonatomic, strong) CustomerDevice *trap;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *exception;
@property (nonatomic, strong) NSDate *scannedDate;

+ (TrapInspectionViewController*) initWithAppointment:(Appointment*)app withInspection:(InspectionRecord*)record;
+ (TrapInspectionViewController*) initWithAppointment:(Appointment*)app withTrap:(CustomerDevice*)trap;

@end
