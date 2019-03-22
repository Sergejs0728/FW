//
//  AppUnitsCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//
#import "Appointment.h"
#import "Unit.h"
#import <UIKit/UIKit.h>
typedef void (^AppointmentUnits)();

@interface AppUnitsCell : UITableViewCell
@property (nonatomic)AppointmentUnits viewAllUnits;
@property (nonatomic)AppointmentUnits addUnit;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicedCountLabel;
@end
