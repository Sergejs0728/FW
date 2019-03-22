//
//  AppTimeCell.m
//  FieldWork
//
//  Created by SamirMAC on 1/5/16.
//
//

#import "AppTimeCell.h"

@implementation AppTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setAppointmentData:(Appointment*)app andButtonClickBlock:(TimeButtonClicked)block
{
    _appointment = app;
    _timeClickedBlock = block;
    
    self.lblStartTime.text = [Utils getNonmilitaryTime:_appointment.started_at_time];
    self.lblEndTime.text = [Utils getNonmilitaryTime:_appointment.finished_at_time];
}

- (void)btnStartTime:(id)sender {
    if (_timeClickedBlock) {
        _timeClickedBlock(YES);
    }
}

- (void)btnEndTime:(id)sender {
    if (_timeClickedBlock) {
        _timeClickedBlock(NO);
    }
}

@end
