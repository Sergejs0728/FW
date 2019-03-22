//
//  PDFViewerController.h
//  FieldWork
//
//  Created by SamirMAC on 1/6/16.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"

@interface PDFViewerController : CommonAppointmentViewController <UIWebViewDelegate>
{
    NSString *_pdfPath;
    
    __weak IBOutlet UIWebView *_webView;
}

@property (nonatomic, retain, readwrite) NSString *pdfPath;


+ (PDFViewerController*) viewControllerWithPDFPath:(NSString*)path forAppointment:(Appointment*)app;


@end
