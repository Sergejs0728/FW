//
//  TrapListTableViewCell.h
//  FieldWork
//
//  Created by Mac4 on 30/10/14.
//
//

#import <UIKit/UIKit.h>

@interface TrapListTableViewCell : UITableViewCell
{
    IBOutlet UILabel *_lblId;
    IBOutlet UILabel *_lblBarcode;
    IBOutlet UILabel *_lblLocationDetails;
    IBOutlet UILabel *_lblFreqency;
}

@property (nonatomic, retain, readwrite) UILabel *lblId;
@property (nonatomic, retain, readwrite) UILabel *lblBarcode;
@property (nonatomic, retain, readwrite) UILabel *lblLocationDetails;
@property (nonatomic, retain, readwrite) UILabel *lblFrequency;

@end
