//
//  PDFFieldCheckboxCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import "PDFFieldCheckboxCell.h"

@interface PDFFieldCheckboxCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *checkboxButton;

@end

@implementation PDFFieldCheckboxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}


-(void)setField:(PDFField *)field{
    _field=field;
    [_label setText:field.label];
    NSString* value= field.field_value;
    if ([value isEqualToString:@"Yes"]) {
        [_checkboxButton setSelected:YES];
    }
    else{
        [_checkboxButton setSelected:NO];
    }
}

- (IBAction)checkboxTapped:(UIButton *)sender {
    if (!sender.isSelected) {
        [_field setField_value:@"Yes"];
        [sender setSelected:YES];
        if(_block){
            _block( @"Yes");
        }
    }
    else{
        [_field setField_value:@"Off"];
        [sender setSelected:NO];
        if(_block){
            _block( @"Off");
        }
    }
}


@end
