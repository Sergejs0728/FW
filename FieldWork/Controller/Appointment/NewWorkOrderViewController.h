//
//  NewWorkOrderViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 8/2/14.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "Utils.h"
#import "LineItemTableCell.h"
#import "DataTableViewController.h"
#import "SamcomActionSheet_iPad.h"
#import "AppointmentDelegate.h"
#import "CustomLabel.h"
#import "LineItemFooterCell.h"
#import "AppLineItemCell.h"
#import "Invoice.h"
#import "TPKeyboardAvoidingTableView.h"

#define DATE_PICKER_DATE_TAG 1000
#define DATE_PICKER_START_TIME_TAG 2000
#define DATE_PICKER_END_TIME_TAG 3000


@protocol NewWorkOrderDelegate <NSObject>

@optional
- (void) LineItemAdded:(LineItem*) item;

- (void) CustomerChosen:(Customer*) customer;

- (void) ServiceLocationChosen:(ServiceLocation*) ser_loc;

@end

@interface NewWorkOrderViewController : CommonAppointmentViewController <NewWorkOrderDelegate, UITableViewDataSource, UITableViewDelegate,SamcomActionSheetDelegate,UITextFieldDelegate,AppointmentDelegate, DataSelectionDelegate,iPadSamcomActionSheetDelegate,UITextViewDelegate>

{
    IBOutlet UITableView *_tblChooseTable;
    IBOutlet UITableView *_tblLineItems;
    
    IBOutlet UITextView *_lblServiceLocation;
    
    IBOutlet UITextField *_txtPoNumber;
    IBOutlet UITextField *_txtDate;
    IBOutlet UITextField *_txtStartTime;
    IBOutlet UITextField *_txtEndTime;
    
     NSDate * startTime;
     NSDate * endTime;

    
    IBOutlet UIView *_bottomView;
    IBOutlet UIView *_lineItemView;
    IBOutlet UITextView *_txtServiceInstruction;
    
    IBOutlet TPKeyboardAvoidingTableView *_scrollView;
    
    NSMutableArray *_lineItems;
    
    UIDatePicker * datePicker;
    
    __weak IBOutlet NSLayoutConstraint *constraintLineItemContainerViewHeight;
    __weak IBOutlet NSLayoutConstraint *constraintBottomViewHeight;
    
     // LineItem Calculation
    
    IBOutlet UIView * lineItemContainerView;
    IBOutlet UILabel * lblCharacter;
    
    BOOL _isWorkPool;
    
    
    IBOutlet UITableViewCell *_lineItemFirstRow;
    
    
}

+ (NewWorkOrderViewController*) viewControllerWithWorkOrder:(Appointment*) app;
@property (nonatomic ,assign)BOOL isWorkPool;

- (void) expandViews;

- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnNewLineItemClicked:(id)sender;

- (IBAction)dateClicked:(id)sender;
- (IBAction)startTimeClicked:(id)sender;
- (IBAction)endTimeClicked:(id)sender;

- (void)textFieldDidChange:(UITextField *)txt;

- (void) calculateLineItems;


@end
