//
//  UIBarButtonItem+Extension.h
//  FieldWork
//
//  Created by SamirMAC on 12/16/15.
//
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

@property (nonatomic, copy) GeneralNotificationBlock buttonBlock;

+ (UIBarButtonItem*) barButtonWithTitle:(NSString *)title andBlock:(GeneralNotificationBlock)block;

+ (UIBarButtonItem*) barButtonWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style andBlock:(GeneralNotificationBlock)block;

- (void)performAction:(id)sender;

- (void) setTextColor:(UIColor*)color;

@end
