//
//  KeyboardAccessoryHelper.m
//  TREKhunters
//
//  Created by Samir Kha on 25/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KeyboardAccessoryHelper.h"

@implementation KeyboardAccessoryHelper

@synthesize keyboardToolbar;

+ (KeyboardAccessoryHelper*) getInstance{
    return [[KeyboardAccessoryHelper alloc] init];
}

- (void)createInputAccessoryFor:(UITextField *)txtField inView:(UIView *)rootView andDelegate:(id)del{
    
    self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, rootView.bounds.size.width, 44)];
    self.keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
    self.keyboardToolbar.tintColor = [UIColor darkGrayColor];
    
    
    UIBarButtonItem* flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:del action:@selector(hideKeyboard)];
    
    [keyboardToolbar setItems:[NSArray arrayWithObjects: flexSpace, doneButton, nil] animated:NO];
    if(txtField != nil){
        [txtField setInputAccessoryView:self.keyboardToolbar];           
    }
}

-(void)hideKeyboard{
    
}


@end
