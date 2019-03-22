//
//  AppSignatureCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "DottedView.h"


#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface AppSignatureCell : UITableViewCell
{
    __weak IBOutlet UIView *customerSignatureView;
    __weak IBOutlet UIView *technicianSignatureView;
    
    __weak IBOutlet DottedView *customerDottedView;
    __weak IBOutlet DottedView *technicianDottedView;
    
    Appointment *_appointment;
}

- (void) setSignature:(Appointment*) app;

- (void)setCustomerSignatureTouchBlock:(GeneralNotificationBlock)block;

- (void)setTechnicianSignatureTouchBlock:(GeneralNotificationBlock)block;

- (IBAction)btnPreviewClicked:(id)sender;

@end
