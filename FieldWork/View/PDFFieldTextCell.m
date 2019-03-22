//
//  PDFFieldTextCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 31.08.16.
//
//

#import "PDFFieldTextCell.h"

@interface PDFFieldTextCell()
@property (weak, nonatomic) IBOutlet UILabel *lablel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) NSInteger maxLength;
@property (strong,nonatomic)NSString* value;
@property (nonatomic) BOOL hasPlaceholder;
@property (strong,nonatomic) NSAttributedString* defaultText;
@property (strong,nonatomic) UITapGestureRecognizer* textVewTap;
@end

@implementation PDFFieldTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setField:(PDFField *)field{
    _field=field;
    [_lablel setText:[NSString stringWithFormat:@"%@:",field.label]];
    [_textField setDelegate:self];
    NSString* defaultText=field.default_value;
    if (field.field_value) {
        NSLog(@"%@ field_value %@",field.label,field.default_value);
        [_textField setText:field.field_value];
    }
    else{
        if (defaultText) {
            NSLog(@"%@ default_value %@",field.label,field.default_value);
            [_textField setText:defaultText];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    if (_field.max_lengthValue>0) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= _field.max_lengthValue;
    }
    else{
        return YES;
    }

}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    _value=textField.text;
    if (_block) {
        _block(_value);
    }
}

@end
