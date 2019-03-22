//
//  EstimateStatusTableViewCell.h
//  FieldWork
//
//  Created by Alexander on 31.03.17.
//
//

#import <UIKit/UIKit.h>
typedef void(^StatusBlock)(void );

@interface EstimateStatusTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong,nonatomic) NSString* status;
@property (nonatomic) StatusBlock statusChanged;
@end
