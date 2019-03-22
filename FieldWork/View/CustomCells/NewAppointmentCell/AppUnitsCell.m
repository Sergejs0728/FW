//
//  AppUnitsCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppUnitsCell.h"
@interface AppUnitsCell()


@end

@implementation AppUnitsCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addButtonTapped:(UIButton *)sender {
    if(_addUnit){
        _addUnit();
    }
}

- (IBAction)viewAllButtonTapped:(UIButton *)sender {
    if(_viewAllUnits){
        _viewAllUnits();
    }
}

@end
