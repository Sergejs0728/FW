//
//  TrapDetailViewController.h
//  FieldWork
//
//  Created by Alex on 29.06.17.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "TrapInspectionViewController.h"

@interface TrapDetailViewController : CommonAppointmentViewController
@property (nonatomic, strong) CustomerDevice *customerTrap;
@property (nonatomic, strong) NSDate *scannedDate;

+ (TrapDetailViewController*) initWithAppointment:(Appointment*)app withCustomerTrap:(CustomerDevice*)trap;
@end
