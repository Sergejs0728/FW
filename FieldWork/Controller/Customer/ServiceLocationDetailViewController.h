//
//  ServiceLocationDetailViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 2/27/14.
//
//

#import <UIKit/UIKit.h>
#import "ServiceLocation.h"
#import "BaseViewController.h"
#import "ContactListViewController.h"
#import "AppointmentDetailAddressCell.h"
#import "WorkHistoryTableViewController.h"

@interface ServiceLocationDetailViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    ServiceLocation *_service_location;
    IBOutlet UITableView*_detail_table;
    IBOutlet UILabel *lblContectHed_name;
    
    IBOutlet UIScrollView *_scrollView;
    //service
    IBOutlet UILabel *lblCustomerName;
    
    // billing
    IBOutlet UILabel *billing_lblCustomerName;
    IBOutlet UILabel *billing_lblAddress;
    IBOutlet UILabel *billing_lblContactName;
    IBOutlet UIButton * addressViewRoundCornerbtn;
    IBOutlet UIButton * BillingAddressViewRoundCornerbtn;
    
    
    
    
    
    IBOutlet UIButton *drivingDirectionBtn;
    
    IBOutlet AppointmentDetailAddressCell *_addressCell;
    
    
    NSMutableArray* _phoneList;
    NSMutableArray* _phoneKindsList;
    
}
@property (nonatomic, retain, readwrite) ServiceLocation *service_location;
@property(nonatomic,retain)UITableView *detail_table;

@property (nonatomic, retain)UIScrollView *scrollView;

+ (ServiceLocationDetailViewController*) viewControllerWithServiceLocation:(ServiceLocation*) ser_loc;

@end
