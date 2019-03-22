//
//  CaptureSignatureController.m
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CaptureSignatureController.h"
#import "PDFField.h"
//26112015
//#import "User.h"

@interface CaptureSignatureController()
{
@private
	
	__unsafe_unretained id<JBSignatureControllerDelegate> delegate_;
}
@property(nonatomic,strong) JBSignatureView *signatureView;

@property (nonatomic, copy) GeneralNotificationBlock savedBlock;
@property (nonatomic, copy) DataSelectionOrAddedBlock addedBlock;

@end

@implementation CaptureSignatureController

@synthesize signatureView=signatureView_,delegate=delegate_;
@synthesize signatureContainer = _signatureContainer;

@synthesize captureMode = _captureMode;

+ (CaptureSignatureController *)viewControllerWithAppointment:(Appointment *)app withCaptureMode:(CaptureMode)mode andBlock:(GeneralNotificationBlock)block{
//    CaptureSignatureController *controller = [[CaptureSignatureController alloc] initWithNibName:@"CaptureSignatureController" bundle:nil];
    CaptureSignatureController *controller; 
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        controller = [[CaptureSignatureController alloc] initWithNibName:@"CaptureSignatureController_IPad" bundle:nil];        
    }else{
        controller = [[CaptureSignatureController alloc] initWithNibName:@"CaptureSignatureController" bundle:nil];
    }

    controller.Appointment = app;
    controller->_captureMode = mode;
    controller.savedBlock = block;
    return controller;
}

+ (CaptureSignatureController *)viewControllerWithPDFAttachment:(PDFAttachment *)pdfAttachment andBlock:(DataSelectionOrAddedBlock)block{
    //    CaptureSignatureController *controller = [[CaptureSignatureController alloc] initWithNibName:@"CaptureSignatureController" bundle:nil];
    CaptureSignatureController *controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        controller = [[CaptureSignatureController alloc] initWithNibName:@"CaptureSignatureController_IPad" bundle:nil];
    }else{
        controller = [[CaptureSignatureController alloc] initWithNibName:@"CaptureSignatureController" bundle:nil];
        
    }
    controller.captureMode=
    controller.attachment = pdfAttachment;
    controller.addedBlock = block;
    return controller;
}

+ (CaptureSignatureController *)initViewController{
    CaptureSignatureController * controller = [[CaptureSignatureController alloc]initWithNibName:@"CaptureSignatureController" bundle:nil];
    controller.title = @"Workpool list";
    return controller;
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //08032013
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //self.signatureView = [[JBSignatureView alloc] initWithFrame:CGRectMake(0,0,685.0,350.0)] ; //958,639
  
    }else{
//        if ([[UIScreen mainScreen] bounds].size.height == 568) {
//        // Iphone 5
//             //self.signatureView = [[JBSignatureView alloc] initWithFrame:CGRectMake(0, 0, 553.0,231.0)] ;//438.0,213.0
//        }else{
//             //self.signatureView = [[JBSignatureView alloc] initWithFrame:CGRectMake(0, 0, 453.0,231.0)] ;//438.0,213.0
//        // iphone 4
//            
//            
//        }
        borderContainerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        borderContainerView.layer.cornerRadius = 1.0;
        borderContainerView.layer.borderWidth = 1.0;
        
        _newSignatureView.lineWidth = 2.0f;
     }
    

    
   // self.signatureView = [[JBSignatureView alloc] initWithFrame:CGRectMake(0, 0, 438.0,213.0)] ;
    //436.0,208.0
   // self.signatureView = [[JBSignatureView alloc] initWithFrame:CGRectMake(0, 0, 436.0,190.0)] ;
    
    self.signatureView.delegate = self;
    signatureView_.userInteractionEnabled = YES;
    signatureView_.multipleTouchEnabled = YES;
    [self.signatureContainer addSubview:self.signatureView];
    NSString *licenseNumber = @"";
    
    if(self.captureMode == CustomerMode)
    {
        [signatureLbl setText:@"Customer Signature"];
    }
    
    if(self.captureMode == TechnicianMode)
    {
        [signatureLbl setText:@"Technician Signature"];
        User *user = [User getUser];
        if (user.license_number != nil && user.license_number.length > 0) {
            licenseNumber = [NSString stringWithFormat:@"LIC# %@", user.license_number];
        }
    }
    if(self.captureMode == SimpleSignatureMode){
        [signatureLbl setText:@"Signature"];
    }
    lblLicenseNumber.text = licenseNumber;
    
    
//    CGAffineTransform newTransform = CGAffineTransformMake(0.0,1.0,-1.0,0.0,0.0,0.0);         
    self.view.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_closeBlock) {
        _closeBlock();
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
    [self clearSignature];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(signatureCancelled:)]) {
		[self.delegate signatureCancelled:self];
	}    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}
-(BOOL)shouldAutomaticallyForwardRotationMethods
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (void)cancelClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clearSignature {
	
	if (self.delegate && [self.delegate respondsToSelector:@selector(signatureCleared:signatureController:)]) {
		UIImage *signatureImage = [self.signatureView getSignatureImage];
		[self.delegate signatureCleared:signatureImage signatureController:self];
	}
	
	[self.signatureView clearSignature];
}

-(void)btnClearClicked:(id)sender{
    [_newSignatureView clear];
}

- (void)saveSignature:(id)sender {
    if ([_newSignatureView getSignatureArray].count > 0) {
        NSMutableArray *arr = [_newSignatureView getSignatureArray];
        NSString *tech_sig = [SignaturePoint getSignatureJson:arr];
        if (self.Appointment) {
            switch (_captureMode) {
                case CustomerMode: {
                    if (self.Appointment.customer_signature != nil && self.Appointment.customer_signature.length > 0) {
                        self.Appointment.customer_signature = nil;
                    }
                    [self.Appointment setCustomer_signature:tech_sig];
                    [self.Appointment saveAppointmentOnLocal];
                }
                    break;
                case TechnicianMode: {
                    if (self.Appointment.technician_signature!= nil && self.Appointment.technician_signature.length > 0) {
                        self.Appointment.technician_signature = nil;
                    }
                    [self.Appointment setTechnician_signature:tech_sig];
                    [self.Appointment saveAppointmentOnLocal];
                }
                    break;
//                case SimpleSignatureMode: {
//                }
//                    break;
                    
                default:
                    break;
            }
            if(self.savedBlock) {
                self.savedBlock();
            }
        } else {
            if(self.addedBlock) {
                self.addedBlock(tech_sig);
            }
        }
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    [self postNotificationForDirty];
}

@end
