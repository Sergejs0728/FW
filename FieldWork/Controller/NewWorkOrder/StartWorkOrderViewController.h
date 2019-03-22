//
//  NewWorkOrderDetailViewController.h
//  FieldWork
//
//  Created by SAMCOM on 15/12/15.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "ServiceLocation.h"

@interface StartWorkOrderViewController : CommonAppointmentViewController
{
    UITableView *Tblobj;
}
@property(nonatomic,strong) IBOutlet UITableView *Tblobj;

+(StartWorkOrderViewController *)initViewControllerWithAppointment:(Appointment*)app;

- (IBAction)btnStartClicked:(id)sender;

@end
