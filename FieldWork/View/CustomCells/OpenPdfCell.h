//
//  OpenPdfCell.h
//  FieldWork
//
//  Created by Samir Khatri on 04/09/2013.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "PrinterHelper.h"

@interface OpenPdfCell : UITableViewCell /*<UIDocumentInteractionControllerDelegate>*/
{
    IBOutlet UILabel * _lbl;
    IBOutlet UIImageView * _image;
    IBOutlet UIButton * _btnPrint;
    
    Appointment *_appointment;
    UIViewController *_controller;
}
@property (nonatomic ,retain) UILabel * lbl;
@property (nonatomic ,retain) UIImageView * image;
@property (nonatomic ,retain) UIButton * btnPrint;
@property (nonatomic, retain, readwrite) Appointment *appointment;
@property (nonatomic, readwrite, retain) UIViewController *controller;

//@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;

- (IBAction)btnPrint_Click:(id)sender;
- (IBAction)btnOpenPdf_Click:(id)sender;

- (void) triggerPrinting;

@end
