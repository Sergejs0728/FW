//
//  PJ673PrintSettings.h
//  BMSPrinterKit
//
//  Created by BMS on 9/11/12.
//  Copyright (c) 2012 Brother Mobile Solutions. All rights reserved.
//

#import "PrintSettings.h"

@interface PJ673PrintSettings : PrintSettings <PrintSettingsDelegate>

// These constants below are provided for reference only. Don't change them!
#define PJ673_RESOLUTION_HORZ 300
#define PJ673_RESOLUTION_VERT 300

// Arbitrarily restrict extraFeed to 11" at 300 dpi. There is no reason to be larger.
#define PJ673_MAX_EXTRAFEEDDOTS (11*PJ673_RESOLUTION_VERT)

// NOTE: These custom MIN/MAX settings will be built into framework, so you can't change them.
// And, the setter functions will clip to these values. The reasons for these choices are described below.
// If you require something different for some reason, please contact Technical Support.
#define PJ673_CUSTOM_WIDTHDOTS_MIN 1200 // 4" due to likely skewing of narrower paper. Otherwise can be lower.
#define PJ673_CUSTOM_WIDTHDOTS_MAX 2550 // 8.5" = max paper width
#define PJ673_CUSTOM_LENGTHDOTS_MIN 600 // 2" to allow PerfRoll paper to print anything due to large unprintable area
#define PJ673_CUSTOM_LENGTHDOTS_MAX 30000 // 100", arbitrary


typedef enum
{
    kCustomPaperAlignLeft = 0,
    kCustomPaperAlignCenter,
} CUSTOMPAPERALIGN;

// SDK Users: All of the properties below (and those in the PrintSettings superclass)
// are settable by you to change the printer behavior.
// If you are not using the PrintSettingsViewController (either the SDK's or your own custom one),
// then you should set each of these properties programmatically to your desired setting.
@property (nonatomic, assign) PAPERSIZE paperSize;
@property (nonatomic, assign) PAPERTYPE paperType;
@property (nonatomic, assign) FORMFEEDMODE formFeedMode;
@property (nonatomic,assign) int extraFeed; // used with kFormFeedModeNoFeed only
@property (nonatomic, assign) DENSITY density;
// These 3 properties are used ONLY when paperSize is set to kPaperSizeCustom!
@property (nonatomic, assign) int customPaperWidthDots;
@property (nonatomic, assign) int customPaperLengthDots;
@property (nonatomic, assign) CUSTOMPAPERALIGN customPaperAlign;

// *** PrintSettingsDelegate protocol
// All subclasses of PrintSettings are required to implement these methods.
// validatePrintSettings - This function assures that all properties are in range
// and that there are no conflicting settings.
- (BOOL) validatePrintSettings;
- (void) loadPreferences;
- (void) savePreferences;
// generate strings from CURRENT settings, for convenience
// This is part of the PrintSettingsDelegateProtocol too.
- (NSString *)stringFromCurrentPaperType;
- (NSString *)stringFromCurrentPaperSize;
- (NSString *)stringFromCurrentFormFeedMode;
- (NSString *)stringFromCurrentExtraFeed;
- (NSString *)stringFromCurrentDensity;


// generate strings from constants, for convenience
- (NSString *)stringFromPaperType: (PAPERTYPE)paperType;
- (NSString *)stringFromPaperSize: (PAPERSIZE)paperSize;
- (NSString *)stringFromFormFeedMode: (FORMFEEDMODE)ffmode;
- (NSString *)stringFromExtraFeed:(int)extraFeed;
- (NSString *)stringFromDensity: (DENSITY)density;


@end
