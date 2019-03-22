//
//  WorkHistoryTableViewController.h
//  FieldWork
//
//  Created by Mac4 on 13/10/14.
//
//

#import <UIKit/UIKit.h>
#import "ServiceLocation.h"
#import "WorkHistoryDelegate.h"
#import "WorkHistoryCell.h"
#import "WOHistoryDetailController.h"

@interface WorkHistoryTableViewController : UIViewController<WorkHistoryDelegate>
{
    ServiceLocation *_service_location;
    NSMutableArray *_workHistory;
    IBOutlet UITableView *_tblWorkHistory;
}

@property (nonatomic, retain, readwrite) ServiceLocation *service_location;

+(WorkHistoryTableViewController *)viewControllerWithServiceLocation:(ServiceLocation*) serloc;


@end
