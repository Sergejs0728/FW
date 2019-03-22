//
//  LineItemFooterCell.h
//  FieldWork
//
//  Created by SamirMAC on 12/15/15.
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "UIButton+Block.h"
#import "Estimate.h"

typedef Appointment*(^DiscountValueChanged)(float discount);

@interface LineItemFooterCell : UITableViewCell <UITextFieldDelegate>
{
    IBOutlet UILabel *_lblTax;
    IBOutlet UILabel *_lblTotal;
    IBOutlet UITextField *_txtDiscount;
    
    Appointment *_appointment;
    
    float _tax;
    
    NSNumberFormatter * formatter;
    
    IBOutlet UILabel *_lblBillingTerms;
    
    BOOL _isWorkPool;
}

@property (nonatomic, copy) DiscountValueChanged discountValueChangedBlock;

@property (nonatomic ,retain) IBOutlet UIButton * btnPayNow;
@property (strong, nonatomic) Estimate* estimate;
@property (nonatomic, retain) NSMutableString *storedValue;;

- (void)setDataWithAppointment:(Appointment *)app withPayNowBlock:(void (^)())block isWorkPool:(BOOL)work_pool;

- (void) updateData:(Appointment*)app;

- (void) updateDataEstimate:(Estimate*)est;

-(void) setTotal:(Appointment*)app;

- (void) hidePayNowButton;

- (void) hideLineItem;
@end
