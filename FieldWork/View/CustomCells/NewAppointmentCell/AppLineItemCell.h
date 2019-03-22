//
//  AppLineItemCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "LineItem.h"

@interface AppLineItemCell : UITableViewCell
{
    __weak IBOutlet UILabel *_lblItemDescription;
    __weak IBOutlet UILabel *_lblQty;
    __weak IBOutlet UILabel *_lblPrice;
}


- (void) setLineItem:(LineItem*)line_item forWorkOrder:(Appointment*)app;
- (void)setLineItem:(LineItem *)line_item;
- (void)hideLineItemContents;
@end
