//
//  WorkHistoryCell.h
//  FieldWork
//
//  Created by Mac4 on 13/10/14.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"

@interface WorkHistoryCell : UITableViewCell
{
    IBOutlet UILabel *_lblDateWoNumber;
    IBOutlet UILabel *_lblNotes;
}

- (void) setData:(Appointment*) app;

@end
