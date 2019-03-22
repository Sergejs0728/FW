//
//  CustomTableCell.h
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell<UITextFieldDelegate>
{
    UILabel *lbl_;
    UITextField *txt_;
}
@property (nonatomic,retain,readwrite)IBOutlet UILabel *lbl;
@property (nonatomic,retain,readwrite)IBOutlet UITextField *txt;
-(IBAction)keyboard:(id)sender;
@end
