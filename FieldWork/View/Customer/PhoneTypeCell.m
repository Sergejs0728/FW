//
//  PhoneTypeCell.m
//  FieldWork
//
//  Created by Samir Khatri on 3/14/14.
//
//

#import "PhoneTypeCell.h"
#import "AppDelegate.h"
@implementation PhoneTypeCell

static NSMutableArray *phoneTypes;

@synthesize btnAdd = _btnAdd;
@synthesize btnRemove = _btnRemove;
@synthesize btnSelectType = _btnSelectType;
@synthesize txtPhone = _txtPhone;
@synthesize txtType = _txtType;
@synthesize txtExt = _txtExt;
@synthesize delegate=_delegate;

- (void)awakeFromNib {
    if (phoneTypes == nil) {
        phoneTypes = [[NSMutableArray alloc] init];
        [phoneTypes addObject:@"Home"];
        [phoneTypes addObject:@"Office"];
        [phoneTypes addObject:@"Mobile"];
        [phoneTypes addObject:@"Fax"];
        [phoneTypes addObject:@"Other"];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setData:(PhoneInfo *)info {
    _phoneInfo = info;
    self.txtPhone.text = info.phone;
    self.txtType.text = info.phone_kind;
    self.txtExt.text = info.phone_ext;
}

- (void)btnTypeClicked:(id)sender {
    
    if (_actionHandler) {
        _actionHandler();
    }
    
//   SamcomActionSheet *action = [[SamcomActionSheet alloc]initUIPickerWithTitle:@"Phone Type" delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" pickerView:_picker inView:self];
//    
//    [action show];
    
}

- (void)showPickerInView:(UIView*)view {
    [[AppDelegate appDelegate].window endEditing:YES];
    _picker = [[UIPickerView alloc] init];
    _picker.showsSelectionIndicator=YES;
    _picker.dataSource = self;
    _picker.delegate = self;
    SamcomActionSheet_iPad * action = [SamcomActionSheet_iPad initIPadUIPickerWithTitle:@"Phone Type" delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" pickerView:_picker inView:view];
    action.isViewOpen= YES;
    [action show];
}

#pragma mark- PickerView Delegate


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return phoneTypes.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *type = [phoneTypes objectAtIndex:row];
    return type;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


#pragma mark - SamcomActionSheetDelegate

- (void)actionSheetDoneClickedWithActionSheet:(SamcomActionSheet_iPad *)actionSheet {
    int idx = (int)[actionSheet.pickerView selectedRowInComponent:0];
    _txtType.text = [phoneTypes objectAtIndex:idx];
    _phoneInfo.phone_kind = [phoneTypes objectAtIndex:idx];
}


- (void)actionSheetCancelClickedWithActionSheet:(SamcomActionSheet_iPad *)actionSheet {
}
    

@end
