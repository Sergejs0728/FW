//
//  DocumentListViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 3/20/14.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "DocumentListCell.h"
#import "FWPDFForm.h"
#import "PDFAttachment.h"

@interface DocumentListViewController : CommonAppointmentViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_table;
}

+ (DocumentListViewController*) viewComntrollerWithAppointment:(Appointment*) app;

- (void) reloadTable;

@end
