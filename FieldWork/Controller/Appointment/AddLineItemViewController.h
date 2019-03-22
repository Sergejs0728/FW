//
//  AddLineItemViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 8/11/14.
//
//

#import <UIKit/UIKit.h>
#import "DataTableViewController.h"
#import "Constants.h"
#import "LineItem.h"
#import "AddLineItemViewController.h"
#import "NewWorkOrderViewController.h"
#import "AddLineItemCell.h"
#import "Appointment.h"
#import "CommonAppointmentViewController.h"
#import "Estimate.h"

@class Material;
@protocol AddLineItemDelegate <NSObject>

- (void)getMaterialInfo:(Material*)mat;

@end

@interface AddLineItemViewController : CommonAppointmentViewController<DataSelectionDelegate,UITableViewDataSource,UITableViewDelegate,AddLineItemDelegate,UITextFieldDelegate>{
    
    id<NewWorkOrderDelegate> _delegate;
    IBOutlet UITableView * _tblView;
    Appointment * _appointment;
    Estimate * estimate;
    Material * material;
    NSNumberFormatter *formatter;
    LineItem *_currentLineItem;
    
    BOOL _is_adding_new;
}

@property (nonatomic ,retain) id<NewWorkOrderDelegate> delegate;
@property (nonatomic ,retain) UITableView * tblView;
@property (nonatomic ,retain) Appointment * appointment;
@property (nonatomic ,retain) Estimate * estimate;
@property (nonatomic, retain) LineItem *currentLineItem;

- (IBAction)saveClicked:(id)sender;


+ (AddLineItemViewController *)initViewControllerNewWorkOrderAppointment:(Appointment*)app andLineItem:(LineItem*)lineItem Delegate:(id<NewWorkOrderDelegate>)del;
+ (AddLineItemViewController *)initViewControllerEstimate:(Estimate *)est andLineItem:(LineItem *)lineItem Delegate:(id<NewWorkOrderDelegate>)del;

@end
