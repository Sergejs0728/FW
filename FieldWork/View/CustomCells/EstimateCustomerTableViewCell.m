//
//  EstimateCustomerTableViewCell.m
//  FieldWork
//
//  Created by Alexander on 31.03.17.
//
//

#import "EstimateCustomerTableViewCell.h"

@interface EstimateCustomerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityStateZipLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *address2Label;
@property (strong, nonatomic) Customer* customer;
@property (strong, nonatomic) ServiceLocation* serviceLocation;
@end

@implementation EstimateCustomerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setEstimate:(Estimate *)estimate{
    _estimate=estimate;
}

-(void)showCustomer{
    _customer= [_estimate getCustomer];
    [_nameLabel setText:[NSString stringWithFormat:@"%@ %@",_customer.name, _customer.last_name]];
    [_addressLabel setText:_customer.billing_street];
    [_address2Label setText:_customer.billing_street2];
    NSMutableString* cityStateZipString=[NSMutableString new];
    if (_customer.billing_city) {
        [cityStateZipString appendString:[NSString stringWithFormat:@"%@",_customer.billing_city]];
    }
    if (_customer.billing_state) {
        [cityStateZipString appendString:[NSString stringWithFormat:@",%@",_customer.billing_state]];
    }
    if (_customer.billing_zip) {
        [cityStateZipString appendString:[NSString stringWithFormat:@",%@",_customer.billing_zip]];
    }
    [_cityStateZipLabel setText:cityStateZipString];
}


-(void)showServiceLocation{
    _serviceLocation=[_estimate getServiceLocation];
    [_nameLabel setText:[NSString stringWithFormat:@"%@",_serviceLocation.name]];
    [_addressLabel setText:_serviceLocation.street];
    [_address2Label setText:_serviceLocation.street2];
    NSMutableString* cityStateZipString=[NSMutableString new];
    if (_serviceLocation.city) {
        [cityStateZipString appendString:[NSString stringWithFormat:@"%@",_serviceLocation.city]];
    }
    if (_serviceLocation.state) {
        [cityStateZipString appendString:[NSString stringWithFormat:@",%@",_serviceLocation.state]];
    }
    if (_serviceLocation.zip) {
        [cityStateZipString appendString:[NSString stringWithFormat:@",%@",_serviceLocation.zip]];
    }
    [_cityStateZipLabel setText:cityStateZipString];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

@end
