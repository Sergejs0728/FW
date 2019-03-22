//
//  UnitDateCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 23.05.17.
//
//

#import <UIKit/UIKit.h>
#import "AppUnitsCell.h"

typedef void (^DoneBlock)(NSDate* date);

@interface UnitDateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLabel;
@property (weak, nonatomic) IBOutlet UITextField *serviceTime;
@property (strong,nonatomic) NSDate* date;
@property (nonatomic)DoneBlock doneBlock;
@property (strong,nonatomic)UIDatePicker* datePicker;
-(void)setTime:(NSString *)time;
@end
