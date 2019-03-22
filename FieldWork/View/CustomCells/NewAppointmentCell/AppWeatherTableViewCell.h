//
//  AppWeatherTableViewCell.h
//  FieldWork
//
//  Created by Alexander on 08.08.16.
//
//

#import <UIKit/UIKit.h>

@interface AppWeatherTableViewCell : UITableViewCell
-(void) initializeWithTemperature:(NSString*) temperature windDirection:(NSString*) windDirection windSpeed:(NSString*) windSpeed andSqFeet:(NSString*) sqFeet;
@end
