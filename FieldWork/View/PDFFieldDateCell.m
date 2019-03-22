//
//  PDFFieldDateCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import "PDFFieldDateCell.h"

@interface PDFFieldDateCell()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong,nonatomic)NSString* value;
@end

@implementation PDFFieldDateCell



- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeTextFieldInputView];
    [_dateTextField setDelegate:self];
//    [_dateTextField setDelegate:self];
    // Initialization code
}

-(void)setupWithLabel:(NSString*)label {
    [_label setText:label];
//    _dateBlock=block;
}
-(void)setField:(PDFField *)field{
    _field=field;
    _value = field.field_value;
    [_label setText:field.label];
    [_dateTextField setText:_value];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
   _value=textField.text;
    if (_block) {
        _block(_value);
    }
}

- (void) initializeTextFieldInputView {
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self
                   action:@selector(dateUpdated:)
         forControlEvents:UIControlEventValueChanged];
    self.dateTextField.inputView = datePicker;
}
- (void) dateUpdated:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    self.dateTextField.text = [formatter stringFromDate:datePicker.date];
}

@end
