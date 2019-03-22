//
//  UIBarButtonItem+Extension.m
//  FieldWork
//
//  Created by SamirMAC on 12/16/15.
//
//

#import "UIBarButtonItem+Extension.h"

#import <objc/runtime.h>

@implementation UIBarButtonItem (Extension)

static char overviewKey;

@dynamic buttonBlock;

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title andBlock:(GeneralNotificationBlock)block {
    return [UIBarButtonItem barButtonWithTitle:title style:UIBarButtonItemStylePlain andBlock:block];
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style andBlock:(GeneralNotificationBlock)block {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    [item setTitle:title];
    [item setStyle:style];
    [item setTarget:item];
    [item setAction:@selector(performAction:)];
    [item setButtonBlock:block];
    return item;
}


- (void)setButtonBlock:(GeneralNotificationBlock)buttonBlock {
    objc_setAssociatedObject (self, &overviewKey,buttonBlock,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GeneralNotificationBlock)buttonBlock {
    return objc_getAssociatedObject(self, &overviewKey);
}


- (void)performAction:(id)sender {
    void(^block)();
    block = [self buttonBlock];
    block();
}

- (void)setTextColor:(UIColor *)color {
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
}


@end
