//
//  Appointment+Mapping.h
//  FWModel
//
//  Created by SamirMAC on 11/16/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "Appointment.h"


@interface Appointment (Mapping)

+ (FEMMapping*) defaultMapping;

+ (FEMMapping*) reverseMappingWorkOrder;

+ (FEMMapping *) reverseMappingNewWorkOrder;

+ (FEMMapping *)reverseMappingInvoice;

+ (FEMMapping *)reverseMappingPayment;

+ (FEMMapping*) reverseMappingLineItems;

@end
