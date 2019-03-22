//
//  AppotmentDetailCell.m
//  FieldWork
//
//  Created by Samir Kha on 21/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppotmentDetailCell.h"

@implementation AppotmentDetailCell

@synthesize lbl1=lbl1_;
@synthesize lbl2=lbl2_;

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
