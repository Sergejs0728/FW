//
//  PestActivityCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 15.06.17.
//
//

#import <UIKit/UIKit.h>
#import "PestActivity.h"

@interface PestActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelPest;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLevel;
@property (nonatomic)void(^doneBlock)(NSNumber* activityLevelId);
@property (nonatomic, strong) PestActivity *pestActivity;

@end
