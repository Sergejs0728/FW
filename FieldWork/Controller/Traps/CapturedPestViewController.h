//
//  CapturedPestViewController.h
//  FieldWork
//
//  Created by Samir Kha on 12/02/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "CustomTableCell.h"
#import "KeyboardAccessoryHelper.h"
#import "TableExpanderView.h"
#import "PestsListController.h"
#import "InspectionRecord.h"
#import "InspectionPest.h"
#import "PestEvidenceDelegate.h"
#import "CustomerDevice.h"


@interface CapturedPestViewController : CommonAppointmentViewController<UITableViewDelegate,UITableViewDataSource,KeyBoardHelper, UITextFieldDelegate, PestSelectionDelegate>
{
    NSMutableArray * CapturedPestlist;
    UITableView * _CapturedPesttable;
    NSString *barcode;
    CustomerDevice *_customerTrap;
    IBOutlet UILabel * CapturedPestlabel;
     IBOutlet UIView *_buttonHolder;
    IBOutlet UIButton *_btnRemovePest;
    
    NSMutableArray *_inspectionPestRecords;
    InspectionRecord *_inspectionRecord;
    
    id<PestEvidenceDelegate> _pestEvidenceDelegate;
    
    NSInteger _last_selected_index;
}

@property (nonatomic, retain) IBOutlet UITableView * CapturedPesttable;
@property (nonatomic, retain) IBOutlet UILabel * CapturedPestlabel;
@property (nonatomic, readwrite, retain) UIButton *btnRemovePest;
@property (nonatomic, retain, readwrite) NSString *barcode;
@property (nonatomic, readwrite, retain) InspectionRecord *inspectionRecord;
@property (nonatomic, readwrite, retain) id<PestEvidenceDelegate> pestEvidenceDelegate;

@property (nonatomic, readwrite, copy) DataSelectionOrAddedBlock capturedPestAddedBlock;

-(IBAction)CapturedPestsavebutn:(id)sender;

-(IBAction)celladdbtn:(id)sender;

- (IBAction)removePest:(id)sender;

- (void) addInspectionPestRecord;

- (void) removeInspectionPestRecord;

+ (CapturedPestViewController*) initWithAppointment:(Appointment *)appt andInspectionRecord:(InspectionRecord *)insp;


@end
