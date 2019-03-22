//
//  AppPdfFormCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import <UIKit/UIKit.h>
#import "FWPDFForm.h"
#import "Appointment.h"
#import "LBorderView.h"

@interface AppPdfFormCell : UITableViewCell
{
    __weak IBOutlet UILabel *_lblPdfName;
    
    __weak IBOutlet LBorderView *_vRoundCircle;
    
    __weak IBOutlet UIImageView *_imgCheckMark;
}

- (void) setPdfForm:(FWPDFForm*) form;

@end
