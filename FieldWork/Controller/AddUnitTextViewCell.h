//
//  AddUnitTextViewCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 10.05.17.
//
//

#import <UIKit/UIKit.h>
#import "AddUnitFieldCell.h"

@interface AddUnitTextViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic) DidChangeValue blockDidChange;
@end
