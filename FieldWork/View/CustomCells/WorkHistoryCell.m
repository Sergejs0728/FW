//
//  WorkHistoryCell.m
//  FieldWork
//
//  Created by Mac4 on 13/10/14.
//
//

#import "WorkHistoryCell.h"

@implementation WorkHistoryCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(Appointment *)app {
    NSString *format = @"%@ - WO # %@";
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *datestring = [dateFormatter stringFromDate:app.starts_at];
    NSString *dt = [NSString stringWithFormat:format, datestring, app.report_number];
    _lblDateWoNumber.text = dt;
    _lblNotes.text = app.notes;
}

@end
