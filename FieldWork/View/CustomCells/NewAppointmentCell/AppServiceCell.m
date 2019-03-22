//
//  AppServiceCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppServiceCell.h"

@implementation AppServiceCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)getLabelHeight
{
    CGFloat height = serviceInstructionsLabel.frame.size.height;
    return height + 16;
}

- (void)setServiceInstructionsText:(NSString*)text
{

    CGRect frame = TEXT_SIZE(text, 15);
    
    serviceInstructionsLabel.frame = CGRectMake(serviceInstructionsLabel.frame.origin.x,serviceInstructionsLabel.frame.origin.y , [UIScreen mainScreen].bounds.size.width,frame.size.height);

    serviceInstructionsLabel.text = text;
//    serviceInstructionsLabel.numberOfLines = 0;
    [serviceInstructionsLabel sizeToFit];
  
    [self layoutIfNeeded];

}
@end
