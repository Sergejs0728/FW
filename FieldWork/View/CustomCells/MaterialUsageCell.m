//
//  MaterialUsageCell.m
//  FieldWork
//
//  Created by Samir Kha on 30/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MaterialUsageCell.h"

@implementation MaterialUsageCell

@synthesize lblMainLable, txtDataText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
   txtDataText.text=@"";
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
