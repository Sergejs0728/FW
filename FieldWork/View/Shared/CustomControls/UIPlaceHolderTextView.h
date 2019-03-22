//
//  UIPlaceHolderTextView.h
//  FieldWork
//
//  Created by Samir Khatri on 03/12/13.
//
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView <UITextViewDelegate>
{
    id<UITextViewDelegate> _secondDelegate;
}

@property (nonatomic, retain, readwrite) id<UITextViewDelegate> secondDelegate;

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;
@property (nonatomic, assign) int characterLength;

-(void)textChanged:(NSNotification*)notification;

@end
