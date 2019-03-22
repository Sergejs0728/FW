//
//  UnitListCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 17.05.17.
//
//

#import "UnitListCell.h"

@implementation UnitListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUnit:(Unit *)unit{
    [_unitNumberLabel setText:[NSString stringWithFormat:@"Unit #%@",unit.unit_number]];
    [_tenantNameLabel setText:unit.tenant_name];
}

@end
