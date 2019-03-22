//
//  PaymentCell.h
//  FieldWork
//
//  Created by SAMCOM on 15/12/15.
//
//

#import <UIKit/UIKit.h>

@interface PaymentCell : UITableViewCell
{
    UILabel *lblnm;
    UITextField *txtvalue;
}
@property(nonatomic,strong) IBOutlet UILabel *lblnm;
@property(nonatomic,strong) IBOutlet UITextField *txtvalue;
@end
