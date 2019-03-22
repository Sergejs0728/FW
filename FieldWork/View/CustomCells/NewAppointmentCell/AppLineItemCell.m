//
//  AppLineItemCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppLineItemCell.h"
#import "Estimate.h"

@interface AppLineItemCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBorder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;

@end

@implementation AppLineItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLineItem:(LineItem *)line_item forWorkOrder:(Appointment*)app {
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _leftBorder.constant=166;
        _lineWidth.constant=4;
    }
    [_lblItemDescription setText:line_item.name];
    [_lblQty setText:[NSString stringWithFormat:@"%@", line_item.quantity ]];
    _lblQty.adjustsFontSizeToFitWidth = true;
    _lblQty.minimumScaleFactor = 0.2;
    [_lblPrice setText:[Utils getCurrencyStringFromAmount:[line_item.price floatValue]]];
    if (app.hide_invoice_informationValue) {
        [_lblPrice setText:@"0.00"];
    }
    _lblPrice.adjustsFontSizeToFitWidth = true;
    _lblPrice.minimumScaleFactor = 0.2;
//    if(!app.auto_generates_invoiceValue){
//        _leftBorder.constant=-5;
//        [_lblPrice setHidden:YES];
//    }
}

- (void)setLineItem:(LineItem *)line_item{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _leftBorder.constant=166;
        _lineWidth.constant=4;
    }
    [_lblItemDescription setText:line_item.name];
    [_lblQty setText:[NSString stringWithFormat:@"%@", line_item.quantity ]];
    _lblQty.adjustsFontSizeToFitWidth = true;
    _lblQty.minimumScaleFactor = 0.2;
    
    [_lblPrice setText:[Utils getCurrencyStringFromAmount:[line_item.price floatValue]]];
    _lblPrice.adjustsFontSizeToFitWidth = true;
    _lblPrice.minimumScaleFactor = 0.2;
}

-(void)hideLineItemContents{
   [_lblPrice setText:@"0.00"];
}

@end
