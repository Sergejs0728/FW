//
//  AppointmentDetailAddressCell.h
//  FieldWork
//
//  Created by Samir Khatri on 3/5/14.
//
//

#import <UIKit/UIKit.h>

@interface AppointmentDetailAddressCell : UITableViewCell
{
    IBOutlet UILabel *_lblAddress;
}

@property (nonatomic, retain, readwrite) UILabel *lblAddress;

@end
