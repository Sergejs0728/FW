//
//  LineItemTableCell.m
//  FieldWork
//
//  Created by Samir Khatri on 8/11/14.
//
//

#import "LineItemTableCell.h"

@implementation LineItemTableCell
@synthesize lblName=_lblName;
@synthesize lblPrice=_lblPrice;
@synthesize lblQty=_lblQty;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
