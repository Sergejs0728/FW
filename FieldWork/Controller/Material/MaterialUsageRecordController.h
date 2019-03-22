//
//  MaterialUsageRecordController.h
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "TableExpanderView.h"
#import "DataTableViewController.h"
#import "LocationArea.h"
#import "MaterialUsageCell.h"
#import "DilutionRates.h"
#import "KeyboardAccessoryHelper.h"
#import "MaterialUseListController.h"
#import "DeviceTypes.h"
#import "PestsListController.h"
#import "UIViewController+BackButtonHandler.h"
#import "Appointment+Helper.h"
#import "PestSelectionDelegate.h"
#import "MaterialUsageRecord.h"
#import "TargetPest.h"

#import "MaterialUsageSelectionDelegate.h"
#import "NewAppointMentsDetailViewController.h"




@interface MaterialUsageRecordController : CommonAppointmentViewController <UITableViewDataSource, UITableViewDelegate, DataSelectionDelegate, KeyBoardHelper, UITextFieldDelegate, UIAlertViewDelegate>
{
    IBOutlet UILabel *_materialName;
    IBOutlet UITableView *_tblMainData;
    IBOutlet UITableView *_tblLocationAreas;
    TableExpanderView *_locationTableExpander;
    IBOutlet UIScrollView *_mainScrollView;
    __weak IBOutlet NSLayoutConstraint *constraintMainDataViewHeight;
    __weak IBOutlet NSLayoutConstraint *constraintTableLocationAreasHeight;
    
    IBOutlet UIView *_mainDataView;
    
}

+ (MaterialUsageRecordController*) viewControllerWithAppointment:(Appointment*) app andMaterialUsage:(MaterialUsage*) musage;



@property (nonatomic, retain, readwrite) IBOutlet TableExpanderView *locationTableExpander;

@property (nonatomic, retain, readwrite) MaterialUsage *currentMaterialUsage;
@property (nonatomic, weak) id<MaterialUsageSelectionDelegate> materialUsageSelectionDelegate;

- (void) expandLocationTable;

- (IBAction)saveMaterialUsage:(id)sender;

@end


