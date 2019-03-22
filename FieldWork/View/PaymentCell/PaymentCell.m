//
//  PaymentCell.m
//  FieldWork
//
//  Created by SAMCOM on 15/12/15.
//
//

#import "PaymentCell.h"

@implementation PaymentCell
@synthesize lblnm,txtvalue;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end
