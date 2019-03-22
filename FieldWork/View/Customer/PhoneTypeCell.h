//
//  PhoneTypeCell.h
//  FieldWork
//
//  Created by Samir Khatri on 3/14/14.
//
//

#import <UIKit/UIKit.h>
#import "FieldworkTextField.h"
#import "FWBottomLineTextField.h"
#import "SamcomActionSheet.h"
#import "PhoneInfo.h"
#import "SamcomActionSheet_iPad.h"
@class AppDelegate;

@interface PhoneTypeCell : UITableViewCell <UIPickerViewDataSource,UIPickerViewDelegate, SamcomActionSheetDelegate,iPadSamcomActionSheetDelegate>
{
    IBOutlet FWBottomLineTextField *_txtPhone;
    IBOutlet FWBottomLineTextField *_txtType;
    IBOutlet FWBottomLineTextField *_txtExt;
    IBOutlet UIButton *_btnSelectType;
    IBOutlet UIButton *_btnAdd;
    IBOutlet UIButton *_btnRemove;
    UIPickerView *_picker;
    
    PhoneInfo *_phoneInfo;
    id _delegate;
}

@property (nonatomic, retain, readwrite) FWBottomLineTextField *txtPhone;
@property (nonatomic, retain, readwrite) FWBottomLineTextField *txtType;
@property (nonatomic, retain, readwrite) FWBottomLineTextField *txtExt;
@property (nonatomic, retain, readwrite) UIButton *btnSelectType;
@property (nonatomic, retain, readwrite) UIButton *btnAdd;
@property (nonatomic, retain, readwrite) UIButton *btnRemove;
@property (nonatomic ,retain) id delegate;
@property (nonatomic, copy) void (^actionHandler)();

- (void) setData:(PhoneInfo*)info;

- (IBAction)btnTypeClicked:(id)sender;
- (void)showPickerInView:(UIView*)view;

@end
