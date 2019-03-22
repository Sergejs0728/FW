//
//  FieldworkTextField.m
//  FieldWork
//
//  Created by Samir Khatri on 3/1/14.
//
//

#import "FieldworkTextField.h"

@implementation FieldworkTextField

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
-(void)awakeFromNib
{
    self.layer.cornerRadius=2.0f;
    self.layer.masksToBounds=YES;
    self.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    self.layer.borderWidth= 1.0f;

}
- (CGRect)textRectForBounds:(CGRect)bounds {
    int leftMargin = 5;
    CGRect inset = CGRectMake(bounds.origin.x + leftMargin, bounds.origin.y, bounds.size.width - leftMargin, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    int leftMargin = 5;
    CGRect inset = CGRectMake(bounds.origin.x + leftMargin, bounds.origin.y, bounds.size.width - leftMargin, bounds.size.height);
    return inset;
}

@end
