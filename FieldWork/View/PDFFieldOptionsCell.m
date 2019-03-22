//
//  PDFFieldOptionsCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 31.08.16.
//
//

#import "PDFFieldOptionsCell.h"

@interface PDFFieldOptionsCell ()
@property (weak, nonatomic) IBOutlet UILabel *lablel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) NSInteger maxLength;
@property (strong, nonatomic) NSArray* options;
@property (strong,nonatomic) UIPickerView *pickerView ;
@property (nonatomic) BOOL hasPlaceholder;
@property (strong,nonatomic) NSAttributedString* defaultText;
@property (strong,nonatomic) UITapGestureRecognizer* textVewTap;
@property (strong,nonatomic) NSArray* optionsFiltered;
@end
@implementation PDFFieldOptionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _pickerView = [[UIPickerView alloc] init];
    _textField.inputView=_pickerView;
    // Initialization code
}

-(void)setField:(PDFField *)field{
    _field=field;
    [_lablel setText:[NSString stringWithFormat:@"%@:",field.label]];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator = YES;
    _options=_field.options;
    if (!_options) {
        _options = [NSArray array];

    }
    NSPredicate* filterPredicate= [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSString* evaluatedString=evaluatedObject;
        return (![evaluatedString isEqualToString:@"Off"]);
    }];
    _optionsFiltered=[_options filteredArrayUsingPredicate:filterPredicate];
    if (field.field_value && ![field.field_value isEqualToString:@"Off"]) {
        _textField.text = field.field_value;
    }
    else{
        [_textField setText:@""];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_optionsFiltered) {
        return _optionsFiltered.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_optionsFiltered) {
        return _optionsFiltered[row];
        }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString* value=[_optionsFiltered objectAtIndex:row];
    _textField.text = value;
    if (value &&_block) {
        _block(value);
    }
    [self endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return NO;
}
@end
