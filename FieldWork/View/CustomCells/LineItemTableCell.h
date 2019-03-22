//
//  LineItemTableCell.h
//  FieldWork
//
//  Created by Samir Khatri on 8/11/14.
//
//

#import <UIKit/UIKit.h>

@interface LineItemTableCell : UITableViewCell{
    IBOutlet UILabel * _lblName;
    IBOutlet UILabel * _lblQty;
    IBOutlet UILabel * _lblPrice;
}

@property (nonatomic ,retain) UILabel * lblName;
@property (nonatomic ,retain) UILabel * lblQty;
@property (nonatomic ,retain) UILabel * lblPrice;


@end
