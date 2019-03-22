//
//  CustomerDetailViewController.h
//  FieldWork
//
//  Created by Samir Kha on 19/02/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppotmentDetailCell.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "DrivingDirectionMap.h"
#import "CustomerServiceLocationListControllerViewController.h"
#import "ContactListViewController.h"
#import "AppointmentDetailAddressCell.h"
#import "Customer.h"
@interface CustomerDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate>
{  
    Customer *cust;

      //  Appointment *appointment;
    
    IBOutlet UILabel *lblContectHed_name;
    
    IBOutlet UIScrollView *_scrollView;
    //service
    IBOutlet UILabel *lblCustomerName;
    IBOutlet UILabel *lblAddress;
    IBOutlet UILabel *lblContactName;
    // billing
    IBOutlet UILabel *billing_lblCustomerName;
    IBOutlet UILabel *billing_lblAddress;
    IBOutlet UILabel *billing_lblContactName;
    IBOutlet UIButton * addressViewRoundCornerbtn;
    IBOutlet UIButton * BillingAddressViewRoundCornerbtn;
   
    
    
    IBOutlet UITableView *CustomerTable;
   
    IBOutlet UIButton *drivingDirectionBtn;
    
    IBOutlet AppointmentDetailAddressCell *_addressCell;
    
    NSMutableArray* _phoneList;
    NSMutableArray* _phoneKindsList;
}
+ (CustomerDetailViewController*) initWithAppointment:(Customer*) app;
@property (nonatomic ,retain) UITableView * CustomerTable;
@property (nonatomic,assign)BOOL isHidden;
@property (nonatomic, retain, readwrite) Customer *cust;
@property (nonatomic, retain)UIScrollView *scrollView;


-(IBAction)displayDrivingDirectionMap:(id)sender;

- (void) editCustomerClicked;



@end
