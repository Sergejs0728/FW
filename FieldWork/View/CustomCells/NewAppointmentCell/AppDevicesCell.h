//
//  AppDevicesCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
@protocol AppDeveiceDelegate <NSObject>
-(void)scanForDevice;
-(void)viewAllDevices;
@end

@interface AppDevicesCell : UITableViewCell
{
    __weak IBOutlet UILabel *_lblTotal;
    __weak IBOutlet UILabel *_lblScanned;
    __weak IBOutlet UILabel *_lblUnscanned;
}

@property(nonatomic,strong)id<AppDeveiceDelegate>delegate;

-(IBAction)btnScanDevice:(id)sender;

-(IBAction)btnViewAllDevice:(id)sender;

- (void)setDevicesForAppointmet:(Appointment *)app serviceLocation:(ServiceLocation*)ser_loc;

@end
