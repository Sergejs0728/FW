//
//  NotesCell.m
//  FieldWork
//
//  Created by Samir on 11/2/15.
//
//

#import "NotesCell.h"

@implementation NotesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)getCellHeight
{
    CGFloat publicLabelHeight = publicNotesLabel.frame.size.height;
    CGFloat privateLabelHeight = privateNotesLabel.frame.size.height;
    CGFloat buttonHeight = editButton.frame.size.height;
    return 8 + 21 + 8 + publicLabelHeight + 8 + 21 + 8 + privateLabelHeight + 8 + buttonHeight + 8;
}

@end
