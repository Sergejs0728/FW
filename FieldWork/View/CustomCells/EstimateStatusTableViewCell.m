//
//  EstimateStatusTableViewCell.m
//  FieldWork
//
//  Created by Alexander on 31.03.17.
//
//

#import "EstimateStatusTableViewCell.h"

@implementation EstimateStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)statusButtonTouched:(UIButton *)sender {
    if(_statusChanged){
        _statusChanged();
    }
    
}

-(void)setStatus:(NSString*)status{
    _status=status;
    [_statusLabel setText:_status];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

@end
