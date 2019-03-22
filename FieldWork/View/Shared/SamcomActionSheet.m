//
//  SamcomActionSheet.m
//  Test
//
//  Created by Samir Khatri on 3/29/14.
//  Copyright (c) 2014 Samir Khatri. All rights reserved.
//

#import "SamcomActionSheet.h"

@interface SamcomActionSheet()

- (void) actionSheetDoneCkicked;
- (void) actionSheetCancelClicked;

@end

@implementation SamcomActionSheet

@synthesize pickerView = _pickerView;
@synthesize datePicker=_datePicker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initUIPickerWithTitle:(NSString *)title delegate:(id<SamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle pickerView:(UIPickerView *)picker inView:(UIView *)view{
    
    
    _delegate = delegate;
    _pickerView = picker;
    _view = view;
    
    self = [super initWithTitle:@"" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil,nil];
    
    self.actionSheetStyle = UIActionSheetStyleDefault;
    
    picker.frame = CGRectMake(10,45,300,216);

    [self addSubview:picker];
    
    UIToolbar *tools=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,320,45)];
    tools.barStyle=UIBarStyleDefault;
    tools.backgroundColor = [UIColor lightGrayColor];//
    [self addSubview:tools];
    
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:doneButtonTitle style:UIBarButtonItemStyleBordered target:self action:@selector(actionSheetDoneCkicked)];
    doneButton.imageInsets=UIEdgeInsetsMake(200, 6, 50, 25);
    UIBarButtonItem *CancelButton=[[UIBarButtonItem alloc]initWithTitle:cancelButtonTitle style:UIBarButtonItemStyleBordered target:self action:@selector(actionSheetCancelClicked)];
    
    UIBarButtonItem *flexSpace= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *array = [[NSArray alloc]initWithObjects:CancelButton,flexSpace,flexSpace,doneButton,nil];
    
    [tools setItems:array];
    
    //picker title
    UILabel *lblPickerTitle=[[UILabel alloc]initWithFrame:CGRectMake(60,8, 200, 25)];
    lblPickerTitle.text=title;
    lblPickerTitle.backgroundColor=[UIColor clearColor];
    lblPickerTitle.textColor=[UIColor blackColor];
    lblPickerTitle.textAlignment=NSTextAlignmentCenter;
    lblPickerTitle.font=[UIFont boldSystemFontOfSize:15];
    [tools addSubview:lblPickerTitle];
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
}



- (id)initDatePickerWithTitle:(NSString *)title delegate:(id<SamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle pickerView:(UIDatePicker *)picker inView:(UIView *)view{
    
    return [self initDatePickerWithTitle:title delegate:delegate doneButtonTitle:doneButtonTitle cancelButtonTitle:cancelButtonTitle pickerView:picker inView:view withCustomDate:[NSDate date]];
    
}

- (id)initDatePickerWithTitle:(NSString *)title delegate:(id<SamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle pickerView:(UIDatePicker *)picker inView:(UIView *)view withCustomDate:(NSDate *)date {
    
    _delegate = delegate;
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 250)];
    _datePicker = picker;
    if (date != nil) {
        _datePicker.date = date;
    }

    _view = view;
    
    self = [super initWithTitle:@"" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil,nil];
    
    self.actionSheetStyle = UIActionSheetStyleDefault;
    
    picker.frame = CGRectMake(10,45,300,216);
    
    [self addSubview:picker];
    
    UIToolbar *tools=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,320,45)];
    tools.barStyle=UIBarStyleDefault;
    tools.backgroundColor = [UIColor lightGrayColor];//
    [self addSubview:tools];
    
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:doneButtonTitle style:UIBarButtonItemStyleBordered target:self action:@selector(actionSheetDoneCkicked)];
    doneButton.imageInsets=UIEdgeInsetsMake(200, 6, 50, 25);
    UIBarButtonItem *CancelButton=[[UIBarButtonItem alloc]initWithTitle:cancelButtonTitle style:UIBarButtonItemStyleBordered target:self action:@selector(actionSheetCancelClicked)];
    
    UIBarButtonItem *flexSpace= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *array = [[NSArray alloc]initWithObjects:CancelButton,flexSpace,flexSpace,doneButton,nil];
    
    [tools setItems:array];
    
    //picker title
    UILabel *lblPickerTitle=[[UILabel alloc]initWithFrame:CGRectMake(60,8, 200, 25)];
    lblPickerTitle.text=title;
    lblPickerTitle.backgroundColor=[UIColor clearColor];
    lblPickerTitle.textColor=[UIColor blackColor];
    lblPickerTitle.textAlignment=NSTextAlignmentCenter;
    lblPickerTitle.font=[UIFont boldSystemFontOfSize:15];
    [tools addSubview:lblPickerTitle];
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
    
}



- (void)show {
    self.pickerView.tag = self.tag;
    [self showFromRect:CGRectMake(0,480, 320,300) inView:_view animated:YES];
    
    [self setBounds:CGRectMake(0,0, 320,500)];
}


- (void)actionSheetDoneCkicked {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetDoneClickedWithActionSheet:)]) {
        [_delegate actionSheetDoneClickedWithActionSheet:self];
    }
}

- (void)actionSheetCancelClicked {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetCancelClickedWithActionSheet:)]) {
        [_delegate actionSheetCancelClickedWithActionSheet:self];
    }
}


@end
