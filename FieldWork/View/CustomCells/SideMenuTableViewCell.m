//
//  SideMenuTableViewCell.m
//  FieldWork
//
//  Created by Павел on 17.06.15.
//  Copyright (c) 2015 Павел Шереметов. All rights reserved.
//

#import "SideMenuTableViewCell.h"

@implementation SideMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString*)title andImage:(UIImage*)image
{
    label.text = title;
    icon.image = image;
}

@end