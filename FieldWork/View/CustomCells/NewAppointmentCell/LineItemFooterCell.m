//
//  LineItemFooterCell.m
//  FieldWork
//
//  Created by SamirMAC on 12/15/15.
//
//

#import "LineItemFooterCell.h"
#import "Invoice.h"
#import "Payment.h"
#import "KeyboardAccessoryHelper.h"

@implementation LineItemFooterCell
@synthesize btnPayNow=_btnPayNow;
@synthesize discountValueChangedBlock;

- (void)awakeFromNib {
    // Initialization code
    _txtDiscount.keyboardType = UIKeyboardTypeDecimalPad;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    _txtDiscount.leftView = paddingView;
    _txtDiscount.leftViewMode = UITextFieldViewModeAlways;
    _txtDiscount.delegate = self;
    
    
    [[KeyboardAccessoryHelper getInstance] createInputAccessoryFor:_txtDiscount inView:self andBlock:^{
        [_txtDiscount endEditing:YES];
        [_txtDiscount resignFirstResponder];
        [_appointment saveAppointmentOnLocal];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)hidePayNowButton {
    [_btnPayNow setHidden:YES];
}

-(void)hideLineItem{
    _lblTax.text = @"$0.0";
    _lblTotal.text = @"$0.0";
    _txtDiscount.text = @"0.0";
}

- (void)setDataWithAppointment:(Appointment *)app withPayNowBlock:(void (^)())block isWorkPool:(BOOL)work_pool {
    
    // Set total and tax
    _isWorkPool = work_pool;
    [self updateData:app];
    TaxRates *tr = app.tax_rate;
    if (tr == nil) {
        ServiceLocation *ser_loc = [app getServiceLocation];
        tr = [TaxRates getTaxRatesById:ser_loc.tax_rate_id];
    }
    NSLog(@"tr = %@", tr);
    NSLog(@"Tax Amount %@",app.tax_amount);
    float discount = app.discountValue;
    [_txtDiscount setText:[NSString stringWithFormat:@"%.02f", discount]];
    
    if (work_pool) {
        [_txtDiscount setText:[NSString stringWithFormat:@"%.02f", [app.discount floatValue]]];
    }

    _tax = tr.rateValue;
//    float rounded_up_tax = ceilf(app.tax_amountValue * 1000) / 1000;
//    _lblTax.text = [NSString stringWithFormat:@"%.02f", rounded_up_tax];
    if (block) {
        [self.btnPayNow setAction:kUIButtonBlockTouchUpInside withBlock:^{
            block();
        }];
    }
}

- (void) updateDataEstimate:(Estimate*)est
{
    _estimate = est;
    
    //    float total = [app getTotalServicePrice];
    ////    ServiceLocation *ser_loc = [app getServiceLocation];
    ////    _tax = [[[TaxRates getTaxRatesById:ser_loc.tax_rate_id] rate] floatValue];
    ////    float tax = (total * _tax);
    //
    //    float discount = app.invoice != nil ? [app.invoice.discount floatValue] : 0.0;
    //    if (_isWorkPool || app.invoice == nil) {
    //        discount = [app.discount floatValue];
    //    }
    //    float discount_amount = ((total * discount) / 100);
    //
    //    float total_due = (total - discount_amount) + app.tax_amountValue;
    //    if (_isWorkPool == NO) {
    //        total_due = total_due + [app.balance_forward floatValue];
    //    }
    _lblTotal.text = [Utils getCurrencyStringFromAmount:[est getFinalTotalDue]];
    //float taxValue = (totΩ©al - discount_amount)*_tax;
    //    float totalTaxable = [app getTaxableLineItemPrice];
    //    float taxValue = totalTaxable *_tax;
    _lblTax.text = [Utils getCurrencyStringFromAmount:est.tax_amountValue];
    
//    // Remove 0.0000001
//    NSString *strTax = [Utils getCurrencyStringFromAmount:est.tax_amountValue];
//
//    est.tax_amountValue = (CGFloat)[strTax floatValue];
    
    
    NSString *strPrice = [Utils getCurrencyStringFromAmount:[est getFinalTotalDue]];
    
//    [est setFin] = (CGFloat)[strPrice floatValue];
    
//        Payment *payment = [app.invoice getMobilePayment];
//        if (payment) {
//            [self.btnPayNow setTitle:@"Edit Payment" forState:UIControlStateNormal];
//            [self.btnPayNow setTitle:@"Edit Payment" forState:UIControlStateHighlighted];
//        }
    
    Customer *_cust = [est getCustomer];
    
    BillingTerms *billing_terms = [BillingTerms getbillingTermsById:[_cust.billing_term_id intValue]];
    if (billing_terms) {
        [_lblBillingTerms setText:[[NSString stringWithFormat:@"Due : %@", billing_terms.name] uppercaseString]];
    }
}

- (void) updateData:(Appointment*)app
{
    _appointment = app;
    
//    float total = [app getTotalServicePrice];
////    ServiceLocation *ser_loc = [app getServiceLocation];
////    _tax = [[[TaxRates getTaxRatesById:ser_loc.tax_rate_id] rate] floatValue];
////    float tax = (total * _tax);
//    
//    float discount = app.invoice != nil ? [app.invoice.discount floatValue] : 0.0;
//    if (_isWorkPool || app.invoice == nil) {
//        discount = [app.discount floatValue];
//    }
//    float discount_amount = ((total * discount) / 100);
//    
//    float total_due = (total - discount_amount) + app.tax_amountValue;
//    if (_isWorkPool == NO) {
//        total_due = total_due + [app.balance_forward floatValue];
//    }
    
    _lblTotal.text = [Utils getCurrencyStringFromAmount:[app getFinalTotalDue]];
    //float taxValue = (total - discount_amount)*_tax;
//    float totalTaxable = [app getTaxableLineItemPrice];
//    float taxValue = totalTaxable *_tax;

    
    _lblTax.text = [Utils getCurrencyStringFromAmount:app.tax_amountValue];
    
    NSLog(@"**********");
    NSLog([Utils getCurrencyStringFromAmount:app.tax_amountValue]);
    
    
//    NSString *value = [NSString stringWithFormat:@"%.02f", app.tax_amountValue];
//    app.tax_amountValue = [value floatValue];
    

    if (app.invoice) {
        Payment *payment = [app.invoice getMobilePayment];
        
        if (payment) {
            [self.btnPayNow setTitle:@"Edit Payment" forState:UIControlStateNormal];
            [self.btnPayNow setTitle:@"Edit Payment" forState:UIControlStateHighlighted];
        }
    }
    
    
    
    Customer *_cust = [app getCustomer];
    
    BillingTerms *billing_terms = [BillingTerms getbillingTermsById:[_cust.billing_term_id intValue]];
    if (billing_terms) {
        [_lblBillingTerms setText:[[NSString stringWithFormat:@"Due : %@", billing_terms.name] uppercaseString]];
    }
}


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(text.length && [text containsString:@"."] ){
        NSArray *array=[text componentsSeparatedByString:@"."];
        if ([[array lastObject] isEqualToString:@"00"]){
            text =[[array firstObject] stringByAppendingString:@"."]; // :: for replacing 00 with the new value user enters
        }
    }

    float dis = [text floatValue];
    if (dis >= 0 && dis <= 100) {
        textField.text = text;
        if (discountValueChangedBlock) {
            _appointment = discountValueChangedBlock(dis);
        }
        [self updateData:_appointment];
    }
    
    
    
    return NO;
}

@end
