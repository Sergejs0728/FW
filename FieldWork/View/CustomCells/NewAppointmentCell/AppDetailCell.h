//
//  AppDetailCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Appointment.h"
#import <MessageUI/MFMailComposeViewController.h>



@interface AppDetailCell : UITableViewCell
{
    Appointment *_appointment;
}

@property(nonatomic,weak)IBOutlet UILabel *lblArrivalWindow;
@property(nonatomic,weak)IBOutlet UILabel *lblStartTime;
@property(nonatomic,weak)IBOutlet UILabel *lblDuration;
@property(nonatomic,weak)IBOutlet UILabel *lblCustomerName;
@property(nonatomic,weak)IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customerNameHieghit;
@property(nonatomic,weak)IBOutlet UILabel *lblArriveTitle;
//@property (weak, nonatomic) IBOutlet UITextView *textFieldPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;

@property (weak, nonatomic) IBOutlet UILabel *labelAddressFieldName;
@property (nonatomic,strong) UIButton *topButton;
@property (nonatomic, strong) UILabel *topLabel;

@property(nonatomic,weak)IBOutlet UILabel *lblStartsAtTime;
@property(nonatomic,weak)IBOutlet UILabel *lblEndsAtTime;
@property (nonatomic, weak) IBOutlet UIButton *btnMore;
@property(nonatomic,weak)IBOutlet UIButton *btnStartAtTime;
@property(nonatomic,weak)IBOutlet UIButton *btnEndsAtTime;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel1;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton1;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel2;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton2;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel3;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton3;
@property (weak, nonatomic) IBOutlet UIView *bottomHorizontalSeparatorView;
@property (weak, nonatomic) IBOutlet UIButton *buttonDrivingDirections;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phone1LayoutConstraintHieght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phone2LayoutConstraintHieght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phone3LayoutConstraintHieght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailLayoutConstraintHieght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintAddressLabelTopToSuperview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintAddressLabelTopToNameLabel;


@property (nonatomic, copy) void(^drivingDirectionAction)(NSInteger tag);
@property (nonatomic, copy) void(^emailAction)(NSString *email);
@property (nonatomic, copy) void(^phoneAction)(NSString *phone);
@property (nonatomic) CGFloat hieght;
@property (nonatomic) BOOL hideCustomerInfo;
- (void) setDataWithAppointment:(Appointment*)app;

- (IBAction)btnDrivingDirection:(UIButton*)sender;
- (IBAction)btnSelectStartTime:(id)sender;
- (IBAction)btnSelectEndTime:(id)sender;

@end
