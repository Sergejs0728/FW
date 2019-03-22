//
//  MaterialUseListController.h
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "CommonAppointmentViewController.h"
#import "MaterialListController.h"
#import "MaterialUsageRecordController.h"
#import "ListItemDelegate.h"
#import "MaterialUsageSelectionDelegate.h"


//@protocol MaterialUsageSelectionDelegate <NSObject>
//
//- (void) MaterialUsageSelected:(MaterialUsage*) usage;
//
//@end

@interface MaterialUseListController : CommonAppointmentViewController< ListItemDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_materialUseagList;
    IBOutlet UITableView *_mainTable;
    
    //id<MaterialUsageSelectionDelegate> _usageSelectionDelegate;
}


@property (nonatomic, retain, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet NSMutableArray *materialUseagList;
//@property (nonatomic, readwrite, retain) id<MaterialUsageSelectionDelegate> usageSelectionDelegate;

+ (MaterialUseListController*) viewControllerWithAppointment:(Appointment*) app;

+ (MaterialUseListController*) viewControllerWithAppointment:(Appointment*) app withSelectionDelegate:(id<MaterialUsageSelectionDelegate>) del;

- (void) refreshList;

@end
