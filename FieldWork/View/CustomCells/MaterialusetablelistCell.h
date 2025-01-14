//
//  MaterialusetablelistCell.h
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialUsageRecord.h"
#import "DilutionRates.h"
#import "MaterialUsage.h"

@interface MaterialusetablelistCell : UITableViewCell
{
    UILabel *lbl1_;
    UILabel *lbl2_;
}
@property (nonatomic,retain,readwrite)IBOutlet UILabel *lbl1;
@property (nonatomic,retain,readwrite)IBOutlet UILabel *lbl2;

- (void)setMaterilUsage:(MaterialUsage *)mur;

@end
