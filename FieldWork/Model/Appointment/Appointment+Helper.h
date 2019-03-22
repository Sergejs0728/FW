//
//  Appointment+Helper.h
//  FWModel
//
//  Created by SamirMAC on 11/19/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "Appointment.h"

@interface Appointment (Helper)

- (NSMutableDictionary*) buildJson;

- (NSMutableDictionary*) newWordOrderJson;

- (NSMutableDictionary *)workPoolWordOrderJson;

- (void) downloadServiceReportWithBlock:(TaskCompleted)block;

@end
