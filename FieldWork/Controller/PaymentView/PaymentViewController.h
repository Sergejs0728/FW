//
//  PaymentViewController.h
//  FieldWork
//
//  Created by SAMCOM on 15/12/15.
//
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"
#import "Invoice.h"
#import "Payment.h"
#import "CardIO.h"
#import <Stripe/Stripe.h>

typedef NS_ENUM(NSInteger, NSRowType) {
//    InvoicePreviousBalance = 0,
//    InvoiceDiscount = 1,
    InvoicePaymentMethod = 0,
    InvoicePaymentAmount = 1,
    InvoiceReferenceNumber = 2,

    InvoiceTotalRows = 3
};

@interface PaymentViewController : CommonAppointmentViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CardIOPaymentViewControllerDelegate>
{
    UITableView *Tblobj;
    NSMutableArray *Arrdata;
    NSNumberFormatter * formatter;
    __weak IBOutlet UILabel *lblTotalDue;
    
    NSString *_card_number;
    __weak IBOutlet UIButton *btnSacnCard;
}
@property(nonatomic,strong) IBOutlet UITableView *Tblobj;
@property(nonatomic,strong) NSMutableArray *Arrdata;


+(PaymentViewController *)initViewControllerWithAppointment:(Appointment*)app;

-(IBAction)btnScanNewCardClicked:(id)sender;

@end
