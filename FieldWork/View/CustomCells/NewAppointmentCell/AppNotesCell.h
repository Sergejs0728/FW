//
//  AppNotesCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "DottedView.h"


@interface AppNotesCell : UITableViewCell
{
    __weak IBOutlet UILabel *publicNotesLabel;
    __weak IBOutlet UILabel *privateNotesLabel;
    
    __weak IBOutlet DottedView *_privateNoteView;
    __weak IBOutlet DottedView *_publicNoteView;
    __weak IBOutlet UILabel *_lblPrivateNoteTitle;
    
    
}

- (CGFloat)getCellHeight;

- (void) setNotes:(Appointment*)appt;

- (void) setPublicNoteTouchBlock:(GeneralNotificationBlock)block;

- (void) setPrivateNoteTouchBlock:(GeneralNotificationBlock)block;

-(void) privateNotesLabel: (GeneralNotificationBlock)block;


@end
