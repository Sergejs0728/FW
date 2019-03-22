//
//  TrapAddController.h
//  FieldWork
//
//  Created by Samir Kha on 22/02/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableCell.h"
#import "Appointment.h"
#import "CommonAppointmentViewController.h"
#import "ListItemDelegate.h"
#import "DataTableViewController.h"
#import "TrapDetailViewController.h"


@interface TrapAddController : CommonAppointmentViewController<UITableViewDelegate,UITableViewDataSource,ListItemDelegate, DataSelectionDelegate, UITextFieldDelegate>
{
    UITableView * _TrapAddTable;
    NSString * _barcode;
    
    CustomerDevice *_customerTrap;
    UIScrollView * _addscrollview;
 }

@property (nonatomic ,retain) IBOutlet UITableView * TrapAddTable;
@property (nonatomic ,retain,readwrite) NSString *barcode;
@property (nonatomic ,retain) IBOutlet UIScrollView * addscrollview;
@property (nonatomic, strong) Estimate* estimate;
@property (nonatomic, readwrite, retain) CustomerDevice *customerTrap;

-(IBAction)SaveTrapAdd:(id)sender;


+ (TrapAddController*) initWithAppointment:(Appointment*) app withCustomerTrap:(CustomerDevice*) ctrap;

+ (TrapAddController*) initWithEstimate:(Estimate*) est withCustomerTrap:(CustomerDevice *)ctrap;


@end
