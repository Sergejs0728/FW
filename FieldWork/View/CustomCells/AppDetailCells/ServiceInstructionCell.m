//
//  ServiceInstructionCell.m
//  FieldWork
//
//  Created by Samir on 11/2/15.
//
//

#import "ServiceInstructionCell.h"

@implementation ServiceInstructionCell

- (void)awakeFromNib {
    // Initialization code
}

- (CGFloat)getLabelHeight
{
    CGFloat height = serviceInstructionsLabel.frame.size.height;
    return height + 16;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
