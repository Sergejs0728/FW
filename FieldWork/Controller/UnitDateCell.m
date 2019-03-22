//
//  UnitDateCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 23.05.17.
//
//

#import "UnitDateCell.h"
@interface UnitDateCell()
@property (strong,nonatomic)  NSDateFormatter* formatter;
@end
@implementation UnitDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _formatter =[[NSDateFormatter alloc] init];
    _formatter.dateFormat = @" h:mm a";
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.datePicker setDatePickerMode:UIDatePickerModeTime];
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.serviceTime.inputView = self.datePicker;
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    UIBarButtonItem *doneCancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:doneCancel,space,doneBtn, nil]];
    [_serviceTime setInputAccessoryView:toolBar];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    _date=datePicker.date;
    self.serviceTime.text = [_formatter stringFromDate:datePicker.date];
}

-(void)cancel{
    [self.serviceTime resignFirstResponder];
    self.serviceTime.text=@"";
    _date=nil;
}

-(void)done{
    _date=_datePicker.date;
    self.serviceTime.text = [_formatter stringFromDate:_datePicker.date];
    [self.serviceTime resignFirstResponder];
    if(_doneBlock){
        _doneBlock(_date);
    }
}

-(void)setTime:(NSString *)time {
    _date=[_formatter dateFromString:time];
    [_serviceTime setText:time];
}

@end
