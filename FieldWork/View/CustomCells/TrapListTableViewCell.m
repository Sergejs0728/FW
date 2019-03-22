//
//  TrapListTableViewCell.m
//  FieldWork
//
//  Created by Mac4 on 30/10/14.
//
//

#import "TrapListTableViewCell.h"

@implementation TrapListTableViewCell

@synthesize lblBarcode = _lblBarcode;
@synthesize lblFrequency = _lblFreqency;
@synthesize lblId = _lblId;
@synthesize lblLocationDetails = _lblLocationDetails;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
