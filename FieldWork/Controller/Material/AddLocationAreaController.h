//
//  AddLocationAreaController.h
//  FieldWork
//
//  Created by Samir Kha on 31/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "CustomTableCell.h"
#import "ListItemDelegate.h"
#import "LocationType.h"
#import "Appointment+Helper.h"

@interface AddLocationAreaController : CommonAppointmentViewController <ListItemDelegate>
{
    IBOutlet UITableView *_mainTable;
}

+ (AddLocationAreaController*) viewControllerWithAppointment:(Appointment*) app;

- (IBAction)addLocationArea:(id)sender;

@end
