//
//  WorkOrderDeatilCell.m
//  FieldWork
//
//  Created by SAMCOM on 15/12/15.
//
//

#import "WorkOrderDeatilCell.h"

@implementation WorkOrderDeatilCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)calculateHeight {
    [self setNeedsLayout];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat height = MAX(size.height + 1, 166);
    return height;
}

@end
