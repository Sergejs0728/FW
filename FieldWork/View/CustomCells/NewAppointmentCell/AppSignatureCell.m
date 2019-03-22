//
//  AppSignatureCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppSignatureCell.h"
#import "DrawSignature.h"
#import "KLCPopup.h"

@implementation AppSignatureCell

- (void)awakeFromNib {
//    DrawSignature *signature = [[DrawSignature alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 161)];
//    [signatureView addSubview:signature];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSignature:(Appointment *)app {
    _appointment = app;
    if (app.customer_signature && app.customer_signature.length > 0){
        DrawSignature *signature = [[DrawSignature alloc]initWithFrame:CGRectMake(0, 0, customerSignatureView.frame.size.width, customerSignatureView.frame.size.height)];
        NSMutableArray *arr = [SignaturePoint parseWithArray:app.customer_signature];
        if (arr && arr.count > 0) {
            signature.sigPoints = arr;
        }
        [customerSignatureView addSubview:signature];
        customerDottedView.showDottedBorderAndButton = NO;
    }else {
        customerDottedView.showDottedBorderAndButton = YES;
    }
    
    if (app.technician_signature && app.technician_signature.length > 0){
        DrawSignature *signature = [[DrawSignature alloc]initWithFrame:CGRectMake(0, 0, technicianSignatureView.frame.size.width, technicianSignatureView.frame.size.height)];
        NSMutableArray *arr = [SignaturePoint parseWithArray:app.technician_signature];
        if (arr && arr.count > 0) {
            signature.sigPoints = arr;
        }
        [technicianSignatureView addSubview:signature];
        technicianDottedView.showDottedBorderAndButton = NO;
    }else {
        technicianDottedView.showDottedBorderAndButton = YES;
    }
    [self bringSubviewToFront:customerDottedView];
    [self bringSubviewToFront:technicianDottedView];
}

- (void)setCustomerSignatureTouchBlock:(GeneralNotificationBlock)block
{
    [customerDottedView addButtonClickBlock:^{
        block();
    }];
}

- (void)setTechnicianSignatureTouchBlock:(GeneralNotificationBlock)block
{
    [technicianDottedView addButtonClickBlock:^{
        block();
    }];
}

- (void)btnPreviewClicked:(id)sender {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height - 100 ,[UIScreen mainScreen].bounds.size.width - 50)];
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    if (_appointment.customer_signature && _appointment.customer_signature.length > 0){
        DrawSignature *signature = [[DrawSignature alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        NSMutableArray *arr = [SignaturePoint parseWithArray:_appointment.customer_signature];
        if (arr && arr.count > 0) {
            signature.sigPoints = arr;
        }
        [view addSubview:signature];
        view.transform = CGAffineTransformMakeRotation(M_PI / 2.0f);
    }
    
    
    [[KLCPopup popupWithContentView:view showType:KLCPopupShowTypeSlideInFromTop dismissType:KLCPopupDismissTypeSlideOutToBottom maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:YES] show];
}



@end
