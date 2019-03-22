//
//  PrinterHelper.m
//  FieldWork
//
//  Created by Samir Kha on 16/02/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#define PDF_FILEEXT @"pdf"
#define PDF_FILENAME_PJ673 @"Workorder-PJ673"

#import "PrinterHelper.h"

static PrinterHelper *singleton = nil;

@implementation PrinterHelper

@synthesize errors = _errors;
@synthesize printerStatusDelegate = _printerStatusDelegate;
@synthesize pj673PrintSettings = _pj673PrintSettings;
@synthesize printStatusUpdateBlock = _printStatusUpdateBlock;


+ (PrinterHelper *)Instance {
    if (singleton == nil)
        singleton = [[PrinterHelper alloc] init];
    
    return singleton;
}


- (void) updateStatus:(NSString*) status
{
    if (_printerStatusDelegate && [_printerStatusDelegate respondsToSelector:@selector(UpdateStatus:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_printerStatusDelegate UpdateStatus:status];
        });
    }
    if (self.printStatusUpdateBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.printStatusUpdateBlock(status);
        });
    }
}

- (BOOL)isPrinterConnected {
    int iRet;
    
    BMSPrinterDriver *printer = [[BMSPrinterDriver alloc] initWithModel:kPrinterModelPJ673 printSettings:_pj673PrintSettings];
    
    iRet = ([printer openWIFIChannel:[UserSetting getIpAddress]
                             timeout:5]);
    
    if (iRet != RET_TRUE)
    {
        return NO;
    }
    [printer closeWIFIChannel];
    return YES;
}

- (void)printFile:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        NSLog(@"File does not exist!");
    _pdfPath = path;
//    NSURL *temp = [NSURL fileURLWithPath:path];
//    NSLog(@"%@", temp);
//    size_t pdfPageCount = [self getPDFPageCount:temp];
    NSString *ip = [UserSetting getIpAddress];
    if (ip == nil || ip.length <= 0) {
        [self updateStatus:@""];
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Error"                                                                                                message:@"Please add IP address of printer from setting." delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alert1 show];
        return;
    }
    
     _pj673PrintSettings = [[PJ673PrintSettings alloc] init];
     [_pj673PrintSettings loadPreferences];
    _pj673PrintSettings.IPAddress = [UserSetting getIpAddress];
    
    if ([self isPrinterConnected] == YES)
    {
        NSLog(@"Printer Connected");
        NSLog(@"FilePath : %@", _pdfPath);
        NSURL *pdfURL = [NSURL fileURLWithPath:_pdfPath];
        [self updateStatus:@"Printing..."];
        dispatch_queue_t backgroundQueue;
        backgroundQueue = dispatch_queue_create("com.samcom.PrinterDemo", NULL);
        dispatch_async(backgroundQueue, ^{
            // If the Advanced setting is set, print an array of PDF files using the new API in SDK1.1
            
            [self printPDFUsingBMSSDK:pdfURL]; // demonstrates printing a single PDF file
            
            // This is typically how you will want to handle this dispatch_async call
            // so you can know when printing is completed and handle it accordingly.
            // If you don't care, then the following is optional.
            
            // launch callback function on main thread when printing has completed.
            dispatch_async(dispatch_get_main_queue(), ^{
                [self printingCompleted];
            });
            
        });
    }else{
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Please varify the printer connection. Printer is not available."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             [alert1 show];
             // Your code that presents the alert view(s)
         }];
    }
    
    
    
   
}


-(void)printPDFUsingBMSSDK: (NSURL *)pdfURL
{
    NSLog(@"printPDFUsingBMSSDK - PDF URL : %@", pdfURL);
    size_t pdfPageCount = [self getPDFPageCount:pdfURL];
    
    NSLog(@"Starting Printing : %zu pages", pdfPageCount);

    
    if (pdfPageCount > 0)
    {
        int ret;
        
        //_pj673PrintSettings.scaleMode = kScaleModeActualSize;
        
        if ([_pj673PrintSettings validatePrintSettings] == NO) {
            NSLog(@"Print Settings are not validated");
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *theMessage = [NSString stringWithFormat:@"Printer settings are not validated -- validatePrintSettings."];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:theMessage
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            });
            return;
        }
        
        
        BMSPrinterDriver *printer = [[BMSPrinterDriver alloc]
                                     initWithModel:kPrinterModelPJ673
                                     printSettings:_pj673PrintSettings];
        NSLog(@"Printer Initializing completed");
        // print with NO progress, this is ALWAYS a BLOCKING call
        // ***NOTE: Assure timeout is large enough to print any particular page
        // UPDATE: in SDK 1.1, it is now OK to set a smaller timeout, and this will apply SEPARATELY to
        // (a) Opening the channel and (b) sending a band of data, which will likely be less than the size of the entire page.
        // ***NOTE: Specify page range if desired in firstPage/lastPage.
        // As written here, this will print ALL pages.
        // ***NOTE: If printing multiple copies of a multipage PDF, the collate parameter changes the order of page printing.
        // if collate=YES, prints all pages of the PDF, then repeats for each copy.
        // if collate=NO, prints # copies of a page, then repeats for each page of PDF.
        
        ret = [printer printPDFFilePathURL:pdfURL
                                 firstPage:1
                                  lastPage:(int)pdfPageCount
                                   timeout:30 // NOTE: now setting smaller timeout with SDK 1.1
                                    copies:1
                                   collate:NO];
        NSLog(@"Printing Completed with Status : %d", ret);
        //***** Optional: Show alert message in case of error
        if (ret != RET_TRUE)
        {
            // show alert on MAIN thread if there is an error, in case we are in a background thread here (i.e. non-blocking case)
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *theMessage = [NSString stringWithFormat:@"An error occurred in Printing... \n Error code = %d", ret];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:theMessage
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            });
            
        }
        
    }
    
}

-(void)printingCompleted
{
    [self updateStatus:@""];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Printing Completed"
//                                                    message:@"The dispatch_async call to print the data has completed. This is the callback method that you can implement if you want to handle this condition."
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];

}


// utility method to determine how many pages the PDF file contains.
- (size_t)getPDFPageCount: (NSURL *)pdfURL
{
    
    // Open PDF File to get page count
    CGPDFDocumentRef pdfDocRef;
    size_t pdfPageCount=0;
//    pdfDocRef = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfURL);
    CGDataProviderRef dref =  CGDataProviderCreateWithURL((CFURLRef) pdfURL);
    
    //pdfDocRef = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
    pdfDocRef = CGPDFDocumentCreateWithProvider(dref);
    if (pdfDocRef != NULL)
    {
        pdfPageCount = CGPDFDocumentGetNumberOfPages(pdfDocRef);
        CGPDFDocumentRelease(pdfDocRef);
    }
    
    return pdfPageCount;
}

@end
