    //
    //  SamcomActionSheet_iPad.m
    //  SamcomActionSheet_iPad
    //
    //  Created by Samir Khatri on 8/8/14.
    //  Copyright (c) 2014 Samir Khatri. All rights reserved.
    //

#import "SamcomActionSheet_iPad.h"

@implementation SamcomActionSheet_iPad
@synthesize lblTitle=_lblTitle;
@synthesize doneBarButton=_doneBarButton;
@synthesize cancelBarButton=_cancelBarButton;
@synthesize isViewOpen=_isViewOpen;
//@synthesize tag;
@synthesize view=_view;
@synthesize delegate=_delegate;
@synthesize isFromDatePicker;
@synthesize showYPOS;
@synthesize hideYPOS;
@synthesize pickerViewWidth;
    //@synthesize Fadeview;

+ (id)initIPadUIPickerWithTitle:(NSString *)title delegate:(id<iPadSamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle pickerView:(UIPickerView *)picker inView:(UIView *)view;{
    SamcomActionSheet_iPad * actionSheet;
    
    CGSize viewSize = view.bounds.size;
    actionSheet = [[[NSBundle mainBundle] loadNibNamed:@"SamcomActionSheet_iPad" owner:nil options:nil] objectAtIndex:0];
    actionSheet.frame = CGRectMake(0, viewSize.height,viewSize.width,actionSheet.frame.size.height);
    actionSheet.hideYPOS = viewSize.height;
    actionSheet.showYPOS = viewSize.height - actionSheet.frame.size.height;
    actionSheet.pickerViewWidth = viewSize.width;
   
    actionSheet.view = view;
    
    actionSheet.isFromDatePicker = NO;
    actionSheet.delegate = delegate;
    actionSheet.pickerView = picker;
    
    
    actionSheet.lblTitle.text = title;
    
    for (UIView * sView in view.subviews) {
        if ([sView isKindOfClass:[SamcomActionSheet_iPad class]]) {
            [sView removeFromSuperview];
            
        }
    }
    
    [view addSubview:actionSheet];
    
    [actionSheet.doneBarButton setTitle:doneButtonTitle];
    [actionSheet.cancelBarButton setTitle:cancelButtonTitle];
    
    return actionSheet;
}

+ (id)initIPadUIDatePickerWithTitle:(NSString *)title delegate:(id<iPadSamcomActionSheetDelegate>)delegate doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle DatepickerView:(UIDatePicker *)picker inView:(UIView *)view withCustomDate:(NSDate *)date{
    
    SamcomActionSheet_iPad * actionSheet;
    
    CGSize viewSize = view.bounds.size;
    actionSheet = [[[NSBundle mainBundle] loadNibNamed:@"SamcomActionSheetWithDatePicker" owner:nil options:nil] objectAtIndex:0];
    actionSheet.frame = CGRectMake(0, viewSize.height,viewSize.width,actionSheet.frame.size.height);
    actionSheet.hideYPOS = viewSize.height;
    actionSheet.showYPOS = viewSize.height - actionSheet.frame.size.height;
    actionSheet.pickerViewWidth = viewSize.width;
  
    actionSheet.isFromDatePicker = YES;
    
    actionSheet.delegate = delegate;
    actionSheet.datePicker = picker;
    actionSheet.view = view;
    actionSheet.lblTitle.text = title;
    
    for (UIView * sView in view.subviews) {
        if ([sView isKindOfClass:[SamcomActionSheet_iPad class]]) {
            [sView removeFromSuperview];
            
        }
    }
    
    
    if (date != nil) {
        actionSheet.datePicker.date = date;
    }

    
    [view addSubview:actionSheet];
    [actionSheet addSubview:picker];
    
    [actionSheet.doneBarButton setTitle:doneButtonTitle];
    [actionSheet.cancelBarButton setTitle:cancelButtonTitle];
    
    return actionSheet;
}


-(void)show{
    
    if (_isViewOpen) {
        
         self.pickerView.frame = CGRectMake(0,40,pickerViewWidth,216);
        
        [self addSubview:_pickerView];
        
      self.frame = CGRectMake(0,hideYPOS,self.frame.size.width,self.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:nil];
        [UIView setAnimationDuration:0.5];
        
        
        self.frame = CGRectMake(0,showYPOS,self.frame.size.width,self.frame.size.height);
        
    }else{
        

        self.frame = CGRectMake(0,showYPOS,self.frame.size.width,self.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:nil];
        [UIView setAnimationDuration:0.5];
        

        self.frame = CGRectMake(0,hideYPOS,self.frame.size.width,self.frame.size.height);
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
    }
    _isViewOpen = !_isViewOpen;
    
    [UIView commitAnimations];
}

-(void)showDatePicker{
    if (_isViewOpen) {
        
       
        self.datePicker.frame = CGRectMake(0,45,pickerViewWidth,216);
        
        self.frame = CGRectMake(0,hideYPOS,self.frame.size.width,self.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:nil];
        [UIView setAnimationDuration:0.5];
        
        
        if (IPAD) {
            
        }else{
            
        }
        self.frame = CGRectMake(0,showYPOS,self.frame.size.width,self.frame.size.height);
        
    }else{
        
        
        self.frame = CGRectMake(0,showYPOS,self.frame.size.width,self.frame.size.height);
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:nil];
        [UIView setAnimationDuration:0.5];
        
        self.frame = CGRectMake(0,hideYPOS,self.frame.size.width,self.frame.size.height);
        
        
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
    }
    _isViewOpen = !_isViewOpen;
    
    [UIView commitAnimations];
}

-(void)doneClicked:(id)sender{
    
    _isViewOpen = NO;
    
    if (isFromDatePicker) {
        [self showDatePicker];
    }else{
        [self show];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetDoneClickedWithActionSheet:)]) {
        [_delegate actionSheetDoneClickedWithActionSheet:self];
    }
}
-(void)cancelClicked:(id)sender{
    _isViewOpen = NO;
    
    if (isFromDatePicker) {
        [self showDatePicker];
    }else{
        [self show];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetCancelClickedWithActionSheet:)]) {
        [_delegate actionSheetCancelClickedWithActionSheet:self];
    }
}

@end
