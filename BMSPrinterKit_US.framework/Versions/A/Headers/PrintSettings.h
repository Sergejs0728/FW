//
//  PrintSettings.h
//  BMSPrinterKit
//
//  Created by BMS on 9/11/12.
//  Copyright (c) 2012 Brother Mobile Solutions. All rights reserved.
//
// NOTE: This is the super-class that contains properties and methods common to each printer model.

#import <Foundation/Foundation.h>

//*********************************************************************
// PrintSettingsDelegate PROTOCOL
//
// Subclasses of PrintSettings are required to implement the following protocol.
@protocol PrintSettingsDelegate

//*** Methods
// SDK Users: These are primary API methods that you may want to use!
- (BOOL) validatePrintSettings;
- (void) loadPreferences;
- (void) savePreferences;

// These are only convenience methods, if needed. But, we need to assure that each
// subclass (and/or the superclass) implements them by adding them to the protocol.
- (NSString *)stringFromCurrentPaperType;
- (NSString *)stringFromCurrentPaperSize;
- (NSString *)stringFromCurrentFormFeedMode;
- (NSString *)stringFromCurrentExtraFeed;
- (NSString *)stringFromCurrentDensity;

// NOTE: IPAddress is already an NSString so don't need an API function for it.
- (NSString *)stringFromCurrentIPPort;
- (NSString *)stringFromCurrentScaleMode;
- (NSString *)stringFromCurrentOrientation;
- (NSString *)stringFromCurrentMargins;
- (NSString *)stringFromCurrentHalftone;
- (NSString *)stringFromCurrentThreshold;
- (NSString *)stringFromCurrentCompress;
- (NSString *)stringFromCurrentPrinterModel;

//*** Properties
// NOTE: If you wish to get/set any model-dependent properties, then you
// will need to use (or cast to) an object of the specific subclass.
// You will NOT be able to use an object of type "PrintSettings *" to
// access these properties; the compiler will give a "may not respond to" warning.
//
// For example 1:
//   PrintSettings *mySettings = [[PJ673PrintSettings alloc] init];
//   // NO!!
//   [mySettings setFormFeedMode:kFormFeedModeFixedPage];
//   // YES!!
//   [(PJ673PrintSettings *)mySettings setFormFeedMode:kFormFeedModeFixedPage];
//
// For example 2:
//   PJ673PrintSettings *mySettings = [[PJ673PrintSettings alloc] init];
//   [mySettings setFormFeedMode:kFormFeedModeFixedPage]; // OK!!
//
// Though many subclass  properties are common to all models,
// (e.g. paperType, formFeedMode, extraFeed, density), and we COULD put
// those into this protocol, this is not going to be possible when we
// get to "paperSize", since PJ-673 handles this very differently from
// RJ4/TD2 models. So, you will need a specific subclass for that anyway.
//
// Furthermore, if we were to put these into this protocol, then the
// PrintSettings superclass will be required to add these properties to
// the interface and synthesize them, though they will NEVER be used.
//
// Furthermore, since TD2 has properties that are specific for it, we
// cannot add those to this protocol, so again you will have to use
// (or cast to) a specific subclass to access these.
//
// As such, we will NOT add these 'common' model-specific properties
// to this protocol.
//
// NOTE: We did add the corresponding "stringFromCurrentXXX" methods
// above, because these can be accessed generically, even for PaperSize.

@end // PrintSettingsDelegate protocol
//*********************************************************************


//*********************************************************************
//*** NSUserDefaults
// These are the top-level keys. Each model will have its own "dictionary" of subkeys
// below this key, so all of the keys for a model will be self-contained.
#define keyPJ673PrintSettings @"PJ-673 Print Settings"
#define keyRJ4040PrintSettings @"RJ-4040 Print Settings"
#define keyTD2120NPrintSettings @"TD-2120N Print Settings"
#define keyTD2130NPrintSettings @"TD-2130N Print Settings"
#define keyRJ3050PrintSettings @"RJ-3050 Print Settings"
#define keyRJ3150PrintSettings @"RJ-3150 Print Settings"

