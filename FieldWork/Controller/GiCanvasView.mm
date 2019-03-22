//  GiCanvasView.mm
//
//  Created by Zhang Yungui on 14-10-11.
//  Copyright (c) 2014 https://github.com/rhcad
//

#import "GiCanvasView.h"
#import "WDPalette.h"
#import "WDToolView.h"
#import "WDToolButton.h"
#import "GiViewHelper.h"



NSString *WDActiveToolDidChange = @"WDActiveToolDidChange";
NSString *WDCanvasBeganTrackingTouches = @"WDCanvasBeganTrackingTouches";

@interface GiCanvasView () {
//    __weak IBOutlet UIView* paletteView;
    UIPopoverController        *popoverController_;
    GILineStyle currentStyle;
    NSArray * arr;
}
@end

@implementation GiCanvasView

@synthesize paintView, helper;
@synthesize flags, command;
//@synthesize tools = tools_;
@synthesize activeTool;

- (NSInteger)flags { return self.helper.view.flags; }
- (void)setFlags:(NSInteger)f { self.helper.view.flags = f;}
- (NSString *)command {
    return self.helper.command; }
-(void) undo{
    [self.helper undo];
};
-(void) redo{
    [self.helper redo];
};
- (void)setCommand:(NSString *)c { self.helper.command = c;
//    [self.helper addObserver:self forKeyPath:@"myName" options:NSKeyValueChangeOldKey context:nil];
}

- (void)setPath:(NSString*) filePath{
    _path=filePath;
    currentStyle=GILineStyleSolid;
    [self.helper addDelegate:self];
    [self addObserver:self forKeyPath:@"self.helper.selectedCount" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld  context:nil];
    arr = @[@"solid", @"dash", @"dot", @"dashdot", @"dashdotdot", @"null"];
    [self.helper loadFromFile:  filePath];
    [self.helper setZoomEnabled:YES];
    [self.helper startUndoRecord:filePath];
    [self.helper setLineAlpha:1];
}

-(void)onSelectionChanged:(id)view{
    if (_selectionChanged) {
        _selectionChanged();
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"self.helper.selectedCount"]) {
           NSLog(@"%@", change);
       }
}

-(void)changeStyle{
    int i=currentStyle;
    i++;
    currentStyle=(GILineStyle)i;
    if(currentStyle==GILineStyleNull){
        currentStyle=(GILineStyle)0;
    }
//    NSString* styleStr=[arr objectAtIndex:currentStyle];
    
    [self.helper setLineStyle:(GILineStyle)currentStyle];
}

- (GiViewHelper *)helper {
    if (!self.paintView) {
        self.paintView = [[GiPaintViewXIB alloc]initWithFrame:self.bounds];
        self.paintView.autoresizingMask = 0xFF;
        [self addSubview:self.paintView];
        [self.paintView addDelegate:self];
    }
    return self.paintView.helper;
}

- (UIViewController *)viewController {
   
    if ([self.nextResponder isKindOfClass:[UIViewController class]])
        return (UIViewController *)self.nextResponder;
    if ([self.superview.nextResponder isKindOfClass:[UIViewController class]])
        return (UIViewController *)self.superview.nextResponder;
    return nil;
}

-(void)saveToFile:(NSString *) filepath{
    [self.helper saveToFile:filepath];
}

-(void)saveToFile{
    [self.helper saveToFile:_path];
    [self.helper exportPNG:_path];
}

- (void)setActiveTool:(NSDictionary *)tool {
    self.helper.command = [tool objectForKey:@"name"];
}

- (void)setActiveTool:(NSDictionary *)tool from:(id)sender {
    [self.helper setLineStyle:GILineStyleSolid];
    NSString *cmd = [tool objectForKey:@"name"];
    if ([cmd isEqualToString:@"*settings"]) {
//        [self showSettingsMenu:sender];
    } else {
        self.helper.command = cmd;
    }
}

- (void)onCommandChanged:(id)view {
    NSDictionary *tool = self.activeTool;
    if (tool) {
        NSDictionary *userInfo = @{@"tool": tool};
        [[NSNotificationCenter defaultCenter] postNotification:
         [NSNotification notificationWithName:WDActiveToolDidChange
                                       object:self userInfo:userInfo]];
    }
}

#pragma mark -
#pragma mark popoverController

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (popoverController == popoverController_) {
        popoverController_ = nil;
    }
}

- (void) hidePopovers
{
    if (popoverController_) {
        [popoverController_ dismissPopoverAnimated:NO];
        popoverController_ = nil;
        //visibleMenu_ = nil;
    }
}

- (UIPopoverController *) runPopoverWithController:(UIViewController *)controller from:(id)sender
{
    [self hidePopovers];
    
    popoverController_ = [[UIPopoverController alloc] initWithContentViewController:controller];
	popoverController_.delegate = self;
    
    UIView *button = sender;
    CGRect rect = [button.superview convertRect:button.frame toView:self];
    [popoverController_ presentPopoverFromRect:rect inView:self
                      permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    return popoverController_;
}

#pragma mark -
#pragma mark Settings

- (BOOL) shouldDismissPopoverForClassController:(Class)controllerClass insideNavController:(BOOL)insideNav
{
    if (!popoverController_) {
        return NO;
    }
    
    if (insideNav && [popoverController_.contentViewController isKindOfClass:[UINavigationController class]]) {
        NSArray *viewControllers = [(UINavigationController *)popoverController_.contentViewController viewControllers];
        
        for (UIViewController *viewController in viewControllers) {
            if ([viewController isKindOfClass:controllerClass]) {
                return YES;
            }
        }
    } else if ([popoverController_.contentViewController isKindOfClass:controllerClass]) {
        return YES;
    }
    
    return NO;
}

-(void) setZoomable:(BOOL) isZoomed{
    [self.helper setZoomEnabled:isZoomed];
}


@end
