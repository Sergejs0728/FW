//  GiCanvasView.h
//
//  Created by Zhang Yungui on 14-10-11.
//  Copyright (c) 2014 https://github.com/rhcad
//

#import "GiPaintViewXIB.h"
#import "WDPalette.h"


typedef void (^simpleBlock)(void);

@interface GiCanvasView : UIView<GiPaintViewDelegate, UIPopoverControllerDelegate>

@property(nonatomic, strong)    GiPaintViewXIB  *paintView;
@property(nonatomic, readonly)  GiViewHelper    *helper;
@property(nonatomic, assign)    NSInteger       flags;      // GIViewFlags
@property(nonatomic, assign)    NSString        *command;
@property(strong, nonatomic) NSString* path;
@property (strong,nonatomic)     WDPalette  *toolPalette_;
//@property(nonatomic, strong)    NSArray         *tools;
@property(nonatomic, weak)      NSDictionary    *activeTool;
@property (nonatomic,strong) simpleBlock block;
@property (nonatomic,strong) simpleBlock selectionChanged;

- (void)setActiveTool:(NSDictionary *)tool from:(id)sender;
- (void)saveToFile:(NSString *) filepath;
-(void)saveToFile;
-(void) setZoomable:(BOOL) isZoomed;
-(void) undo;
-(void) redo;
-(void)setPath:(NSString*) filePath;
-(void)changeStyle;
@end

// notifications
extern NSString *WDActiveToolDidChange;
extern NSString *WDCanvasBeganTrackingTouches;