// common properties from PrintSettings superclass
#define keyIPAddress @"IPAddress"
#define keyIPPort @"IPPort"
#define keyScaleMode @"Scale Mode"
#define keyOrientation @"Orientation"
#define keyHalftone @"Halftone"
#define keyThreshold @"Threshold"
#define keyCompressionOn @"Compress"
#define keyMarginTop @"MarginTop"
#define keyMarginLeft @"MarginLeft"
#define keyMarginBottom @"MarginBottom"
#define keyMarginRight @"MarginRight"

// common properties from each subclass
#define keyPaperType @"PaperType"
#define keyFormFeedMode @"FormFeedMode"
#define keyExtraFeed @"ExtraFeed"
#define keyDensity @"Density"

// Papersize is handled differently for different models.
// Some models (e.g. PJ-673) have a set of fixed sizes defined by constants.
#define keyPaperSize @"PaperSize"
// But, now we added Custom Size capability, so let's add some more keys
#define keyCustomPaperWidth @"CustomPaperWidth"
#define keyCustomPaperLength @"CustomPaperLength"
#define keyCustomPaperAlign @"CustomPaperAlign"


// For other models (RJ4040, RJ3050, RJ3150, TD2120N, TD2130N),
// PaperSize is broken up into the following components
#define keyPaperWidth @"PaperWidth"
#define keyPaperLength @"PaperLength"
#define keyPaperMarginWidth @"PaperMarginWidth"
#define keyPaperMarginLength @"PaperMarginLength"
#define keyLabelSpacing @"LabelSpacing"
#define keyMarkWidth @"MarkWidth"
#define keyMarkOffset @"MarkOffset"

// TD2 specific keys
#define keyPeelerEnabled @"Peeler Enabled"
#define keyInvert180Degrees @"Invert 180 Degrees"
//*********************************************************************


//*********************************************************************
//*** Constant Enumerations
// These are "common" to all printer models

typedef enum
{
    // Currently supported printer models
    kPrinterModelPJ673 = 1,
    kPrinterModelRJ4040,
    kPrinterModelTD2120N,
    kPrinterModelTD2130N,
    kPrinterModelRJ3050,
    kPrinterModelRJ3150
} PRINTERMODEL;

typedef enum
{
    kHalftoneThreshold = 1,
    kHalftoneDiffusion,
} HALFTONE;

typedef enum
{
    kScaleModeActualSize = 1,
    kScaleModeFitPage,
    kScaleModeFitPageAspect,
    kScaleModeFitWidthAspectAutoHeight,
} SCALEMODE;

typedef enum
{
    kOrientationPortrait = 1,
    kOrientationLandscape,
} ORIENTATION;

//*** The following enums are for properties defined in each subclass,
// i.e. they are model-specific properties (at least as concerns the subset of values supported).
// We define them here instead of in each subclass' header file so they can hold ALL of the
// possible values for ALL models to avoid "redefinition of enumerator" compiler errors if we
// attempt to use the same constant names in different enums within each subclass.
// *** Each printer model is likely to support only a SUBSET of these values. ***
// As such, we will handle limiting the available choices in the "setter" function for each
// property in the appropriate PrintSettings subclass for each model.
// Refer to the SDK Documentation for a list of values supported by each printer model.
typedef enum
{
    kPaperSizeLetter=1,
    kPaperSizeLegal,
    kPaperSizeA4,
    kPaperSizeCustom,
} PAPERSIZE;

typedef enum
{
    kPaperTypeRoll = 1, // unmarked roll, used by PJ, RJ, and TD
    kPaperTypeCutsheet, // PJ only
    kPaperTypePerfRoll, // marked roll, used by PJ, RJ, and TD
    kPaperTypePerfRollRetract, // marked roll, with forced retraction, used by PJ only
    kPaperTypeDieCutLabel, // label, used by RJ and TD only
} PAPERTYPE;


typedef enum
{
    kFormFeedModeNoFeed=1,
    kFormFeedModeFixedPage,
    kFormFeedModeEndOfPage,
    kFormFeedModeEndOfPageRetract,
} FORMFEEDMODE;

typedef enum
{
    kDensity0 = 0, // start this one at 0 rather than 1. "stringFromDensity" in particular requires this.
    kDensity1,
    kDensity2,
    kDensity3,
    kDensity4,
    kDensity5,
    kDensity6,
    kDensity7,
    kDensity8,
    kDensity9,
    kDensity10,
    kDensityUsePrinterSetting,
} DENSITY;
//*********************************************************************


