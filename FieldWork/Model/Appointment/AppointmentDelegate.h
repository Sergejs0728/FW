//
//  AppointmentDelegate.h
//  FieldWork
//
//  Created by SAMCOM on 26/11/15.
//
//

#import <Foundation/Foundation.h>

@protocol AppointmentDelegate <NSObject>

- (void) AppointmentSavedSuccessfully;
- (void) AppointmentSaveFailedWithError:(NSString*) error;
@end
