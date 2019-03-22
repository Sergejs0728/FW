//
//  MaterialListController.h
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "MaterialListController.h"
#import "MaterialAddController.h"
#import "MaterialUsageRecordController.h"
#import "MaterialUsageSelectionDelegate.h"
#import "AddLineItemViewController.h"
#import "MaterialUsage.h"
#import "Unit.h"

@interface MaterialListController : CommonAppointmentViewController<AddLineItemDelegate,UISearchBarDelegate>
{
    NSMutableArray *_materialList;
    IBOutlet UITableView *table;
    id<AddLineItemDelegate>_delegate;
    
    id<MaterialUsageSelectionDelegate> _materialUsageSelectionDelegate;
}

@property (nonatomic, retain, readwrite) NSMutableArray *materialList;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain, readwrite) IBOutlet UITableView *table;
@property (nonatomic ,retain) id<AddLineItemDelegate>delegate;
@property (strong, nonatomic) Estimate* estimate;
@property (nonatomic, retain, readwrite) id<MaterialUsageSelectionDelegate> materialUsageSelectionDelegate;

@property (nonatomic, copy) GeneralNotificationBlock materialUsagedAddedBlock;

+ (MaterialListController*) viewControllerWithAppointment:(Appointment*) app;

+ (MaterialListController*) viewControllerWithAppointment:(Appointment*) app AddLineItemDelegate:(id<AddLineItemDelegate>)del;

+ (MaterialListController*) viewControllerWithUnit:(Unit*) unit;

+ (MaterialListController*) viewControllerWithUnit:(Unit*) unit AddLineItemDelegate:(id<AddLineItemDelegate>)del;

@end
