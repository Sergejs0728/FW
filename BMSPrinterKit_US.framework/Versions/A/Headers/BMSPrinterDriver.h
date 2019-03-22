//
//  BMSPrinterDriver.h
//  BMSPrinterKit
//
//  Created by BMS on 10/2/12.
//  Copyright (c) 2012 Brother Mobile Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#import "PrintSettings.h"



// Used to assure that the CGBitmap is 32-pixel aligned
// NOTE: Need to cast the division result to (int) in case a float type
// is passed in for x so we get the expected truncation.
#define ALIGN32(x) ((int)((x+31)/32) * 32)

//*******************************************
//*** API Function Possible Return Codes ***
// NOTE: Some API functions will return values defined in BRPtouchPrinter.h, 
// such as RET_TRUE, RET_FALSE, ERROR_TIMEOUT, etc.
// For clarity, the return codes defined in this module will begin at -1000.

#define RET_PARAMETER_ERROR         -1000
#define RET_FILEPATHURL_ERROR       -1001
#define RET_PDFPAGE_ERROR           -1002
#define RET_WIFICHANNEL_NOTOPEN     -1003
#define RET_WIFICHANNEL_WRITEERROR  -1004
#define RET_WIFICHANNEL_CREATEERROR -1005
#define RET_PRINTSETTINGS_ERROR     -1006
#define RET_PARENTVIEW_ERROR        -1007
#define RET_DATABUFFER_ERROR        -1008
#define RET_WIFICHANNEL_READERROR   -1009
//*******************************************


@interface BMSPrinterDriver : NSObject
{

}

//******** Class Properties ********
@property (nonatomic, assign) PRINTERMODEL printerModel;
@property (nonatomic, retain) PrintSettings *printSettings;

// Caller MUST set these as appropriate when printing multiple pages.
@property (nonatomic, assign) BOOL isFirstPage;
@property (nonatomic, assign) BOOL isLastPage;


//******** Class Initializers ********
- (id) initWithModel:(PRINTERMODEL)theModel printSettings:(PrintSettings *)printSettings;


//******** MAIN API FUNCTIONS ********

// *** BRPtouchPrinter function WRAPPERS ***
// These wrappers are provided for convenience only. In some cases, you may wish to use
// BRPtouchPrinter functions after using the BMSPrinterDriver class to generate the print
// data. These wrappers allow you to do this without instantiating a BRPtouchPrinter object.

// wrappers for sendFile and sendFileEx
- (int) sendFile: (NSString *)filePath toIPAddress:(NSString *)IPAddress timeout:(int)nTimeout;
- (int) sendFileEx: (NSString *)filePath toIPAddress:(NSString *)IPAddress timeout:(int)nTimeout;

// wrappers for sendData and sendDataEx.
- (int) sendData: (NSData *)printData toIPAddress:(NSString *)IPAddress timeout:(int)nTimeout;
- (int) sendDataEx: (NSData *)printData toIPAddress:(NSString *)IPAddress timeout:(int)nTimeout;


// note: a wrapper for printImage is NOT provided


//******* BMS new functionality functions **********

//***** Misc Utilities
- (CGRect) getPrintableRectFromCurrentSettings;
- (CGRect) getPaperRectFromCurrentSettings;

//***** FILE Printing Functions (see also sendFile and sendFileEx above)
- (int) sendFileWithProgressView:(NSURL *)filePathURL
                     toIPAddress:(NSString *)IPAddress
                 usingParentView:(id)parentViewController;

//***** PDF Printing Functions (see also Manual APIs below)
// retrieve the print data to send in any way that you prefer
- (int) generatePrintData:(NSMutableData *)printData
           fromPDFPageRef:(CGPDFPageRef) pdfPageRef;

// send PDF file without a ProgresView
// This is a BLOCKING function only
// NOTE: SDK 1.1.0 changed this prototype to add "copies" and "collate" parameters.
// NOTE: The "collate" parameter value only matters when printing multiple copies of a multi-page PDF file.
- (int) printPDFFilePathURL:(NSURL *)filePathURL
                  firstPage:(int)firstPage 
                   lastPage:(int)lastPage
                    timeout:(CFTimeInterval)nTimeout
                     copies:(int)copies
                    collate:(BOOL)bCollate;

// send PDF file with a MODAL ProgressView
- (int) printPDFFileWithProgressView:(NSURL *)filePathURL
                            firstPage:(int)firstPage 
                             lastPage:(int)lastPage
                      usingParentView:(id)parentViewController;

// New API in SDK 1.1
// Print an ARRAY of NSURLs that reference a PDF file.
// All pages from EACH PDF file will be printed.
// NOTE: The same printSettings will apply to EACH PDF file in the array.
-(int) printPDFURLArray:(NSArray *)array
                timeout:(CFTimeInterval)nTimeout;

