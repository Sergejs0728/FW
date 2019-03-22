//
//  InstructionController.h
//  FieldWork
//
//  Created by Samir Khatri on 15/05/2013.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "CommonAppointmentViewController.h"
@interface InstructionController : CommonAppointmentViewController
{
    IBOutlet UITextView * txtview;
}
+ (InstructionController *)initWithAppointment:(Appointment *)app;
@end
