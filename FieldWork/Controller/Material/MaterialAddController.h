//
//  MaterialAddController.h
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "CustomTableCell.h"
#import "Material.h"
#import "MaterialListController.h"
#import "ListItemDelegate.h"

@interface MaterialAddController : CommonAppointmentViewController <UITextFieldDelegate, ListItemDelegate>
{
    UITextField *materialNameTxt;
    UITextField *epATxt;
     IBOutlet UITableView *table;
    IBOutlet UIButton *addMaterialBtn;
    
    
}
+ (MaterialAddController*) viewControllerWithAppointment:(Appointment*) app;
- (IBAction)addMaterialType:(id)sender;


@end
