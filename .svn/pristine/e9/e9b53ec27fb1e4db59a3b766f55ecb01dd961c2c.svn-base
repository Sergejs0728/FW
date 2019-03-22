//
//  FlowView.h
//  Directory_iOS
//
//  Created by Avantar Developer on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Automatcially spaces all of its children views vertically so there is no overlap
 then adjusts its own height to contain its children
 */
@interface FlowView : UIView
{
    CGFloat _padding;
    
    NSArray *_viewOrder;
}

/// the amount of spacing between children views
@property (nonatomic, readwrite, assign) CGFloat padding;

/// removes overlap of views vertically
-(void)spreadSubviews;
-(void)rebuildLayoutOrder;

@end
