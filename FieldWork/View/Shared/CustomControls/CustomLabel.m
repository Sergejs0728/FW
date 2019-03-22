//
//  CustomLabel.m
//  FieldWork
//
//  Created by Samir on 11/25/15.
//
//

#import "CustomLabel.h"

@implementation CustomLabel

- (void)awakeFromNib {
    [self setBackgroundColor:[UIColor colorWithRed:159.0/255.0f green:159.0/255.0f blue:159.0/255.0f alpha:1.0f]];
    [self setFont:[UIFont systemFontOfSize:11]];
    [self setTextColor:[UIColor whiteColor]];
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 5, 0, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end
