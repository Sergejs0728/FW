//
//  AppDevicesCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppDevicesCell.h"
#import "CustomerDevice.h"
#import "InspectionRecord.h"

@implementation AppDevicesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDevicesForAppointmet:(Appointment *)app serviceLocation:(ServiceLocation*)ser_loc {
    NSUInteger total = 0;
    NSUInteger scanned = 0;
    NSUInteger unscanned = 0;
    if (app && ser_loc) {
        total = ser_loc.devices.count;
        NSArray *temp = [ser_loc.devices copy];
        for (CustomerDevice *device in temp) {
            BOOL is_checked = NO;
            for (InspectionRecord *ir in app.inspection_records) {
                if ([ir.barcode isEqual:device.barcode]) {
                    is_checked = YES;
                    break;
                }
            }
            if (is_checked) {
                scanned++;
            } else {
                unscanned++;
            }
        }
    }
    [_lblTotal setText:[NSString stringWithFormat:@"%lu", (unsigned long)total]];
    [_lblScanned setText:[NSString stringWithFormat:@"%lu", (unsigned long)scanned]];
    [_lblUnscanned setText:[NSString stringWithFormat:@"%lu", (unsigned long)unscanned]];
}

-(void)btnScanDevice:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(scanForDevice)]) {
        [_delegate scanForDevice];
    }
}

-(void)btnViewAllDevice:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(viewAllDevices)]) {
        [_delegate viewAllDevices];
    }
}

@end
