//
//  FWRequest.h
//  FWModel
//
//  Created by SamirMAC on 11/8/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWRequestDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import <Crashlytics/Crashlytics.h>


typedef enum {
    GET = 1,
    POST = 2,
    PUT = 3,
    DELETE = 4,
    PATCH = 5,
}RequestMethod;

@class FWRequest;

typedef void (^UploadFileCompletionBlock)(FWRequest *request);

typedef void (^DownloadFileCompletionBlock)(FWRequest *request);

typedef void (^FWResponseBlock)(BOOL success, FWRequest *request);

@interface FWRequest : NSObject
{
    id<FWRequestDelegate> _delegate;
    
    NSString *_urlPart;
    
    NSMutableDictionary *_postParameters;
    
    RequestMethod _methodType;
    
    NSString *_postData;
    
    id _serverData;
    
    NSString *_rawResponse;
    
    BOOL _IsSuccess;
    
    NSInteger _StatusCode;
    
    NSString *_Tag;
    
    NSError *_error;
    
}
@property (nonatomic, retain, readwrite) NSString *postData;

@property (nonatomic, retain, readwrite) id serverData;

@property (nonatomic, retain, readwrite) NSString *rawResponse;

@property (nonatomic, assign) NSInteger StatusCode;

@property (nonatomic, assign) BOOL IsSuccess;

@property (nonatomic, retain, readwrite) NSString *Tag;

@property (nonatomic, retain, readwrite) NSError *error;

@property (nonatomic, assign) RequestMethod methodType;

@property (readwrite, copy) FWResponseBlock responseBlock;


+ (instancetype)requestWithURLPart:(NSString *)url_part
                            method:(RequestMethod)method
                              dict:(NSDictionary *)dict
                             block:(FWResponseBlock)block;

- (id) initWithUrl:(NSString*) urlString andDelegate:(id<FWRequestDelegate>) del;

- (id) initWithUrl:(NSString*) urlString andDelegate:(id<FWRequestDelegate>) del andMethod:(RequestMethod) method;

- (void)setParameter:(id)parameter forKey:(NSString *)key;

- (void) setPostParameters:(NSMutableDictionary*)dict;

- (void)startRequest;

- (NSString *)errorMessageFromError:(NSError *)error;

- (void) downloadPlan:(NSString*)file_url saveToFilePath:(NSString*)path withCompletionBlock:(DownloadFileCompletionBlock)block;

+ (void) downloadFile:(NSString*)file_url saveToFilePath:(NSString*)path withCompletionBlock:(DownloadFileCompletionBlock)block;

+ (void) uploadFile:(NSString*)file_url file_name:(NSString*)file_name withFormaData:(NSMutableDictionary*)form_data onServerUrl:(NSString*)url withMethod:(RequestMethod)method withCompletionBlock:(UploadFileCompletionBlock)block;

+ (void) uploadPDFFile:(NSString*)file_url file_name:(NSString*)file_name formId:(NSString*) formId withFormaData:(NSMutableDictionary*)form_data onServerUrl:(NSString*)url withMethod:(RequestMethod)method withCompletionBlock:(UploadFileCompletionBlock)block;

+ (void) uploadFiles:(NSDictionary*)files withFormaData:(NSMutableDictionary*)form_data onServerUrl:(NSString*)url withMethod:(RequestMethod)method withCompletionBlock:(UploadFileCompletionBlock)block;

+ (void)sendReportWithEvent:(NSString *)name attributes:(NSDictionary*)attributes;

@end


