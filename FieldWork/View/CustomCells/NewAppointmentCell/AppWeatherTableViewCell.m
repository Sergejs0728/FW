//
//  AppWeatherTableViewCell.m
//  FieldWork
//
//  Created by Alexander on 08.08.16.
//
//

#import "AppWeatherTableViewCell.h"

@interface AppWeatherTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *sqFeetLabel;

@end

@implementation AppWeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) initializeWithTemperature:(NSString*) temperature windDirection:(NSString*) windDirection windSpeed:(NSString*) windSpeed andSqFeet:(NSString*) sqFeet{
    if ((windDirection)&&(windDirection.length>0)) {
        [_windDirectionLabel setText:windDirection];
    }
    else{
        [_windDirectionLabel setText:@"?"];
    }
    if ((temperature)&&(temperature.length>0)) {
        [_temperatureLabel setText:temperature];
    }
    else{
        [_temperatureLabel setText:@"?"];
    }
    if ((windSpeed)&&(windSpeed.length>0)) {
        [_windSpeedLabel setText:windSpeed];
    }
    else{
        [_windSpeedLabel setText:@"?"];
    }
    if ((sqFeet)&&(sqFeet.length>0)) {
        [_sqFeetLabel setText:sqFeet];
    }
    else{
        [_sqFeetLabel setText:@"?"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
