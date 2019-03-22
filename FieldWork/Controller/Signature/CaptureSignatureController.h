//
//  CaptureSignatureController.h
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CommonAppointmentViewController.h"
#import "Appointment.h"
#import "JBSignatureView.h"
#import "NSData+NSDataBase64Encoding.h"
#import "ACEDrawingView.h"
#import "CaptureSignatureController.h"
#import "User.h"
#import "PDFAttachment.h"
#import "FWPDFForm.h"

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@protocol JBSignatureControllerDelegate <NSObject>
@optional

    // Called when the user clicks the cancel button
-(void)signatureCancelled:(UIViewController *)sender;

    // Called when the user clears their signature or when clearSignature is called.
-(void)signatureCleared:(UIImage *)clearedSignatureImage signatureController:(UIViewController *)sender;
@end


@interface CaptureSignatureController : CommonAppointmentViewController <JBSignatureControllerDelegate, JBSignatureViewDelegate>
{
    //26112015
    CaptureMode _captureMode;
    IBOutlet UIView *_signatureContainer;
    JBSignatureView *signatureView_;
    IBOutlet UILabel *signatureLbl;
    IBOutlet UILabel *lblLicenseNumber;
    IBOutlet UIView * borderContainerView;
    
    IBOutlet ACEDrawingView *_newSignatureView;
}
@property (nonatomic, assign) CaptureMode captureMode;
@property (nonatomic, strong) PDFAttachment* attachment;
@property (nonatomic, retain, readwrite) IBOutlet UIView *signatureContainer;
@property (nonatomic)GeneralNotificationBlock closeBlock;
@property(nonatomic,unsafe_unretained) id<JBSignatureControllerDelegate> delegate;

//26112015
+ (CaptureSignatureController*) viewControllerWithAppointment:(Appointment*) app withCaptureMode:(CaptureMode)mode andBlock:(GeneralNotificationBlock)block;
+ (CaptureSignatureController *)viewControllerWithPDFAttachment:(PDFAttachment *)pdfAttachment andBlock:(DataSelectionOrAddedBlock)block;
//+ (CaptureSignatureController *)initViewController;
- (IBAction)cancelClicked:(id)sender;
- (IBAction)saveSignature:(id)sender;
-(void)clearSignature ;
- (IBAction)btnClearClicked:(id)sender;
@end
