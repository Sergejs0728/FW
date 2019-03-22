//
//  PrinterHelper.h
//  FieldWork
//
//  Created by Samir Kha on 16/02/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <BMSPrinterKit_US/BMSPrinterKit.h>
#import "UserSetting.h"

@protocol PrinterStatusDelegate <NSObject>

- (void) UpdateStatus:(NSString*) status;

@end


typedef void(^PrintStatusUpdate)(NSString* status);

@interface PrinterHelper : NSObject
{
    NSMutableDictionary *_errors;
    
    NSMutableArray *_printerList;

    
    NSString *_pdfPath;
    
    id<PrinterStatusDelegate> _printerStatusDelegate;
    
    PrintStatusUpdate _printStatusUpdateBlock;
}

@property (nonatomic, retain) PJ673PrintSettings *pj673PrintSettings;
@property (nonatomic, retain, readwrite) id<PrinterStatusDelegate> printerStatusDelegate;
@property (nonatomic, copy) PrintStatusUpdate printStatusUpdateBlock;

@property (nonatomic, readwrite, retain) NSMutableDictionary *errors;
+ (PrinterHelper *)Instance ;
- (void) printFile:(NSString*) path;

//-(void) printPDFUsingProgressView: (NSURL *)pdfURL;

//-(void)printPDFUsingBMSSDK: (NSURL *)pdfURL;

//- (void) printPDFWithNewBRPrinterSDK:(NSURL*) pdfURL;

//- (size_t)getPDFPageCount: (NSURL *)pdfURL;

//- (void)PrinterConnectionCheck;

//- (BOOL) isPrinterConnected;

@end
