//
//  PDFFieldNumberCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import "PDFFieldNumberCell.h"

@interface PDFFieldNumberCell ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong,nonatomic) NSString* value;
@end

@implementation PDFFieldNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_textField setText:_value];
    [_textField setDelegate:self];
    // Initialization code
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
  _value=textField.text;
    if (_block) {
        _block(_value);
    }
}

-(void)setupWithLabel:(NSString*) label{
    [_label setText:label];
}
-(void)setField:(PDFField *)field{
    _field=field;
    [_label setText:field.label];
}
-(NSString*)getValue{
    return self.textField.text;
}

@end
