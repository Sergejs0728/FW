//
//  EvidenceListController.h
//  FieldWork
//
//  Created by Samir Khatri on 2/20/13.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
//26112015
//#import "NSMutableArray+Join.h"
#import "InspectionRecord.h"
#import "PestEvidenceDelegate.h"
#import "Evidences.h"

@interface EvidenceListController : CommonAppointmentViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_evidenceArray;
    
    IBOutlet UITableView *_mainTable;
    
    InspectionRecord *_inspectionRecord;

}

@property (nonatomic, retain)NSMutableArray *evidenceItems;

@property (nonatomic, readwrite, retain) id<PestEvidenceDelegate> pestEvidenceDelegate;

@property (nonatomic, readwrite, retain) InspectionRecord *inspectionRecord;

@property (nonatomic, readwrite, copy) DataSelectionOrAddedBlock evidenceSelectionBlock;

+ (EvidenceListController*) initWithAppointment:(Appointment*) appt andInspectionRecord:(InspectionRecord*) ir;

- (IBAction)saveClicked:(id)sender;

@end
