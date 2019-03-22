 //
//  UIExpandableTableView.h
//  FieldWork
//
//  Created by SamirMAC on 12/14/15.
//
//

#import <UIKit/UIKit.h>

#import "HeaderView.h"

@interface UIExpandableTableView : UITableView <HeaderViewProtocol>
{
    NSInteger _sectionOpen;
}

@property (nonatomic, assign) NSInteger sectionOpen;

@end
