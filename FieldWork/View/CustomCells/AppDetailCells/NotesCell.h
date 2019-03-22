//
//  NotesCell.h
//  FieldWork
//
//  Created by Samir on 11/2/15.
//
//

#import <UIKit/UIKit.h>

@interface NotesCell : UITableViewCell
{
    IBOutlet UILabel *publicNotesLabel;
    IBOutlet UILabel *privateNotesLabel;
    IBOutlet UIButton *editButton;
    
}


- (CGFloat)getCellHeight;
@end