//*********************************************************************
//*** struct definitions

// Arbitrarily limit the size (in dots) of each margin dimension to something rational.
// These values are used when setting and validating the margins.
#define MARGINDOTSMIN 0
#define MARGINDOTSMAX 1000

typedef struct 
{
    int top;
    int left;
    int bottom;
    int right;
} MARGINS, *pMARGINS;
//*********************************************************************


@interface PrintSettings : NSObject <PrintSettingsDelegate>
{
    // @protected: provide subclasses with access to readonly properties via ivars.
    // Because they are readonly, there is no "Setter" method available in the superclass.
    // The subclasses should be the only place where these properties are set.
    // But, they will be used in this superclass.
    // Users of this superclass can read the values if desired, but in most cases this
    // will not be necessary.
@protected
    PRINTERMODEL _printerModel;

}

// NOTE: This superclass contains properties that will be common to all subclasses.

// SDK Users: All of the properties below (and those in the PrintSettings subclasses)
// are settable by you to change the printer behavior.
// If you are not using the PrintSettingsViewController (either the SDK's or your own custom one),
// then you should set each of these properties programmatically to your desired setting.

@property (nonatomic, copy) NSString *IPAddress;
@property (nonatomic, assign) int IPPort;

@property (nonatomic, assign) SCALEMODE scaleMode;
@property (nonatomic, assign) ORIENTATION orientation;
@property (nonatomic, assign) MARGINS marginDots;

@property (nonatomic, assign) HALFTONE halftone;
// INCREASE this value to make printout darker. Decrease to make it lighter. Default is 128.
@property (nonatomic, assign) Byte threshold;
@property (nonatomic, assign) BOOL compress;

//*** NOTE: The following properties are NOT used for printing,
// but they are part of the PrintSettings superclass for convenience.

// For save/loadPreferences, each subclass MUST set this during init.
// NOTE: If desired, the caller can set this to be different from the default.
@property (nonatomic, retain) NSString *preferencesKey; 

//*** READONLY properties. Values will be set by the subclass. SDK User can NOT change it.
// printerModel may be useful if the subclass  (e.g. PJ673PrintSettings) object instance is
// stored inside the app using a superclass (e.g. PrintSettings) object reference.
// This can be used to perform model-specific behavior in your app, if necessary.
@property (readonly, nonatomic, assign) PRINTERMODEL printerModel;

// *** PrintSettingsDelegate protocol
// All subclasses of PrintSettings are required to implement these methods.
// validatePrintSettings - This function assures that all properties are in range
// and that there are no conflicting settings.
- (BOOL) validatePrintSettings;
- (void) loadPreferences;
- (void) savePreferences;

// These are only convenience methods, if needed. But, we need to assure that each
// subclass (and/or the superclass) implements them by adding them to the protocol.
- (NSString *)stringFromCurrentPaperType;
- (NSString *)stringFromCurrentPaperSize;
- (NSString *)stringFromCurrentFormFeedMode;
- (NSString *)stringFromCurrentExtraFeed;
- (NSString *)stringFromCurrentDensity;

// NOTE: IPAddress is already an NSString so don't need an API function for it.
- (NSString *)stringFromCurrentIPPort;
- (NSString *)stringFromCurrentScaleMode;
- (NSString *)stringFromCurrentOrientation;
- (NSString *)stringFromCurrentMargins;
- (NSString *)stringFromCurrentHalftone;
- (NSString *)stringFromCurrentThreshold;
- (NSString *)stringFromCurrentCompress;
- (NSString *)stringFromCurrentPrinterModel;


//*** generate strings from constants, for convenience
// NOTE: IPAddress is already an NSString so don't need an API function for it.
- (NSString *)stringFromIPPort: (int)ipPort;
- (NSString *)stringFromScaleMode:(SCALEMODE)scaleMode;
- (NSString *)stringFromOrientation:(ORIENTATION)orientation;
- (NSString *)stringFromMargins:(MARGINS)margins;
- (NSString *)stringFromHalftone: (HALFTONE)halftone;
- (NSString *)stringFromThreshold:(Byte)threshold;
- (NSString *)stringFromCompress: (BOOL)compress;
- (NSString *)stringFromPrinterModel: (PRINTERMODEL)model;
@end
