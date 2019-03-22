//
//  PDFSelectItemCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 01.09.16.
//
//

#import "PDFSelectItemCell.h"

@interface PDFSelectItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *checkboxButton;

@end

@implementation PDFSelectItemCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

}

- (IBAction)checkboxTapped:(UIButton *)sender {
    if (!sender.isSelected) {
        [sender setSelected:YES];
        if (_checkBlock) {
            _checkBlock(_option,YES);
        }
    }
    else{
        [sender setSelected:NO];
        if (_checkBlock) {
            _checkBlock(_option,NO);
        }
    }
}

-(void)setOption:(NSString *)option{
    _option=option;
    [_label setText:option];
}


-(void)initialize{
    if (_value) {
        if ([_option isEqualToString:_value]) {
            [self setChecked:YES];
            return;
        }
        else{
            [self setChecked:NO];
        }
    }
    else{
        if([_option isEqualToString:_defaultOption]){
            [self setChecked:YES];
        }
        else{
            [self setChecked:NO];
        }
    }
}



-(void)setChecked:(BOOL) checked{
    [_checkboxButton setSelected:checked];

}

@end
