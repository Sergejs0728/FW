//
//  DrawSignature.m
//  SignatureDemo
//
//  Created by Samir Kha on 17/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DrawSignature.h"

@implementation DrawSignature

@dynamic sigPoints;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        mainFrame = frame;
    }
    return self;
}

- (void)setSigPoints:(NSMutableArray *)sigPoints {
    _sigPoints = sigPoints;
    NSMutableArray *points = [[NSMutableArray alloc] init];
    for (SignaturePoint *sp in sigPoints) {
        [points addObject:[NSNumber numberWithFloat:sp.ly]];
        [points addObject:[NSNumber numberWithFloat:sp.lx]];
        [points addObject:[NSNumber numberWithFloat:sp.my]];
        [points addObject:[NSNumber numberWithFloat:sp.mx]];
    }
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [points sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    float viewWidth = mainFrame.size.width - 5;//5
    float highestPoint = [[points objectAtIndex:0] floatValue];
    float factorx = (viewWidth / highestPoint); //0.13
    float viewHeight = mainFrame.size.height - 5;//5
    float factory = (viewHeight / highestPoint);

    factor = factorx > factory ? factory : factorx;
    NSLog(@"%f", factor);
    if (factor < 0) {
        factor = 0.5;
    }
    factor = 0.5;//0.6
}

- (NSMutableArray *)sigPoints {
    return _sigPoints;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Set drawing params
	CGContextSetLineWidth(context,1.0f);
	CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
	CGContextSetLineCap(context, kCGLineCapButt);
	CGContextSetLineJoin(context, kCGLineJoinRound);
	CGContextBeginPath(context);
	
	// This flag tells us to move to the point
	// rather than draw a line to the point
	
	// Loop through the strings in the array
	// which are just serialized CGPoints
//    float factor = 0.35;
    //BOOL isFirst = YES;
    //NSLog(@"%@",isFirst);
	for (SignaturePoint *touchString in self.sigPoints) {
		
        [touchString print];

		// If first point, move to it and continue. Otherwize, draw a line from
		// the last point to this one.
		CGContextMoveToPoint(context, touchString.lx * kDrawingFactor, touchString.ly * kDrawingFactor);
        CGContextAddQuadCurveToPoint(context,  touchString.lx * kDrawingFactor,  touchString.ly * kDrawingFactor,  touchString.mx * kDrawingFactor,  touchString.my * kDrawingFactor);
        CGContextAddLineToPoint(context,  touchString.mx * kDrawingFactor, touchString.my * kDrawingFactor);
	}	
	
	// Stroke it, baby!
	CGContextStrokePath(context);
}

@end
