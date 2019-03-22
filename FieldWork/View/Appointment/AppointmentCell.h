//
//  AppointmentCell.h
//  FieldWork
//
//  Created by Samir Kha on 24/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Appointment+Helper.h"
#import "Customer.h"
#import "Statuses.h"
#import "Estimate.h"

@interface AppointmentCell : UITableViewCell
{
//    IBOutlet UILabel *_appTitle;
//    IBOutlet UILabel *_appSubTitle;
//    IBOutlet UILabel *_firstServiceLocation;
//    IBOutlet UILabel *_appStatus;
//    IBOutlet UILabel *_appTime;
//    IBOutlet UIView *_statusView;
//    IBOutlet UILabel *lblDuration;
//    IBOutlet UILabel *colorLabel;
    
//    IBOutlet UIImageView *_imgIsConfirmed;
    IBOutlet UILabel * _lblTitle;
    IBOutlet UILabel * _lblSubTitle;
    IBOutlet UILabel * _lblFirstServiceLocation;
    IBOutlet UILabel * _lblTimeDuration;
    IBOutlet UILabel * _lblTimeArrive;
    IBOutlet UILabel *_lblstatus;
    __weak IBOutlet UILabel *lblArrive;
    __weak IBOutlet UILabel *lblDuration;
    IBOutlet UIImageView * checkMarkImage;
    __weak IBOutlet UILabel *_lblSyncError;
}

@property (nonatomic, copy) void(^lblSyncErrorAction)(NSInteger tag);
@property (nonatomic, strong) Statuses* statusModel;
@property (nonatomic, strong) Appointment* appointment;
@property (nonatomic, strong) Estimate* estimate;
@property (nonatomic) BOOL hideCustomerInfo;

- (void) setAppointment:(Appointment*) app;
//- (void) setCustomer:(Customer*) customer;
- (void) setAppointmentWorkPool:(Appointment*) app;
//@property (nonatomic, strong) ItemLoadedBlock itemLoadedBlock;
- (void) showSyncError:(BOOL)show;
@end
