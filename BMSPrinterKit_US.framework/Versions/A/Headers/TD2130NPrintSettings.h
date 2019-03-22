//
//  TD2130NPrintSettings.h
//  BMSPrinterKit
//
//  Created by BMS on 9/18/13.
//  Copyright (c) 2013 Brother Mobile Solutions. All rights reserved.
//

#import "GenericMobileLabelModelPrintSettings.h"


@interface TD2130NPrintSettings : GenericMobileLabelModelPrintSettings <PrintSettingsDelegate>

// These definitions are provided for information only. DO NOT MODIFY!
// spec section 2.3.1 Resolution
#define TD2130N_RESOLUTION_HORZ 300
#define TD2130N_RESOLUTION_VERT 300
// spec section 2.3.5 Raster Line
#define TD2130N_HEADSIZEDOTS 672
// not in spec. Used Windows Printer Driver as reference.
// NOTE: MAXPAPERWIDTH can exceed HEADSIZEDOTS!!
#define TD2130N_MIN_PAPERWIDTHDOTS (0.47F * TD2130N_RESOLUTION_HORZ) // 141
#define TD2130N_MAX_PAPERWIDTHDOTS (2.48F * TD2130N_RESOLUTION_VERT) // 744
// spec section 2.3.4 Maximum and Minimum Lengths
#define TD2130N_MIN_PAPERLENGTHDOTS 142
#define TD2130N_MAX_PAPERLENGTHDOTS 11811
// spec section 2.3.3 Feed Amount
// IMPORTANT NOTE: For LABEL papertype ONLY, we allow the MIN marginlengthdots to be set to 0.
// That is, this MIN value here is ignored when papertype = label is specified.
// Consider the case of a 1.0x0.5" label. A min margin of 0.12" will take up half of the printable length!!
// This is why we will allow the margin to be set to 0 in this case.
// Beware that some labels might clip the top if this is set to 0. But, other settings can be tweaked to
// make it work (such as by setting a larger paperlength and setting the top margin to non-zero.)
#define TD2130N_MIN_MARGINLENGTHDOTS 35
#define TD2130N_MAX_MARGINLENGTHDOTS 1500
// Arbitrarily restrict extraFeed to 11" at 203 dpi. There is no reason to be larger.
#define TD2130N_MAX_EXTRAFEEDDOTS (11*TD2130N_RESOLUTION_VERT)

//*** IMPORTANT ***
// SDK Users:
// You should NEVER instantiate an object of the GenericMobileLabelModelPrintSettings superclass.
// Instead, you should instantiate one of the model-specific subclasses (i.e. TD2130NPrintSettings).
//
// For a list of important properties in the settings that your application needs to set,
// refer to the GenericMobileLabelModelPrintSettings superclass.

// SDK Designers:
// The GenericMobileLabelModelPrintSettings superclass handles all the important work.
// This subclass only needs to provide the model-specific data to the generic class(es).

//*** ADDITIONAL PROPERTIES not handled by GenericMobileLabelModelPrintSettings
@property (nonatomic, assign) BOOL peelerEnabled;
@property (nonatomic, assign) BOOL invert180degrees;

@end
