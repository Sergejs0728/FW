//
//  WorkOrderDetailsViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 3/4/14.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "AddLineItemViewController.h"
#import "NewWorkOrderViewController.h"

@interface WorkOrderDetailsViewController :CommonAppointmentViewController<UITableViewDataSource,UITableViewDelegate, NewWorkOrderDelegate>
{
    IBOutlet UIScrollView *_workorder_scrollview;
    IBOutlet UITableView *_work_detail_table;
    IBOutlet UIView *_bottom_view;
    IBOutlet UITextView *_txtView;
    NSMutableArray *_line_items;
    
    IBOutlet UIView *_tblSectionHeaderView;
   
    
}
+(WorkOrderDetailsViewController*)viewControllerWithAppointment:(Appointment*) app;
@property(nonatomic,retain)NSMutableArray *line_items;
@property(nonatomic,retain)UIScrollView *workorder_scrollview;
@property(nonatomic,retain)UIView *bottom_view;
@property(nonatomic,retain)UITableView *work_detail_table;
@property(nonatomic,retain)UITextView *txtView;

- (void) adjustHeightOfTableview;
- (void) addNewLineItem;
- (void) loadTable;
@end
