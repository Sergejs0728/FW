//
//  NewCustomerTableViewController.h
//  FieldWork
//
//  Created by Samir on 10/27/15.
//
//

#import <UIKit/UIKit.h>
#import "CustomersContentCell.h"

@interface NewCustomerTableViewController : UITableViewController<UISearchDisplayDelegate>


@property (nonatomic,assign)BOOL isMenuOption;

+ (NewCustomerTableViewController *) initControllerWithMenu:(BOOL)isMenu;
- (IBAction) menuClicked:(id)sender;
- (IBAction) addCustomer:(id)sender;
@end
