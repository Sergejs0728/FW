//
//  MultiUnitListViewController.h
//  FieldWork
//
//  Created by Alexander Kotenko on 10.05.17.
//
//

#import <UIKit/UIKit.h>
#import "UnitListCell.h"
#import "Appointment.h"

@interface UnitListViewController : UIViewController
@property (strong,nonatomic) NSMutableArray* unitsList;
@property (strong,nonatomic) Appointment* appointment;
+(UnitListViewController *)initWithAppointment:(Appointment *)app;
@end
