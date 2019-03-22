//
//  NewAppointmentViewController.h
//  FieldWork
//
//  Created by Samir on 10/26/15.
//
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>
#import "GameTimer.h"
#import "SyncManager.h"
#import "NewCustomerTableViewController.h"
#import "NoAppointmentTableViewCell.h"
#import "AppointmentCell.h"
#import "NewWorkOrderViewController.h"
#import "WorkPoolViewController.h"
#import "NewAppointMentsDetailViewController.h"
#import "AppointmentManager.h"
#import "Appointment.h"
#import "LineItem.h"

#import "StartWorkOrderViewController.h"

@interface NewAppointmentViewController : UIViewController<JTCalendarDelegate,UITableViewDelegate,UITableViewDataSource,GameTimerDelegate>
{
    IBOutlet JTCalendarMenuView *calendarMenuView;
    IBOutlet JTHorizontalCalendarView *calendarContentView;
    IBOutlet NSLayoutConstraint *calendarContentViewHeight;
    
   
   
    NSMutableArray *dataArray;
    NSMutableArray *customerArray;
    NSDate *_selecteddate;
    
    IBOutlet UILabel *_lblTotalApp;
    IBOutlet UILabel *_lblTotalAmount;
    
    IBOutlet UIView *dateView;
    IBOutlet UIView *appointmentView;
    
    IBOutlet UIButton *previousBtn;
    IBOutlet UIButton *nextBtn;
    
    BOOL _isLoading;
   
    
    IBOutlet UIView *_vSyncingView;
    
    IBOutlet NSLayoutConstraint *_calendarHeightContraint;
    
    
}


@property (nonatomic, retain)UIRefreshControl *refreshControl;

@property (strong, nonatomic) JTCalendarManager *calendar;

@property (nonatomic, retain)IBOutlet UITableView *tblAppList;


-(IBAction)menuClicked:(id)sender;

- (void) reloadAppointment;

- (void)loadTable:(BOOL)refresh beetweenDays:(BOOL)beetweenValue;

- (void) addNewWorkOrder;

- (void) reloadTable;

- (void) logout;



@end
