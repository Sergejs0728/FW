//
//  RJ3050PrintSettings.h
//  BMSPrinterKit
//
//  Created by BMS on 9/12/12.
//  Copyright (c) 2012 Brother Mobile Solutions. All rights reserved.
//

#import "GenericMobileLabelModelPrintSettings.h"


@interface RJ3050PrintSettings : GenericMobileLabelModelPrintSettings <PrintSettingsDelegate>

// These definitions are provided for information only. DO NOT MODIFY!
// spec section 4.3.1 Resolution
#define RJ3050_RESOLUTION_HORZ 203
#define RJ3050_RESOLUTION_VERT 203
// spec section 4.3.6 Raster Line
#define RJ3050_HEADSIZEDOTS 576
// NOT in spec. *** Used Windows Printer Driver as reference ***
// NOTE: MAXPAPERWIDTH DOES exceed HEADSIZEDOTS!!
#define RJ3050_MIN_PAPERWIDTHDOTS (0.47F * RJ3050_RESOLUTION_HORZ) // 95
#define RJ3050_MAX_PAPERWIDTHDOTS (3.15F * RJ3050_RESOLUTION_HORZ) // 639.
// spec section 4.3.4 Maximum and Minimum Lengths
#define RJ3050_MIN_PAPERLENGTHDOTS 96
#define RJ3050_MAX_PAPERLENGTHDOTS 7992
// spec section 4.3.3 Feed Amount
// IMPORTANT NOTE: For LABEL papertype ONLY, we allow the MIN marginlengthdots to be set to 0.
// That is, this MIN value here is ignored when papertype = label is specified.
// Consider the case of a 1.0x0.5" label. A min margin of 0.12" will take up half of the printable length!!
// This is why we will allow the margin to be set to 0 in this case.
// Beware that some labels might clip the top if this is set to 0. But, other settings can be tweaked to
// make it work (such as by setting a larger paperlength and setting the top margin to non-zero.)
#define RJ3050_MIN_MARGINLENGTHDOTS 24
#define RJ3050_MAX_MARGINLENGTHDOTS 1015
// Arbitrarily restrict extraFeed to 11" at 203 dpi. There is no reason to be larger.
#define RJ3050_MAX_EXTRAFEEDDOTS (11*RJ3050_RESOLUTION_VERT)

//*** IMPORTANT ***
// SDK Users:
// You should NEVER instantiate an object of the GenericMobileLabelModelPrintSettings class.
// Instead, you should instantiate one of the model-specific subclasses (i.e. RJ3050PrintSettings).
//
// For a list of important properties in the settings that your application needs to set,
// refer to the GenericMobileLabelModelPrintSettings superclass.

// SDK Designers:
// The GenericMobileLabelModelPrintSettings class handles all the important work.
// This subclass only needs to provide the model-specific data to the generic class.

//*** ADDITIONAL PROPERTIES not handled by GenericMobileLabelModelPrintSettings
@property (nonatomic, assign) BOOL invert180degrees;

@end
