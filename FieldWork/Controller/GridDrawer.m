//
//  GridDrawer.m
//  TestDraw
//
//  Created by Alexander on 01.09.16.
//  Copyright © 2016 Alexander. All rights reserved.
//

#import "GridDrawer.h"

@implementation GridDrawer

+(void)generateGrindonView:(UIView*)view colour:(UIColor*) lineColour lineWidth:(CGFloat) lineWidth{
    CALayer* verticalLines=[self drawVerticalLines:view colour:lineColour lineWidth:lineWidth];
//    verticalLines.zPosition=-10;
    CALayer* horizontalLines=[self drawHorizontalLines:view colour:lineColour lineWidth:lineWidth];
//    horizontalLines.zPosition=-10;
    [view.layer insertSublayer:verticalLines below:view.layer];
    [view.layer insertSublayer:horizontalLines below:view.layer];
}

+(NSInteger)calculateQuantity:(CGFloat) size{
    CGFloat px=15;
    return (NSInteger)(size/px);
}

+(CALayer*)drawVerticalLines:(UIView*)view colour:(UIColor*) lineColour lineWidth:(CGFloat) lineWidth{
  
    NSInteger quantity = [self calculateQuantity:view.frame.size.width];
    NSInteger height = view.frame.size.height;
    NSInteger step = view.frame.size.width/quantity;
      NSInteger start = 0;
    CALayer* layer= [CALayer layer];
    for (NSInteger i = 0; i <quantity+1 ; i++) {
        CALayer* subLayer= [self drawLineFrom:CGPointMake(start, 0) to:CGPointMake(start, height) colour:lineColour lineWidth:lineWidth];
        [layer addSublayer:subLayer];
        start+=step;
    }
    return layer;
}

+(CALayer*)drawHorizontalLines:(UIView*)view colour:(UIColor*) lineColour lineWidth:(CGFloat) lineWidth{
    NSInteger quantity = [self calculateQuantity:view.frame.size.height];
    NSInteger width = view.frame.size.width;
    NSInteger step = view.frame.size.height/quantity;
    NSInteger start = step;
    CALayer* layer= [CALayer layer];
    for (NSInteger i = 0; i <quantity; i++) {
        CALayer* subLayer= [self drawLineFrom:CGPointMake(0, start) to:CGPointMake(width, start) colour:lineColour lineWidth:lineWidth];
        [layer addSublayer:subLayer];
        start+=step;
    }
    return layer;
}

+(CAShapeLayer*) drawLineFrom:(CGPoint) fromPoint to:(CGPoint) destPoint  colour:(UIColor*) colour lineWidth:(CGFloat) width{
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: fromPoint];
    [linePath addLineToPoint:destPoint];
    line.path=linePath.CGPath;
    line.fillColor = nil;
    line.opacity = 1.0;
    line.strokeColor = colour.CGColor;
    return line;
}

@end
