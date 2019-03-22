//
//  FWBottomLineTextField.m
//  FieldWork
//
//  Created by Samir Khatri on 3/29/14.
//
//

#import "FWBottomLineTextField.h"

@implementation FWBottomLineTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}
*/

- (void)awakeFromNib {
    
//    self.borderStyle = UITextBorderStyleNone;
//    float line_height = 1.0f;
//    
//    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - line_height, self.frame.size.width, line_height)];
//    bottomBorder.backgroundColor = [UIColor colorWithRed:194.00/255.0f green:192.0/255.0f blue:199.0/255.0f alpha:1.0f];
//    
//    [self addSubview:bottomBorder];
    [self setBorderStyle:UITextBorderStyleRoundedRect];
    [self setAutocapitalizationType:UITextAutocapitalizationTypeSentences];
}

@end
