#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ARCMacro.h"
#import "GiCanvasAdapter.h"
#import "GiPaintView.h"
#import "GiPaintViewDelegate.h"
#import "GiPaintViewXIB.h"
#import "GiShapeAdapter.h"
#import "GiViewEnums.h"
#import "GiViewHelper+Layer.h"
#import "GiViewHelper.h"
#import "NSString+Drawing.h"

FOUNDATION_EXPORT double TouchVGVersionNumber;
FOUNDATION_EXPORT const unsigned char TouchVGVersionString[];

