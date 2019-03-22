//
//  MaterialusetablelistCell.m
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MaterialusetablelistCell.h"
#import "MaterialUsage.h"

@implementation MaterialusetablelistCell

@synthesize lbl1=lbl1_;
@synthesize lbl2=lbl2_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMaterilUsage:(MaterialUsage *)mur {
    self.lbl1.text = [Material getById:mur.material_id].name;
    if (mur.material_usage_records && mur.material_usage_records.count > 0) {
        MaterialUsageRecord *record = [[mur.material_usage_records allObjects] objectAtIndex:0];
        DilutionRates *dr = [DilutionRates dilutionRateById:record.dilution_rate_id];
//        NSString *l2 = [NSString stringWithFormat:@"%@, %.02f %@, %@", dr.name, [record.amount floatValue], record.measurement ,record.application_method];
        NSString *l2 = [NSString stringWithFormat:@"%@, %.02f %@, %@", dr.name, [mur getTotalQty], record.measurement ,record.application_method];
        self.lbl2.text = l2;
    }else{
        self.lbl2.text = @"";
    }
}

@end
