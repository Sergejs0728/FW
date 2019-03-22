//
//  AppServiceCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import <UIKit/UIKit.h>

@interface AppServiceCell : UITableViewCell
{
    IBOutlet UITextView *serviceInstructionsLabel;
}
- (CGFloat)getLabelHeight;

- (void)setServiceInstructionsText:(NSString*)text;
@end
