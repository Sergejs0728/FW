//
//  SideMenuTableViewCell.h
//  FieldWork
//
//  Created by Павел on 17.06.15.
//  Copyright (c) 2015 Павел Шереметов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuTableViewCell : UITableViewCell
{
    IBOutlet UIImageView *icon;
    IBOutlet UILabel *label;
}

- (void)setTitle:(NSString*)title andImage:(UIImage*)image;

@end
