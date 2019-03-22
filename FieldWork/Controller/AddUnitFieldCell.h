//
//  AddUnitFieldCell.h
//  FieldWork
//
//  Created by Alexander Kotenko  on 10.05.17.
//
//

#import <UIKit/UIKit.h>
typedef void(^DidChangeValue)(NSString* value);
@interface AddUnitFieldCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fieldNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *field;
@property (strong,nonatomic) DidChangeValue blockDidChange;
@end
