//
//  AppNotesCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppNotesCell.h"

@implementation AppNotesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)giveLabelHeight {
    CGSize constrain = CGSizeMake(privateNotesLabel.bounds.size.width, FLT_MAX);
    CGSize size = [privateNotesLabel.text sizeWithFont:privateNotesLabel.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];

}

- (CGFloat)getCellHeight
{
    CGFloat publicLabelHeight = [self getLabelHeightfromtext:publicNotesLabel.text];
    CGFloat privateLabelHeight = [self getLabelHeightfromtext:privateNotesLabel.text];
    CGFloat buttonHeight = 0;
    return 8 + 21 + 8 + publicLabelHeight + 8 + 21 + 8 + privateLabelHeight + 8 + buttonHeight + 8;
}

- (void) setNotes:(Appointment*)appt
{
    if (appt.notes == nil || appt.notes.length <= 0) {
        _publicNoteView.showDottedBorderAndButton = YES;
    } else {
        [publicNotesLabel setText:appt.notes];
        _publicNoteView.showDottedBorderAndButton = NO;
    }
    
    
    if (appt.private_notes == nil || appt.private_notes.length <= 0) {
        _privateNoteView.showDottedBorderAndButton = YES;
    } else {
        [privateNotesLabel setText:appt.private_notes];
        _privateNoteView.showDottedBorderAndButton = NO;
    }
    
        //[publicNotesLabel sizeToFit];
        //[privateNotesLabel sizeToFit];
    [self setLayoutFrame:appt];
    [self layoutIfNeeded];
    
    
    
}
- (void) setLayoutFrame:(Appointment *)app{
    
    CGRect note_rect = TEXT_SIZE(app.notes, 15);
    CGRect private_note_rect = TEXT_SIZE(app.private_notes, 15);
    
    
    publicNotesLabel.frame = CGRectMake(publicNotesLabel.frame.origin.x, publicNotesLabel.frame.origin.y, publicNotesLabel.frame.size.width, publicNotesLabel.frame.size.height);
    if (note_rect.size.height > 70) {
        publicNotesLabel.frame = CGRectMake(publicNotesLabel.frame.origin.x, publicNotesLabel.frame.origin.y, publicNotesLabel.frame.size.width, note_rect.size.height + 30);
    }
    
    _publicNoteView.frame = publicNotesLabel.frame;
    
    
    
    _lblPrivateNoteTitle.frame = CGRectMake(_lblPrivateNoteTitle.frame.origin.x, _publicNoteView.frame.origin.y + _publicNoteView.frame.size.height + 5, _lblPrivateNoteTitle.frame.size.width, _lblPrivateNoteTitle.frame.size.height);
    
    
    
    privateNotesLabel.frame = CGRectMake(privateNotesLabel.frame.origin.x, _lblPrivateNoteTitle.frame.origin.y + _lblPrivateNoteTitle.frame.size.height + 5, privateNotesLabel.frame.size.width, privateNotesLabel.frame.size.height);
    if (private_note_rect.size.height > 70) {
        privateNotesLabel.frame = CGRectMake(privateNotesLabel.frame.origin.x, _lblPrivateNoteTitle.frame.origin.y + _lblPrivateNoteTitle.frame.size.height + 5, privateNotesLabel.frame.size.width, private_note_rect.size.height + 30);
    }
    _privateNoteView.frame = privateNotesLabel.frame;
    
    
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _privateNoteView.frame.size.height + _publicNoteView.frame.size.height);
    
    
}

- (void) setPublicNoteTouchBlock:(GeneralNotificationBlock)block
{
    [_publicNoteView addButtonClickBlock:^{
        block();
    }];
}

- (void) setPrivateNoteTouchBlock:(GeneralNotificationBlock)block
{
    [_privateNoteView addButtonClickBlock:^{
        block();
    }];
}



-(CGFloat)getLabelHeightfromtext:(NSString *)txt{
    CGSize possibleSize = [txt sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:15] //font you are using
                             constrainedToSize:CGSizeMake(publicNotesLabel.frame.size.width,9999)
                                 lineBreakMode:NSLineBreakByWordWrapping];
    return possibleSize.height;
}

@end
