//
//  PestActivityCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 15.06.17.
//
//

#import "PestActivityCell.h"
#import "ActivityLevel.h"

@interface PestActivityCell () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong,nonatomic) ActivityLevel* level;
@property (strong,nonatomic) UIPickerView* picker;
@property (strong,nonatomic) NSArray *items;

@end


@implementation PestActivityCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.picker.delegate = self;
    self.textFieldLevel.inputView = self.picker;
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    UIBarButtonItem *doneCancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:doneCancel,space,doneBtn, nil]];
    [_textFieldLevel setInputAccessoryView:toolBar];
    _items = [ActivityLevel MR_findAllSortedBy:@"entity_id" ascending:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPestActivity:(PestActivity *)pestActivity {
    _pestActivity = pestActivity;
    Pest *pest = [pestActivity getPest];
    _labelPest.text = pest.name;
    if (pestActivity.activity_level_id) {
        _level = [pestActivity getActivityLevel];
        NSInteger index = [_items indexOfObject:_level];
        if (index >= _items.count) {
            index = 0;
        }
        [_picker selectRow:index inComponent:0 animated:NO];
        _textFieldLevel.text = _level.name;
    }
}

#pragma mark - UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _items.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_items[row] name];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    ActivityLevel *level = _items[row];
//    _textFieldLevel.text = level.name;
}

#pragma mark -
- (void)cancel {
    [self.textFieldLevel resignFirstResponder];
    self.textFieldLevel.text = _level.name;
    if (_doneBlock) {
        _doneBlock(_level.entity_id);
    }
}

- (void)done {
    NSInteger selectedRow = [_picker selectedRowInComponent:0];
    if (_items.count > 0 && selectedRow < _items.count) {
        _level = _items[selectedRow];
        self.textFieldLevel.text = _level.name;
        [self.textFieldLevel resignFirstResponder];
        if (_doneBlock) {
            _doneBlock(_level.entity_id);
        }
    }
}

@end
