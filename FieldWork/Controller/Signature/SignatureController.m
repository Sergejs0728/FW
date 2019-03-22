//
//  SignatureController.m
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SignatureController.h"

@implementation SignatureController

+ (SignatureController *)viewControllerWithAppointment:(Appointment *)app {
    SignatureController *controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        controller = [[SignatureController alloc] initWithNibName:@"SignatureController_IPad" bundle:nil];        
    }else{
        controller = [[SignatureController alloc] initWithNibName:@"SignatureController" bundle:nil];
        
    }

    
    controller.Appointment = app;
    return controller;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _customerSignature.layer.cornerRadius=1;
    _customerSignature.layer.masksToBounds=YES;
    
    _technocianSignature.layer.cornerRadius=1;
    _technocianSignature.layer.masksToBounds=YES;
    
    lblTitleLable1.text = [[self.Appointment getCustomer] getDisplayName];
    lblTitleLable2.text = @"Signatures";

    self.title = @"Signatures";

        
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   

    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (self.Appointment.customer_signature.length > 0) {
            DrawSignature *custSig = [[DrawSignature alloc] initWithFrame:CGRectMake(0, 0,738,380)];
            NSMutableArray *arr = [SignaturePoint parseWithArray:self.Appointment.customer_signature];
            if (arr && arr.count > 0) {
                custSig.sigPoints = [SignaturePoint parseWithArray:self.Appointment.customer_signature];
            }
            [_customerSignature addSubview:custSig];
        }
        
        if (self.Appointment.technician_signature.length > 0) {
            DrawSignature *custSig = [[DrawSignature alloc] initWithFrame:CGRectMake(0, 0,738,380)];
            NSMutableArray *arr = [SignaturePoint parseWithArray:self.Appointment.technician_signature];
            if (arr && arr.count > 0) {
                custSig.sigPoints = [SignaturePoint parseWithArray:self.Appointment.technician_signature];
            }
            [_technocianSignature addSubview:custSig];
        }
        
    }else{
        if (self.Appointment.customer_signature.length > 0) {
            DrawSignature *custSig = [[DrawSignature alloc] initWithFrame:CGRectMake(0, 0, 300, 120)];
            
            NSMutableArray *arr = [SignaturePoint parseWithArray:self.Appointment.customer_signature];
            if (arr && arr.count > 0) {
                custSig.sigPoints = [SignaturePoint parseWithArray:self.Appointment.customer_signature];
            }
            [_customerSignature addSubview:custSig];
        }
        
        if (self.Appointment.technician_signature.length > 0) {
            DrawSignature *custSig = [[DrawSignature alloc] initWithFrame:CGRectMake(0, 0, 300, 120)];
            NSMutableArray *arr = [SignaturePoint parseWithArray:self.Appointment.technician_signature];
            if (arr && arr.count > 0) {
                custSig.sigPoints = [SignaturePoint parseWithArray:self.Appointment.technician_signature];
            }
            [_technocianSignature addSubview:custSig];
        }

    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    for (UIView *v in _customerSignature.subviews) {
        if ([v isKindOfClass:[DrawSignature class]])
        {
             [v removeFromSuperview];
        }
    }
    for (UIView *v in _technocianSignature.subviews) 
    {
        if ([v isKindOfClass:[DrawSignature class]])
        {
            [v removeFromSuperview];
        }
    }
}
-(BOOL)shouldAutomaticallyForwardRotationMethods
{
    return NO;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)customerSignatureCapture:(id)sender {
//    CaptureSignatureController *controller = [CaptureSignatureController viewControllerWithAppointment:self.Appointment withCaptureMode:CustomerMode];
//    [self.navigationController pushViewController:controller animated:YES];
//    _isCustomerSignatureChanged = YES;
}

- (void)technicianSignatureCapture:(id)sender {
//    CaptureSignatureController *controller = [CaptureSignatureController viewControllerWithAppointment:self.Appointment withCaptureMode:TechnicianMode];
//    [self.navigationController pushViewController:controller animated:YES];
//    _isTechnicianSignatureChanged = YES;
}

@end
