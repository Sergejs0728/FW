//
//  ServiceLocationNoteViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 6/19/15.
//
//

#import <UIKit/UIKit.h>
#import "ServiceLocation.h"
#import "CommonAppointmentViewController.h"
#import "Appointment+Helper.h"


@interface ServiceLocationNoteViewController : CommonAppointmentViewController{

    IBOutlet UITextView * _txtView;
}
@property (nonatomic ,retain) UITextView * txtView;

+ (ServiceLocationNoteViewController *)initViewController:(Appointment *)appointment;

@end
