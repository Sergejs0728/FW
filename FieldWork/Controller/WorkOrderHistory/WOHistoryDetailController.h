//
//  WOHistoryDetailController.h
//  FieldWork
//
//  Created by Mac4 on 21/11/14.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "Appointment.h"
#import "UIPlaceHolderTextView.h"
#import "MaterialusetablelistCell.h"

@interface WOHistoryDetailController : CommonAppointmentViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UILabel *_lblWONumber;
    IBOutlet UILabel *_lblDate;
    IBOutlet UILabel *_lblTime;
    IBOutlet UILabel *_lblStatus;
    IBOutlet UIPlaceHolderTextView *_txtNotes;
    IBOutlet UIView *_vStatusView;
    
    IBOutlet UITableView *_tblMain;
}

+ (WOHistoryDetailController*) viewControllerWithWorkOrder:(Appointment*) app;

@end
