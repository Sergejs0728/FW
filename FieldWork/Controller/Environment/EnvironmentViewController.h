//
//  EnvironmentViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 29/07/2013.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "CommonAppointmentViewController.h"
#import "DataTableViewController.h"
#import "AppointmentDelegate.h"
#import "TableExpanderView.h"
typedef void(^OnPopBlock)(id result);
@interface EnvironmentViewController : CommonAppointmentViewController<UITableViewDataSource, UITableViewDelegate, DataSelectionDelegate>
{
    
    IBOutlet UITableView *mainTable;
    IBOutlet TableExpanderView *tableExpander;
    IBOutlet UIScrollView *scrollView;
    
    
}
+(EnvironmentViewController *)initWithAppointment:(Appointment *)app;
@property (strong,nonatomic) OnPopBlock onPopBlock;

-(IBAction)SaveEnvironment:(id)sender;

@end
