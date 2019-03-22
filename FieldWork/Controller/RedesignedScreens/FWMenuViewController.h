//
//  FWMenuViewController.h
//  FieldWork
//
//  Created by Samir on 10/28/15.
//
//

#import <UIKit/UIKit.h>
#import "UIViewController+MFSideMenuAdditions.h"
#import "NewAppointmentViewController.h"
#import "NewCustomerTableViewController.h"
#import "SideTableViewCell.h"
#import "WorkPoolViewController.h"
#import "CustomerListViewController.h"
@class SettingController;
@interface FWMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UINavigationController *appointmentsNavigationController;
@property (nonatomic, strong) UINavigationController *customersNavigationController;
@property (nonatomic, strong) UINavigationController *settingsNavigationController;
@property (nonatomic, strong) UINavigationController *workPoolNavigationController;
@property (nonatomic ,retain)  NewAppointmentViewController *appController;


@property (nonatomic, retain) IBOutlet UITableView *tblView;
@property (nonatomic ,retain) IBOutlet UIImageView * imgInternetStatus;
@property (nonatomic ,weak) IBOutlet UILabel *lblStatusText;

+(FWMenuViewController *)initViewController;
- (IBAction)logoutClicked:(id)sender;

-(void)reachabilityChanged:(NSNotification*)note;
@end
