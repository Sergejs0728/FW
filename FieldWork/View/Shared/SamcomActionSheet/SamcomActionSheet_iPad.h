//
//  SamcomActionSheet_iPad.h
//  SamcomActionSheet_iPad
//
//  Created by Samir Khatri on 8/8/14.
//  Copyright (c) 2014 Samir Khatri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class SamcomActionSheet_iPad;

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@protocol iPadSamcomActionSheetDelegate <NSObject>

- (void)actionSheetDoneClickedWithActionSheet:(SamcomActionSheet_iPad *)actionSheet;
- (void)actionSheetCancelClickedWithActionSheet:(SamcomActionSheet_iPad *)actionSheet;


@end

@interface SamcomActionSheet_iPad : UIView<UIPickerViewDelegate,UIPickerViewDataSource>{
    IBOutlet UIPickerView * _pickerView;
    id<iPadSamcomActionSheetDelegate> _delegate;
    UIView *_view;
    int tag;
    IBOutlet UILabel * _lblTitle;
    IBOutlet UIBarButtonItem * _doneBarButton;
    IBOutlet UIBarButtonItem * _cancelBarButton;
    BOOL _isViewOpen;
    IBOutlet UIDatePicker * _datePicker;
    BOOL isFromDatePicker;
    

    float hideYPOS;
    float showYPOS;
    float pickerViewWidth;

}
@property (nonatomic ,assign) float pickerViewWidth;
@property (nonatomic ,assign) float hideYPOS;
@property (nonatomic ,assign) float showYPOS;
@property (nonatomic, retain) UIPickerView *pickerView;
//@property (nonatomic, assign) int tag;
@property (nonatomic ,retain) UILabel * lblTitle;
@property (nonatomic ,retain) UIView * view;
@property (nonatomic ,retain) id<iPadSamcomActionSheetDelegate> delegate;
@property (nonatomic ,retain) UIBarButtonItem * doneBarButton;
@property (nonatomic ,retain) UIBarButtonItem * cancelBarButton;
@property (nonatomic ,retain) UIDatePicker * datePicker;
@property (nonatomic ,assign) BOOL isViewOpen;
@property (nonatomic ,assign) BOOL isFromDatePicker;
+ (id)initIPadUIPickerWithTitle:(NSString *)title delegate:(id<iPadSamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle pickerView:(UIPickerView *)picker inView:(UIView *)view;

+ (id)initIPadUIDatePickerWithTitle:(NSString *)title delegate:(id<iPadSamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle DatepickerView:(UIDatePicker *)picker inView:(UIView *)view withCustomDate:(NSDate *)date;

- (IBAction)doneClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;

//- (IBAction)datePickerSelected:(id)sender;

- (void)show;
- (void)showDatePicker;

@end
