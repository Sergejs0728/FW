//
//  NewAppointMentsDetailViewController.h
//  FieldWork
//
//  Created by Samir on 11/2/15.
//
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "Appointment.h"
#import "UIViewController+BackButtonHandler.h"
#import "CommonAppointmentViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "AddLineItemViewController.h"
#import "NoteController.h"
#import "MaterialListController.h"
#import "UIButton+Block.h"
#import "AddPictureViewController.h"

#import "UIExpandableTableView.h"
#import "LineItemFooterCell.h"

#import "DataTableViewController.h"
#import "CustomerDetailViewController.h"
#import "CaptureSignatureController.h"
#import "User.h"
#import "PaymentViewController.h"

#import "EnterNoteController.h"

#import "PrinterHelper.h"
#import "UserSetting.h"
#import "GameTimer.h"

#import "BarcodeScanerViewController.h"


#define START_TIME 1000
#define END_TIME 2000

typedef NS_ENUM(NSInteger, NSSectionType) {
    FWAppointmentDetails = 0,
    FWTimeSelection = 1,
    FWLineItem = 2,
    FWServiceInstruction = 3,
    FWLocationNote= 4,
    FWPDFForms = 5,
    FWNotes = 6,
    FWEnvironment = 7,
    FWRecommendation = 8,
    FWConditions = 9,
    FWMaterialUse = 10,
    FWPhotos = 11,
    FWDevices = 12,
    FWUnits = 13,
    FWScheme = 14,
    FWSignature = 15,
    FWTotalSections = 16
};

typedef NS_ENUM(NSInteger, NSAction) {
    FWPrint = 1,
    FWPreview = 2,
    FWEmail = 3
};

typedef void(^RecommendationBlock)();
typedef void(^ConditionsBlock)();
typedef void(^EnvironmentBlock)();

@interface NewAppointMentsDetailViewController : CommonAppointmentViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, NewWorkOrderDelegate, UIDocumentInteractionControllerDelegate, UIPrintInteractionControllerDelegate, FWRequestDelegate,GameTimerDelegate, UIAlertViewDelegate, BarcodeScanerViewControllerDelegate>
{
    
    NSTimer *timer;
    
    int seconds;
    
    int minutes;
    
    int hours;
    
    BOOL isTimerStarted;
    
    BOOL isBottomMenuExpanded;
    
    BOOL shouldPrint;

    BOOL shouldEmail;
    
    IBOutlet UITableViewCell *_lineItemFirstRow;

    UIDocumentInteractionController *_documentInteractionController;
    
    UIDatePicker *_timerPicker;
    
    EnvironmentBlock _environmentBlock;
    RecommendationBlock _recommendationBlock;
    ConditionsBlock _conditionsBlock;
    
    // LineItem Balance ForwardCell
    IBOutlet UITableViewCell *_notInvoiced;
    IBOutlet UITableViewCell *_lineItemBalanceForwardCell;
    IBOutlet UILabel *_lblBalanceForward;
}
@property (strong, nonatomic) IBOutlet UIExpandableTableView *tableView;

@property (strong, nonatomic) IBOutlet BarcodeScanerViewController *reader;

@property (strong, nonatomic) Customer * cust;
@property (strong, nonatomic) ServiceLocation *serviceLocaion;

@property (nonatomic, strong) UIColor *markColor;

@property (nonatomic,strong) NSArray *items;

@property (nonatomic, retain) NSMutableArray *itemsInTable;

@property (nonatomic,strong)NSMutableArray *photoArray;

+(NewAppointMentsDetailViewController *)initViewControllerAppointment:(Appointment*)app;

- (void) saveAppointment;

- (void) reloadSection:(NSInteger)section;

@end
