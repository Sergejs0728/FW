//
//  SamcomActionSheet.h
//  Test
//
//  Created by Samir Khatri on 3/29/14.
//  Copyright (c) 2014 Samir Khatri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SamcomActionSheet;

@protocol SamcomActionSheetDelegate <NSObject>

- (void) actionSheetDoneClickedWithActionSheet:(SamcomActionSheet*) actionSheet;

- (void) actionSheetCancelClickedWithActionSheet:(SamcomActionSheet*) actionSheet;

@end

@interface SamcomActionSheet : UIActionSheet <UIActionSheetDelegate>
{
    UIPickerView * _pickerView;
    UIDatePicker * _datePicker;
    id<SamcomActionSheetDelegate> _delegate;
    UIView *_view;
    //NSString *tag;
}

@property (nonatomic, retain, readonly) UIPickerView *pickerView;
@property (nonatomic, retain, readonly) UIDatePicker *datePicker;


- (id) initUIPickerWithTitle:(NSString*)title delegate:(id<SamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString*) doneButtonTitle cancelButtonTitle:(NSString*)cancelButtonTitle pickerView:(UIPickerView*) picker inView:(UIView*)view;

- (id) initDatePickerWithTitle:(NSString*)title delegate:(id<SamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString*) doneButtonTitle cancelButtonTitle:(NSString*)cancelButtonTitle pickerView:(UIDatePicker*) picker inView:(UIView*)view;

- (id)initDatePickerWithTitle:(NSString *)title delegate:(id<SamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle pickerView:(UIDatePicker *)picker inView:(UIView *)view withCustomDate:(NSDate*) date;


- (void) show;

@end
