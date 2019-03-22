//
//  AddUnitTextViewCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 10.05.17.
//
//

#import "AddUnitTextViewCell.h"
@interface AddUnitTextViewCell() <UITextViewDelegate>
@end
@implementation AddUnitTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)textViewDidChange:(UITextView *)textView {
    if(_blockDidChange){
        _blockDidChange(textView.text);
    }
}

@end
