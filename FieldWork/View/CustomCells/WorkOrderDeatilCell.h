//
//  WorkOrderDeatilCell.h
//  FieldWork
//
//  Created by SAMCOM on 15/12/15.
//
//

#import <UIKit/UIKit.h>

@interface WorkOrderDeatilCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelText;

- (CGFloat)calculateHeight;

@end
