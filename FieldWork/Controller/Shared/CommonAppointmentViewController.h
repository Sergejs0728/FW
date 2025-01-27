//
//  CommonAppointmentViewController.h
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "Constants.h"
#import "BaseViewController.h"

@interface CommonAppointmentViewController : BaseViewController{
    Appointment *_Appointment;
}

@property (nonatomic, retain, readwrite) Appointment *Appointment;

- (void) postNotificationForDirty;

- (void) removeViewControllerFromNavigationStack:(Class)cls;

@end
