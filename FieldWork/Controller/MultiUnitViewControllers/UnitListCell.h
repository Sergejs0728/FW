//
//  UnitListCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 17.05.17.
//
//

#import <UIKit/UIKit.h>
#import "Unit.h"

@interface UnitListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tenantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitNumberLabel;
@property (strong, nonatomic) Unit* unit;
@end
