//
//  DottedView.m
//  FieldWork
//
//  Created by SamirMAC on 12/16/15.
//
//

#import "DottedView.h"

@implementation DottedView

- (void)awakeFromNib {
    self.showDottedBorderAndButton = YES;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (self.showDottedBorderAndButton) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);
        
        CGFloat dashes[] = {1,1}; // 3
        
        CGContextSetLineDash(context, 0.0, dashes, 2);
        CGContextSetLineWidth(context, 1.0);
        
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextSetShouldAntialias(context, NO);
        CGContextStrokePath(context);

        
        
        [_btnTouch setTitle:@"Touch to add." forState:UIControlStateNormal];
        [_btnTouch setTitle:@"Touch to add." forState:UIControlStateHighlighted];

        
    }else {
        [_btnTouch setTitle:@"" forState:UIControlStateNormal];
        [_btnTouch setTitle:@"" forState:UIControlStateHighlighted];
    }
    
    if (self.hideButton == YES) {
        [_btnTouch setHidden:YES];
        [_btnTouch setUserInteractionEnabled:NO];
    }
}

- (void) addButtonClickBlock:(GeneralNotificationBlock)block
{
    [_btnTouch setAction:kUIButtonBlockTouchUpInside withBlock:^{
        block();
    }];
}


- (void) configureDottedView
{
    //[self.layer addSublayer:[self addDashedBorderWithColor:[[UIColor blackColor] CGColor]]];
    [self setBackgroundColor:[UIColor lightGrayColor]];
}

- (CAShapeLayer *) addDashedBorderWithColor: (CGColorRef) color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    CGSize frameSize = self.frame.size;
    
    CGRect shapeRect = CGRectMake(0.0f, 0.0f, frameSize.width, frameSize.height);
    [shapeLayer setBounds:shapeRect];
    [shapeLayer setPosition:CGPointMake( frameSize.width/2,frameSize.height/2)];
    
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:color];
    [shapeLayer setLineWidth:5.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],
      nil]];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:shapeRect cornerRadius:15.0];
    [shapeLayer setPath:path.CGPath];
    
    return shapeLayer;
}

@end
