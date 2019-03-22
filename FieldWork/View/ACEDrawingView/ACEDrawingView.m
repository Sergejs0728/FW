/*
 * ACEDrawingView: https://github.com/acerbetti/ACEDrawingView
 *
 * Copyright (c) 2013 Stefano Acerbetti
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import "ACEDrawingView.h"
#import "ACEDrawingTools.h"

#import <QuartzCore/QuartzCore.h>

#define kDefaultLineColor       [UIColor blackColor]
#define kDefaultLineWidth       4.0f;
#define kDefaultLineAlpha       1.0f

// experimental code
#define PARTIAL_REDRAW          0

static NSTimer *_timer;

@interface ACEDrawingView () {
    CGPoint currentPoint;
    CGPoint previousPoint1;
    CGPoint previousPoint2;
    
    CGPoint lastTapPoint_;
    __strong NSMutableArray *handwritingCoords_;
    NSMutableArray *sigPoints;
}


@property(nonatomic,strong) NSMutableArray *handwritingCoords;
@property (nonatomic , retain, readwrite) NSMutableArray *signPoints;

@property (nonatomic, strong) NSMutableArray *pathArray;
@property (nonatomic, strong) NSMutableArray *bufferArray;
@property (nonatomic, strong) id<ACEDrawingTool> currentTool;
@property (nonatomic, strong) UIImage *image;

@end

#pragma mark -

@implementation ACEDrawingView

@synthesize signPoints;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    // init the private arrays
    self.pathArray = [NSMutableArray array];
    self.bufferArray = [NSMutableArray array];
    
    // set the default values for the public properties
    self.lineColor = kDefaultLineColor;
    self.lineWidth = kDefaultLineWidth;
    self.lineAlpha = kDefaultLineAlpha;
    
    // set the transparent background
    self.backgroundColor = [UIColor clearColor];
    
    self.handwritingCoords = [[NSMutableArray alloc] init];
    self.signPoints = [[NSMutableArray alloc] init];
}



- (void) takeScreenshot
{
    
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
#if PARTIAL_REDRAW
    // TODO: draw only the updated part of the image
    [self drawPath];
#else
    [self.image drawInRect:self.bounds];
    [self.currentTool draw];
#endif
    
    
}

- (void)updateCacheImage:(BOOL)redraw
{
    // init a context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    
    if (redraw) {
        // erase the previous image
        self.image = nil;
        
        // load previous image (if returning to screen)
        [[self.prev_image copy] drawInRect:self.bounds];
        
        // I need to redraw all the lines
        for (id<ACEDrawingTool> tool in self.pathArray) {
            [tool draw];
        }
        
    } else {
        // set the draw point
        [self.image drawAtPoint:CGPointZero];
        [self.currentTool draw];
    }
    
    // store the image
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (id<ACEDrawingTool>)toolWithCurrentSettings
{
    switch (self.drawTool) {
        case ACEDrawingToolTypePen:
        {
            return ACE_AUTORELEASE([ACEDrawingPenTool new]);
        }
            
        case ACEDrawingToolTypeLine:
        {
            return ACE_AUTORELEASE([ACEDrawingLineTool new]);
        }
            
        case ACEDrawingToolTypeRectagleStroke:
        {
            ACEDrawingRectangleTool *tool = ACE_AUTORELEASE([ACEDrawingRectangleTool new]);
            tool.fill = NO;
            return tool;
        }
            
        case ACEDrawingToolTypeRectagleFill:
        {
            ACEDrawingRectangleTool *tool = ACE_AUTORELEASE([ACEDrawingRectangleTool new]);
            tool.fill = YES;
            return tool;
        }
            
        case ACEDrawingToolTypeEllipseStroke:
        {
            ACEDrawingEllipseTool *tool = ACE_AUTORELEASE([ACEDrawingEllipseTool new]);
            tool.fill = NO;
            return tool;
        }
            
        case ACEDrawingToolTypeEllipseFill:
        {
            ACEDrawingEllipseTool *tool = ACE_AUTORELEASE([ACEDrawingEllipseTool new]);
            tool.fill = YES;
            return tool;
        }
            
        case ACEDrawingToolTypeEraser:
        {
            return ACE_AUTORELEASE([ACEDrawingEraserTool new]);
        }
    }
}


#pragma mark - Touch Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // init the bezier path
    self.currentTool = [self toolWithCurrentSettings];
    self.currentTool.lineWidth = self.lineWidth;
    self.currentTool.lineColor = self.lineColor;
    self.currentTool.lineAlpha = self.lineAlpha;
    [self.pathArray addObject:self.currentTool];
    
    // add the first touch
    UITouch *touch = [touches anyObject];
    
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    [self.currentTool setInitialPoint:currentPoint];
    
    // call the delegate
    if ([self.delegate respondsToSelector:@selector(drawingView:willBeginDrawUsingTool:)]) {
        [self.delegate drawingView:self willBeginDrawUsingTool:self.currentTool];
    }
    //CGPoint touchLocation = [touch locationInView:self];
    lastTapPoint_ = currentPoint;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // save all the touches in the path
    UITouch *touch = [touches anyObject];
    
    previousPoint2 = previousPoint1;
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    if ([self.currentTool isKindOfClass:[ACEDrawingPenTool class]]) {
        CGRect bounds = [(ACEDrawingPenTool*)self.currentTool addPathPreviousPreviousPoint:previousPoint2 withPreviousPoint:previousPoint1 withCurrentPoint:currentPoint];
        
        CGRect drawBox = bounds;
        drawBox.origin.x -= self.lineWidth * 2.0;
        drawBox.origin.y -= self.lineWidth * 2.0;
        drawBox.size.width += self.lineWidth * 4.0;
        drawBox.size.height += self.lineWidth * 4.0;
        NSLog(@"X:%f && Y:%f",currentPoint.x,currentPoint.y);

        [self setNeedsDisplayInRect:drawBox];
    }
    else {
        [self.currentTool moveFromPoint:previousPoint1 toPoint:currentPoint];
        [self setNeedsDisplay];
    }
    
    //CGPoint touchLocation = [touch locationInView:self];
	
	[self processPoint:currentPoint];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // make sure a point is recorded
    [self touchesMoved:touches withEvent:event];
    
    // update the image
    [self updateCacheImage:NO];
    
    // clear the redo queue
    [self.bufferArray removeAllObjects];
    
    // call the delegate
    if ([self.delegate respondsToSelector:@selector(drawingView:didEndDrawUsingTool:)]) {
        [self.delegate drawingView:self didEndDrawUsingTool:self.currentTool];
    }
    
    // clear the current tool
    self.currentTool = nil;
    [self.handwritingCoords addObject:NSStringFromCGPoint(CGPointZero)];

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // make sure a point is recorded
    [self touchesEnded:touches withEvent:event];
    [self.handwritingCoords addObject:NSStringFromCGPoint(CGPointZero)];

}

-(void)processPoint:(CGPoint)touchLocation {
	
	// Only keep the point if it's > 5 points from the last
    SignaturePoint *sp = [SignaturePoint newPointWithlx:touchLocation.x ly:touchLocation.y mx:lastTapPoint_.x my:lastTapPoint_.y];
    [self.signPoints addObject:sp];
    
    //NSLog(@"%f - %f - %f - %f", touchLocation.x, touchLocation.y, lastTapPoint_.x, lastTapPoint_.y);
	if (CGPointEqualToPoint(CGPointZero, lastTapPoint_) ||
		fabs(touchLocation.x - lastTapPoint_.x) > 2.0f ||
		fabs(touchLocation.y - lastTapPoint_.y) > 2.0f) {
		
		[self.handwritingCoords addObject:NSStringFromCGPoint(touchLocation)];
		[self setNeedsDisplay];
        
		lastTapPoint_ = touchLocation;
        
	}
    
}

//-(NSMutableArray*) transformPoints:(NSMutableArray*)inPoints{
//    NSMutableArray* outArray=[NSMutableArray new];
//    for (SignaturePoint* sigPoint in inPoints) {
//        [sigPoint calcByDrawingConstant:kDrawingFactor];
//        [outArray addObject:sigPoint];
//    }
//    return outArray;
//}

- (NSMutableArray *)getSignatureArray{
//    self.signPoints=[self transformPoints:self.signPoints];
    return self.signPoints;
}


#pragma mark - Load Image

- (void)loadImage:(UIImage *)image
{
    self.image = image;
    
    //save the loaded image to persist after an undo step
    self.prev_image = [image copy];
    
    // when loading an external image, I'm cleaning all the paths and the undo buffer
    [self.bufferArray removeAllObjects];
    [self.pathArray removeAllObjects];
    [self updateCacheImage:NO];
    [self setNeedsDisplay];
}

- (void)loadImageData:(NSData *)imageData
{
    CGFloat imageScale;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        imageScale = [[UIScreen mainScreen] scale];
        
    } else {
        imageScale = 1.0;
    }
    
    UIImage *image = [UIImage imageWithData:imageData scale:imageScale];
    [self loadImage:image];
}


#pragma mark - Actions

- (void)clear
{
    [self.bufferArray removeAllObjects];
    [self.pathArray removeAllObjects];
    [self.signPoints removeAllObjects];
    self.prev_image = nil;
    [self updateCacheImage:YES];
    [self setNeedsDisplay];
}


#pragma mark - Undo / Redo

- (NSUInteger)undoSteps
{
    return self.bufferArray.count;
}

- (BOOL)canUndo
{
    return self.pathArray.count > 0;
}

- (void)undoLatestStep
{
    if ([self canUndo]) {
        id<ACEDrawingTool>tool = [self.pathArray lastObject];
        [self.bufferArray addObject:tool];
        [self.pathArray removeLastObject];
        [self updateCacheImage:YES];
        [self setNeedsDisplay];
    }
}

- (BOOL)canRedo
{
    return self.bufferArray.count > 0;
}

- (void)redoLatestStep
{
    if ([self canRedo]) {
        id<ACEDrawingTool>tool = [self.bufferArray lastObject];
        [self.pathArray addObject:tool];
        [self.bufferArray removeLastObject];
        [self updateCacheImage:YES];
        [self setNeedsDisplay];
    }
}

#if !ACE_HAS_ARC

- (void)dealloc
{
    self.pathArray = nil;
    self.bufferArray = nil;
    self.currentTool = nil;
    self.image = nil;
    self.prev_image = nil;
    [super dealloc];
}

#endif

@end
