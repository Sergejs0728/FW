//
//  SignatureController.h
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "Appointment.h"
#import "CaptureSignatureController.h"
#import "DrawSignature.h"
#import <QuartzCore/QuartzCore.h>
#import "SignaturePoint.h"

@interface SignatureController : CommonAppointmentViewController
{
    IBOutlet UIView *_customerSignature;
    IBOutlet UIView *_technocianSignature;
    IBOutlet UILabel *lblTitleLable1;
    IBOutlet UILabel *lblTitleLable2;
    IBOutlet UIView *titleView;
    
    BOOL _isCustomerSignatureChanged;
    BOOL _isTechnicianSignatureChanged;
}

+ (SignatureController*) viewControllerWithAppointment:(Appointment*) app;

- (IBAction)customerSignatureCapture:(id)sender;
-(IBAction)technicianSignatureCapture:(id)sender;

@end
