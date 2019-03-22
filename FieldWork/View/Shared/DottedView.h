//
//  DottedView.h
//  FieldWork
//
//  Created by SamirMAC on 12/16/15.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface DottedView : UIView
{
    __weak IBOutlet UIButton *_btnTouch;
}

@property (nonatomic, assign) BOOL showDottedBorderAndButton;

@property (nonatomic, assign) BOOL hideButton;

- (void) configureDottedView;

- (void) addButtonClickBlock:(GeneralNotificationBlock)block;

@end
