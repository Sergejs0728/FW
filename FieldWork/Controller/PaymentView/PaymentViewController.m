//
//  PaymentViewController.m
//  FieldWork
//
//  Created by SAMCOM on 15/12/15.
//
//

#import "PaymentViewController.h"
#import "PaymentCell.h"
#import "DataTableViewController.h"
#import "NewAppointMentsDetailViewController.h"

@interface PaymentViewController ()
{
    NSDictionary *selected_method;
}

@end

@implementation PaymentViewController
@synthesize Tblobj,Arrdata;

+(PaymentViewController *)initViewControllerWithAppointment:(Appointment *)app
{
    PaymentViewController *controller=[[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
    controller.title=@"Payment";
    controller.Appointment = app;
    return controller;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = [User getUser];
    if (user.stripe_pk == nil && user.stripe_pk.length == 0) {
        btnSacnCard.hidden = YES;
    }
    formatter = [NSNumberFormatter new];
    NSLocale *american = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:american];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""]; // <-- this
    [formatter setGeneratesDecimalNumbers:YES];
  
    NSLog(@"Count %lu",(unsigned long)[self.Appointment.invoice.payments allObjects].count);
    if (self.Appointment.invoice && [self.Appointment.invoice.payments allObjects].count > 0) {
        Payment *payment = [self.Appointment.invoice getMobilePayment];
        NSString *method = payment.payment_method;
        NSArray *methods = [self.Appointment getCustomer].payment_methods;
        
        NSArray *temp_values = [methods valueForKey:@"value"];
        NSUInteger index = [temp_values indexOfObject:method];
        if (index != NSNotFound) {
            selected_method = [methods objectAtIndex:index];
        }
        
    }
    
    
    [lblTotalDue setText:[Utils getCurrencyStringFromAmount:[self.Appointment getFinalTotalDue]]];

    UIBarButtonItem *save = [UIBarButtonItem barButtonWithTitle:@"Save" andBlock:^{
        [self save];
    }];
    self.navigationItem.rightBarButtonItem=save;
   
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void) save
{
    NSString *temp_method = ((PaymentCell*)[Tblobj cellForRowAtIndexPath:[NSIndexPath indexPathForItem:InvoicePaymentMethod inSection:0]]).txtvalue.text;
    NSString *temp_ref_num = ((PaymentCell*)[Tblobj cellForRowAtIndexPath:[NSIndexPath indexPathForItem:InvoiceReferenceNumber inSection:0]]).txtvalue.text;
    NSString *paymentAmount = ((PaymentCell*)[Tblobj cellForRowAtIndexPath:[NSIndexPath indexPathForItem:InvoicePaymentAmount inSection:0]]).txtvalue.text;
   // NSString *discount = ((PaymentCell*)[Tblobj cellForRowAtIndexPath:[NSIndexPath indexPathForItem:InvoiceDiscount inSection:0]]).txtvalue.text;
    
//    if (discount.length <= 0) {
//        discount = @"0";
//    }
    
    if (temp_method == nil || temp_method.length <= 0 || selected_method == nil) {
        [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please select payment method." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    if ([[selected_method valueForKey:@"value"] isEqualToString:@"check"] && (temp_ref_num == nil || temp_ref_num.length <= 0)) {
        [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter check number." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;        
    }
    
    float amount = [Utils getValueFromCurrencyStyleString:paymentAmount];
    
    if (amount <= 0) {
        [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please enter valid amount." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    
    if (self.Appointment.invoice == nil) {
        Invoice *invoice = [Invoice invoiceWithAppointment:self.Appointment];
        [invoice setDiscount:self.Appointment.discount];
        [self.Appointment setInvoice:invoice];
    } else {
        //[self.Appointment.invoice setDiscount:[NSNumber numberWithFloat:[discount floatValue]]];
    }
    Payment *payment = nil;
    if (self.Appointment.invoice.payments == nil || self.Appointment.invoice.payments.count <= 0) {
        payment = [Payment newPayment];
        [self.Appointment.invoice addPaymentsObject:payment];
    } else {
        payment = [self.Appointment.invoice getMobilePayment];
    }
    [payment setCheck_number:temp_ref_num];
    payment.payment_method = [selected_method valueForKey:@"value"];
    
    
    
    [payment setAmount:[NSNumber numberWithFloat:amount]];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [[NSNotificationCenter defaultCenter] postNotificationName:kWORKORDER_DETAIL_UPDATE_SECTION object:self userInfo:@{@"section":@(FWLineItem)}];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return InvoiceTotalRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaymentCell *cell = (PaymentCell *)[tableView dequeueReusableCellWithIdentifier:@"PaymentCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PaymentCell" owner:self options:nil] objectAtIndex:0];
    }
    if (indexPath.row == InvoicePaymentMethod) {
        NSString *selected_method_name = @"";
        if (selected_method) {
            selected_method_name = [selected_method valueForKey:@"name"];
        }
        cell.txtvalue.text=selected_method_name;
        cell.lblnm.text=@"Payment Method";
        cell.txtvalue.enabled = NO;
    }else if (indexPath.row == InvoicePaymentAmount){
        cell.txtvalue.text=@"";
        cell.lblnm.text=@"Payment Amount";
        cell.txtvalue.text = [Utils getCurrencyStringFromAmount:[self.Appointment getFinalTotalDue]];
        if (self.Appointment.invoice && [self.Appointment.invoice.payments allObjects].count > 0) {
            Payment *payment = [self.Appointment.invoice getMobilePayment];
            if (payment)
                cell.txtvalue.text = [Utils getCurrencyStringFromAmount:[payment.amount floatValue]];
        }
        cell.txtvalue.delegate =self;
        cell.txtvalue.keyboardType = UIKeyboardTypeDecimalPad;
        cell.txtvalue.tag = InvoicePaymentAmount;
    }else if (indexPath.row == InvoiceReferenceNumber){
        cell.txtvalue.text=@"";
        cell.lblnm.text=@"Reference #";
        if (self.Appointment.invoice && [self.Appointment.invoice.payments allObjects].count > 0) {
            Payment *payment = [self.Appointment.invoice getMobilePayment];
            [cell.txtvalue setText:payment.check_number];
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == InvoicePaymentMethod) {
        Customer *customer = [Customer getById:self.Appointment.customer_id];
        if (customer) {
            NSArray *arr = [(NSArray*)customer.payment_methods mutableCopy];
            if (arr.count >0) {
                [self navigatetoPaymentMethods];
            }else{
//                __weak PaymentViewController *weakself = self;
//                [customer loadPaymentMethods:^(id result, NSString *error) {
//                    [weakself navigatetoPaymentMethods];
//                }];
            }
        }
    }
}


-(void)navigatetoPaymentMethods{
    DataTableViewController *controller = [DataTableViewController tableWithDataType:PaymentMethod andDelegate:nil];
    controller.customer_id = self.Appointment.customer_id;
    controller.dataSelectionBlock = ^(id data){
        selected_method = data;
        [Tblobj reloadData];
    };
    [self.navigationController pushViewController:controller animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    Customer *cust = [self.Appointment getCustomer];
    if ([cust isHavingCreditCardStored]) {
        return 25;
    }
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Customer *cust = [self.Appointment getCustomer];
    if ([cust isHavingCreditCardStored]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
        [label setFont:[UIFont boldSystemFontOfSize:12]];
        [label setText:@"Credit card on file."];
        label.textColor=[UIColor whiteColor];
        [view addSubview:label];
        [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
        return view;
    } else {
        return [[UIView alloc] init];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag == InvoicePaymentAmount) {
//        NSString *replaced = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        
//        NSDecimalNumber *amount = (NSDecimalNumber*) [formatter numberFromString:replaced];
//        
//        if ([amount floatValue] == 0 || amount == nil) {
//            textField.placeholder =@"0.00";
//            return YES;
//        }
//        
//        // If the field is empty (the inital case) the number should be shifted to
//        // start in the right most decimal place.
//        short powerOf10 = 0;
//        if ([textField.text isEqualToString:@""]) {
//            powerOf10 = -formatter.maximumFractionDigits;
//        }
//        // If the edit point is to the right of the decimal point we need to do
//        // some shifting.
//        else if (range.location + formatter.maximumFractionDigits >= textField.text.length) {
//            // If there's a range of text selected, it'll delete part of the number
//            // so shift it back to the right.
//            if (range.length) {
//                powerOf10 = -range.length;
//            }
//            // Otherwise they're adding this many characters so shift left.
//            else {
//                powerOf10 = [string length];
//            }
//        }
//        amount = [amount decimalNumberByMultiplyingByPowerOf10:powerOf10];
        NSString *originalString = [textField.text stringByReplacingOccurrencesOfString:formatter.currencySymbol withString:@""];
        NSString* noSpaces =
        [[originalString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
         componentsJoinedByString:@""];
        range.location = range.location - (textField.text.length - noSpaces.length);
        NSString *replaced = [noSpaces stringByReplacingCharactersInRange:range withString:string];
        NSDecimalNumber *amount = (NSDecimalNumber*) [formatter numberFromString:replaced];
        if (amount == nil) {
            // Something screwed up the parsing. Probably an alpha character.
            return NO;
        }
        // If the field is empty (the inital case) the number should be shifted to
        // start in the right most decimal place.
        short powerOf10 = 0;
        if ([textField.text isEqualToString:@""]) {
            powerOf10 = -formatter.maximumFractionDigits;
        }
        // If the edit point is to the right of the decimal point we need to do
        // some shifting.
        else if (range.location + formatter.maximumFractionDigits >= noSpaces.length) {
            // If there's a range of text selected, it'll delete part of the number
            // so shift it back to the right.
            if (range.length) {
                powerOf10 = -range.length;
            }
            // Otherwise they're adding this many characters so shift left.
            else {
                powerOf10 = [string length];
            }
        }
        amount = [amount decimalNumberByMultiplyingByPowerOf10:powerOf10];
        
        // Replace the value and then cancel this change.
        
        textField.text = [Utils getCurrencyStringFromAmount:[amount floatValue]];
        return NO;
        
    }
    return YES;
}

-(IBAction)btnScanNewCardClicked:(id)sender {
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    [self presentViewController:scanViewController animated:YES completion:nil];
}

#pragma -mark
#pragma mark cardIO delegate method
- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
   
    [[ActivityIndicator currentIndicator] displayActivity:@"Connecting stripe..."];
    
    //add card data to stripe card param
    STPCardParams *stripeCardParam = [[STPCardParams alloc] init];
    stripeCardParam.number = info.cardNumber;
    _card_number = info.cardNumber;
    stripeCardParam.cvc = info.cvv;
    stripeCardParam.expMonth = info.expiryMonth;
    stripeCardParam.expYear = info.expiryYear;
    [[STPAPIClient sharedClient] createTokenWithCard:stripeCardParam completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
        if(error){
            [[ActivityIndicator currentIndicator] displayCompleted];
            [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:error.description delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            NSLog(@"error : %@", error.description);
        } else{
            Customer *customer = [self.Appointment getCustomer];
            [customer addNewPaymentMethod:token.tokenId withBlock:^(id item, BOOL is_success, NSString *error) {
                [[ActivityIndicator currentIndicator] displayCompleted];
                if (is_success) {
                    Customer *cust = [self.Appointment getCustomer];
                    NSArray *payment_methods = (NSArray*)cust.payment_methods;
                    for (NSDictionary *dict in payment_methods) {
                        NSString *card_num = [dict objectForKey:@"name"];
                        NSString *last_four_digicts = [_card_number substringWithRange:NSMakeRange(_card_number.length - 4, 4)];
                        if ([card_num rangeOfString:last_four_digicts].location != NSNotFound) {
                            NSLog(@"Condition True");
                            selected_method = dict;
                            [self.Tblobj reloadData];
                            break;
                        }
                    }
                    [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Card successfully added." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                } else {
                    [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                }
            }];
            NSLog(@"Token id : %@",token.tokenId);
        }
    }];
   
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
