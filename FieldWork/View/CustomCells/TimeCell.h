//
//  TimeCell.h
//  FieldWork
//
//  Created by Samir Khatri on 9/19/14.
//
//

#import <UIKit/UIKit.h>

@interface TimeCell : UITableViewCell
{
    IBOutlet UILabel *_lblTitle;
    IBOutlet UILabel *_lblData;
}

@property (nonatomic, retain, readwrite) UILabel *lblTitle;
@property (nonatomic, retain, readwrite) UILabel *lblData;

@end
