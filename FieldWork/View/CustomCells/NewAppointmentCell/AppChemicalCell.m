//
//  AppChemicalCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppChemicalCell.h"
#import "Material.h"

@implementation AppChemicalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMaterialUsage:(MaterialUsage *)material_usage {
    _lblChemicalName.text = [Material getById:material_usage.material_id].name;
    if (material_usage.material_usage_records && material_usage.material_usage_records.count > 0) {
        MaterialUsageRecord *record = [[material_usage.material_usage_records allObjects] objectAtIndex:0];
        DilutionRates *dr = [DilutionRates dilutionRateById:record.dilution_rate_id];
//        NSString *l2 = [NSString stringWithFormat:@"%@, %.02f %@, %@", dr.name, [record.amount floatValue], record.measurement ,record.application_method];
        NSString *l2 = [NSString stringWithFormat:@"%@, %.02f %@, %@", dr.name, [material_usage getTotalQty], record.measurement ,record.application_method];
        _lblChemicalDetail.text = l2;
    } else {
        _lblChemicalDetail.text = @"";
    }
}

@end
