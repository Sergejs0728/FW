//
//  PDFViewerController.m
//  FieldWork
//
//  Created by SamirMAC on 1/6/16.
//
//

#import "PDFViewerController.h"

@interface PDFViewerController ()

@end

@implementation PDFViewerController

@synthesize pdfPath = _pdfPath;

+ (PDFViewerController *)viewControllerWithPDFPath:(NSString *)path forAppointment:(Appointment *)app {
    PDFViewerController *controller = [[PDFViewerController alloc]initWithNibName:@"PDFViewerController" bundle:nil];
    controller.pdfPath = path;
    controller.Appointment = app;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _webView.delegate=self;
    _webView.scalesPageToFit = YES;
    [self displayPdfinWebView];
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *btnClose = [UIBarButtonItem barButtonWithTitle:@"Close" andBlock:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [btnClose setTextColor:[UIColor redColor]];
    self.navigationItem.leftBarButtonItem = btnClose;
    
    self.title = [NSString stringWithFormat:@"WO #%@", self.Appointment.report_number];
}

-(void)displayPdfinWebView {
    NSURL *targetURL = [NSURL fileURLWithPath:self.pdfPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [_webView loadRequest:request];
}

@end
