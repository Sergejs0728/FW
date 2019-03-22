//
//  WorkPoollistViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 9/21/15.
//
//

#import <UIKit/UIKit.h>
#import "WorkPoolMapViewController.h"
#import "BaseViewController.h"
#import "AppointmentManager.h"
#import "ActivityIndicator.h"
#import "AppointmentCell.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "NewAppointmentViewController.h"
#import "SamcomActionSheet_iPad.h"

@interface WorkPoollistViewController : BaseViewController<UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,iPadSamcomActionSheetDelegate>{

    IBOutlet UITableView * tblView;
    NSMutableArray *appointments;
    NSMutableDictionary *_aapt_ids_distance;
    UIPickerView *monthSelector;
    IBOutlet UIView *datesView;

    __weak IBOutlet UITextField *selectMonthText;
    

}
@property (nonatomic, retain)CLLocation* userLocation;

+ (WorkPoollistViewController*)initViewController;

- (void) loadTable;

- (void) refreshWorkPoolAppointments;

- (void) flipViewToMap;

-(IBAction)monthPickerClicked:(id)sender;



@end
