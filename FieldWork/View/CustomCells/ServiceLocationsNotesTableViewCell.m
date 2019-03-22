//
//  ServiceLocationsNotesTableViewCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 12.04.16.
//
//

#import "ServiceLocationsNotesTableViewCell.h"

#define kMaxNotTruncatedLinesCount 3

@interface ServiceLocationsNotesTableViewCell () {
    CGFloat _buttonViewHeight;
    
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraintButtonViewHeight;

@end

@implementation ServiceLocationsNotesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.buttonView.hidden = YES;
    _buttonViewHeight = _constraintButtonViewHeight.constant;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setNotes:(NSString *)notes {
    _notes = notes;
    self.buttonView.selected = _isShort;
    self.labelNotes.text = notes;
    if ([self lineCountForText:self.notes] > kMaxNotTruncatedLinesCount) {
        self.buttonView.hidden = NO;
        _constraintButtonViewHeight.constant = _buttonViewHeight;
    } else {
        self.buttonView.hidden = YES;
        _constraintButtonViewHeight.constant = 0;
    }
    [self adjustContent];
}

- (void)adjustContent {
    if (_isShort) {
        self.labelNotes.numberOfLines = 0;
    } else {
        self.labelNotes.numberOfLines = kMaxNotTruncatedLinesCount;
    }
}

- (int)lineCountForText:(NSString *) text
{
    UIFont *font = self.labelNotes.font;
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.labelNotes.frame.size.width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : font}
                                     context:nil];
    
    return ceil(rect.size.height / font.lineHeight);
}

- (CGFloat)calculateHeight {
    [self setNeedsLayout];
//    [self layoutIfNeeded];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}


- (IBAction)buttonViewClicked:(UIButton *)sender {
//    sender.selected = !sender.selected;
    _isShort = !_isShort;
    [self adjustContent];
    if (self.viewAction != nil) {
        self.viewAction();
    }
}


@end
