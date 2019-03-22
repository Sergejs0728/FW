//
//  PestsAddController.h
//  FieldWork
//
//  Created by Samir Kha on 15/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "Appointment.h"
#import "ListItemDelegate.h"
#import "Pest.h"
//#import "PestList.h"

@interface PestsAddController : CommonAppointmentViewController <ListItemDelegate>{
    IBOutlet UITableView *table;
}


+ (PestsAddController*) viewControllerWithAppointment:(Appointment*) app;

- (IBAction)addPestType:(id)sender;

@end
