//
//  RJ4040PrintSettings.h
//  BMSPrinterKit
//
//  Created by BMS on 9/12/12.
//  Copyright (c) 2012 Brother Mobile Solutions. All rights reserved.
//

#import "GenericMobileLabelModelPrintSettings.h"


@interface RJ4040PrintSettings : GenericMobileLabelModelPrintSettings <PrintSettingsDelegate>

// These definitions are provided for information only. DO NOT MODIFY!
// spec section 2.3.1 Resolution
#define RJ4040_RESOLUTION_HORZ 203
#define RJ4040_RESOLUTION_VERT 203
// spec section 2.3.5 Raster Line
#define RJ4040_HEADSIZEDOTS 832
// not in spec. Used Windows Printer Driver as reference.
// NOTE: MAXPAPERWIDTH does NOT exceed HEADSIZEDOTS!!
#define RJ4040_MIN_PAPERWIDTHDOTS (0.47F * RJ4040_RESOLUTION_HORZ) // 95, was using 203 in 0.9 SDK
#define RJ4040_MAX_PAPERWIDTHDOTS 832 // NOTE: WinDriver allows 4.09", which is ~832.
// spec section 2.3.4 Maximum and Minimum Lengths
#define RJ4040_MIN_PAPERLENGTHDOTS 203 // NOTE: spec says 204 dots, but 203 seems OK.
#define RJ4040_MAX_PAPERLENGTHDOTS 24094
// spec section 2.3.3 Feed Amount
// IMPORTANT NOTE: For LABEL papertype ONLY, we allow the MIN marginlengthdots to be set to 0.
// That is, this MIN value here is ignored when papertype = label is specified.
// Consider the case of a 1.0x0.5" label. A min margin of 0.12" will take up half of the printable length!!
// This is why we will allow the margin to be set to 0 in this case.
// Beware that some labels might clip the top if this is set to 0. But, other settings can be tweaked to
// make it work (such as by setting a larger paperlength and setting the top margin to non-zero.)
#define RJ4040_MIN_MARGINLENGTHDOTS 24
#define RJ4040_MAX_MARGINLENGTHDOTS 1020 // NOTE: was using 1015 in 0.9 SDK
// Arbitrarily restrict extraFeed to 11" at 203 dpi. There is no reason to be larger.
#define RJ4040_MAX_EXTRAFEEDDOTS (11*RJ4040_RESOLUTION_VERT)

//*** IMPORTANT ***
// SDK Users:
// You should NEVER instantiate an object of the GenericMobileLabelModelPrintSettings class.
// Instead, you should instantiate one of the model-specific subclasses (i.e. RJ4040PrintSettings).
//
// For a list of important properties in the settings that your application needs to set,
// refer to the GenericMobileLabelModelPrintSettings superclass.

// SDK Designers:
// The GenericMobileLabelModelPrintSettings class handles all the important work.
// This subclass only needs to provide the model-specific data to the generic class.

@end