//***** Image Printing Functions (see also Manual APIs below)
// print Image with a MODAL ProgressView
- (int) printCGImageRefWithProgressView:(CGImageRef)imageRef
                        usingParentView:(id)parentViewController;

// retrieve the print data to send in any way that you prefer
- (int) generatePrintData:(NSMutableData *)printData
           fromCGImageRef:(CGImageRef)imageRef;

// print Image blocking or non-blocking, without a ProgressView.
// NOTE: The "blocking" parameter determines whether "sendData" or "sendDataEx" method is used to send the data.
// Refer to documentation for those APIs for additional info.
// WARNING: Do NOT use this API to send more than 1 image back-to-back.
// For a "simple" API that allows this, see printImageURLArray or sendCGImageRefToWIFIChannel below.
- (int) printCGImageRef:(CGImageRef)imageRef
               blocking:(BOOL)blocking
                timeout:(CFTimeInterval)nTimeout;

// New API in SDK 1.1 to allow printing multiple copies of a single image.
// WARNING: Do NOT use this API to send more than 1 image back-to-back.
// For a "simple" API that allows this, see printImageURLArray or sendCGImageRefToWIFIChannel below.
- (int) printCGImageRef:(CGImageRef)imageRef
                timeout:(CFTimeInterval)nTimeout
                 copies:(int)copies;

// New API in SDK 1.1
// Print an ARRAY of NSURLs that reference an IMAGE file, e.g. JPG, PNG, etc
// NOTE: The same printSettings will apply to EACH image in the array.
-(int) printImageURLArray:(NSArray *)array
                  timeout:(CFTimeInterval)nTimeout;

//***** Manual Control of WIFI Channel. These all work together.
// You MUST use openWIFIChannel, one of the other APIs, then closeWIFIChannel.
// Advantages to using the Manual APIs compared to the simpler APIs:
// 1. Sending data this way allows you to send data in bands and display your own progress indicator.
// 2. You can use different timeouts for openWIFIChannel and sending the data.

// These were the original 3 APIs for Manual Mode:
- (int) openWIFIChannel:(NSString *)IPAddress
                timeout:(CFTimeInterval)nTimeout;

// This is the best API to use if you want to make your own progress indicator.
- (int) sendDataToWIFIChannel:(const uint8_t *)data
                       length:(int)length
                      timeout:(CFTimeInterval)nTimeout
                    errorCode:(int *)pErrorCode;

// This must be called when finished with the WIFI channel opened by openWIFIChannel
- (void) closeWIFIChannel;

//** New Manual API in SDK 1.0. It is both a "simple API" and a "manual API".
// You must use openWIFIChannel and closeWIFIChannel with this method.
// This method will allow sending more than 1 image back-to-back to an open WIFI channel.
- (int) sendCGImageRefToWIFIChannel:(CGImageRef)imageRef
                            timeout:(CFTimeInterval)nTimeout;

//** New Manual APIs at SDK 1.1:
// Used for RJ4 MCR reader applications ONLY!!
- (int) readDataFromWIFIChannel:(uint8_t *)buffer
                      maxLength:(int)maxLength
                      errorCode:(int *)pErrorCode;

// similar to sendDataToWIFIChannel, but easier to use since you don't have to manage the buffer.
// However, it is not as useful if you wish to make your own progress indicator.
// NOTE: The data will actually be sent in bands, and the timeout parameter will apply to each band separately.
// So, you don't have to specify a timeout large enough to print the entire data stream.
// Many of the other "simple" APIs are now using this API.
- (int) sendNSDataToWIFIChannel:(NSData *)data
                        timeout:(CFTimeInterval)nTimeout;

// simple API to send a PDF file URL to already open WIFI channel. Again, not useful for progress indicator.
// But, you can use this to print more than 1 PDF file back-to-back.
- (int) sendPDFFilePathURLToWIFIChannel:(NSURL *)filePathURL
                                timeout:(CFTimeInterval)nTimeout;


@end

/////////////////////////////////////////////////////////////////////////////
// This defines the DataControllerProtocol that MUST be used for developing 
// new printer drivers for a printer model. The DataControllers are used to 
// generate model-specific print data based on the current printSettings.
@protocol DataControllerProtocol <NSObject>
// everything is required!
@required

// Properties
@property (nonatomic, assign) BOOL isFirstPage;
@property (nonatomic, assign) BOOL isLastPage;
@property (nonatomic, retain) PrintSettings *printSettings;

// Methods
- (CGRect) getPaperRectFromCurrentSettings;
- (CGRect) getPrintableRectFromCurrentSettings;
- (BOOL) generatePrintData: (NSMutableData *)printData fromCGContextRef: (CGContextRef) context;
@end
/////////////////////////////////////////////////////////////////////////////
