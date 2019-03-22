//
//  AddUnitFieldCell.m
//  FieldWork
//
//  Created by Alexander Kotenko  on 10.05.17.
//
//

#import "AddUnitFieldCell.h"
@interface AddUnitFieldCell()<UITextFieldDelegate>
@end
@implementation AddUnitFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _field.delegate=self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_blockDidChange) {
        _blockDidChange(textField.text);
    }
}
@end
