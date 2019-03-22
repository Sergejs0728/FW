//
//  AppChemicalCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import <UIKit/UIKit.h>
#import "MaterialUsage.h"

@interface AppChemicalCell : UITableViewCell
{
    __weak IBOutlet UILabel *_lblChemicalName;
    __weak IBOutlet UILabel *_lblChemicalDetail;
}

- (void) setMaterialUsage:(MaterialUsage*) material_usage;

@end
