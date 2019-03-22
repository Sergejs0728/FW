//
//  KeyboardAccessoryHelper.h
//  TREKhunters
//
//  Created by Samir Kha on 25/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KeyBoardHelper <NSObject>

-(void)hideKeyboard;

@end

@interface KeyboardAccessoryHelper : NSObject <KeyBoardHelper>{
    UIToolbar *keyboardToolbar;
}

@property (nonatomic, retain) UIToolbar *keyboardToolbar;


- (void)createInputAccessoryFor:(UITextField *)txtField inView:(UIView *)rootView andDelegate:(id)del;

+ (KeyboardAccessoryHelper*) getInstance; 


@end
