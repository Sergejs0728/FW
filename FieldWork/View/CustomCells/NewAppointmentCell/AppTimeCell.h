//
//  AppTimeCell.h
//  FieldWork
//
//  Created by SamirMAC on 1/5/16.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"

typedef void(^TimeButtonClicked)(BOOL isStartTimeClicked);

@interface AppTimeCell : UITableViewCell
{
    Appointment *_appointment;
    
    TimeButtonClicked _timeClickedBlock;
}

@property (nonatomic, weak) IBOutlet UILabel *lblStartTime;
@property (nonatomic, weak) IBOutlet UILabel *lblEndTime;

- (void) setAppointmentData:(Appointment*)app andButtonClickBlock:(TimeButtonClicked)block;


- (IBAction)btnStartTime:(id)sender;

- (IBAction)btnEndTime:(id)sender;


@end
