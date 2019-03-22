//
//  ServiceLocationsNotesTableViewCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 12.04.16.
//
//

#import <UIKit/UIKit.h>

@interface ServiceLocationsNotesTableViewCell : UITableViewCell

@property (nonatomic) BOOL isShort;
@property(nonatomic, strong) NSString *notes;
@property (weak, nonatomic) IBOutlet UILabel *labelNotes;
@property (weak, nonatomic) IBOutlet UIButton *buttonView;
@property (nonatomic, copy) void(^viewAction)();
- (CGFloat)calculateHeight;

@end
