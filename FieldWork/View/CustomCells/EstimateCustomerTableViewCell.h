//
//  EstimateCustomerTableViewCell.h
//  FieldWork
//
//  Created by Alexander on 31.03.17.
//
//

#import <UIKit/UIKit.h>
#import "Estimate.h"


@interface EstimateCustomerTableViewCell : UITableViewCell
@property (strong, nonatomic) Estimate* estimate;
-(void)showCustomer;
-(void)showServiceLocation;
@end
