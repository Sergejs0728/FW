//
//  SLFlowView.m
//  Directory_iOS
//
//  Created by Avantar Developer on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlowView.h"

NSInteger sortFunction(id a, id b, void* context);

NSInteger sortFunction(id a, id b, void* context)
{
    UIView* viewA = (UIView*)a;
    UIView* viewB = (UIView*)b;
    
    if (viewA.frame.origin.y < viewB.frame.origin.y)
        return NSOrderedAscending;
    else if (viewA.frame.origin.y > viewB.frame.origin.y)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

@implementation FlowView

@synthesize padding = _padding;

-(void)dealloc
{
    [_viewOrder release];
    
    [super dealloc];
}

-(void)rebuildLayoutOrder
{
    [_viewOrder release];
    _viewOrder = [self.subviews sortedArrayUsingFunction:sortFunction context:nil];
    [_viewOrder retain];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _padding = 0;
    }
    return self;
}

-(NSInteger)getOriginY:(NSInteger*) data width:(NSInteger) width frame:(CGRect) frame
{
    NSInteger result = 0;
    for (NSInteger x = frame.origin.x; x <= frame.origin.x + frame.size.width; ++x)
    {
        if (x >= 0 && x < width && data[x] > result)
            result = data[x];
    }
    
    return result + _padding;
}

-(void)updateData:(NSInteger*) data width:(NSInteger) width frame:(CGRect) frame
{
    for (NSInteger x = frame.origin.x; x <= frame.origin.x + frame.size.width; ++x)
    {
        if (x >= 0 && x < width)
            data[x] = frame.origin.y + frame.size.height;
    }
}

-(void)spreadSubviews
{
    if (_viewOrder == nil)
        [self rebuildLayoutOrder];
    
    NSInteger width = self.bounds.size.width;
    
    NSInteger *data = malloc(sizeof(NSInteger) * width);
    memset(data, 0, sizeof(NSInteger) * width);
    
    for (UIView* view in _viewOrder)
    {
        CGRect frameRect = view.frame;
        
        frameRect.origin.y = [self getOriginY:data width:width frame:frameRect];
        
        if (!view.hidden)
            [self updateData:data width:width frame:frameRect];
        
        view.frame = frameRect;
    }
    
    CGRect selfRect = self.frame;
    
    selfRect.size.height = [self getOriginY:data width:width frame:selfRect];
    
    self.frame = selfRect;
    
    free(data);
}

-(void)layoutSubviews
{
    [self spreadSubviews];
    
    [super layoutSubviews];
}

@end
