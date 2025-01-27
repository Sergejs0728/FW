//
//  OpenPdfCell.m
//  FieldWork
//
//  Created by Samir Khatri on 04/09/2013.
//
//

#import "OpenPdfCell.h"

@implementation OpenPdfCell
@synthesize lbl=_lbl;
@synthesize image=_image;
@synthesize btnPrint=_btnPrint;
@synthesize appointment= _appointment;
@synthesize controller = _controller;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)btnPrint_Click:(id)sender {
   
//    [self performSelectorOnMainThread:@selector(triggerPrinting) withObject:nil waitUntilDone:NO];
    [self performSelectorInBackground:@selector(triggerPrinting) withObject:nil];
    UIAlertView * Printeralert = [[UIAlertView alloc]initWithTitle:@"FieldWork" message:@"Printing is in progress, please wait..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [Printeralert show];
}

- (void)triggerPrinting {
    //26112015
//    NSString *filePath = [self.appointment appointmentPDFfile];
    PrinterHelper *helper = [[PrinterHelper alloc] init];
//    [helper printFile:filePath];
}

- (void)btnOpenPdf_Click:(id)sender {
    //26112015
//    NSURL * URL = [NSURL fileURLWithPath:[self.appointment appointmentPDFfile]];
    
    
//    if (URL) {
//        // Initialize Document Interaction Controller
//        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
//        
//        // Configure Document Interaction Controller
//        [self.documentInteractionController setDelegate:self];
//        
//        // Present Open In Menu
//        [self.documentInteractionController presentOpenInMenuFromRect:[self frame] inView:self.controller.view animated:YES];
//    }

}

@end
