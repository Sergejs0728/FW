//
//  AddUnitViewController.h
//  FieldWork
//
//  Created by Alexander Kotenko on 10.05.17.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "Unit.h"
typedef enum {
    AddUnitNumber = 0,
    AddUnitType ,
    AddUnitTenantName,
    AddUnitPhone1 ,
    AddUnitPhone2 ,
    AddUnitEmail1 ,
    AddUnitEmail2 ,
    AddUnitNotes ,
    AddUnitCount
}AddUnitCellRows;



@protocol AddUnitViewControllerDelegate <NSObject>
- (void) addUnitViewControllerDidFinish:(Unit*)unit;
@end

@interface AddUnitViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) ServiceLocation* serviceLocation;
@property (weak, nonatomic) id<AddUnitViewControllerDelegate>delegate;
@end
