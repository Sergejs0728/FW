
//
    //  FWRequest.m
    //  FWModel
    //
    //  Created by SamirMAC on 11/8/15.
    //  Copyright (c) 2015 SamirMAC. All rights reserved.
    //

#import "FWRequest.h"
#import "AppointmentManager.h"
#import "FWRequestManager.h"
#import "NSString+Extension.h"

@interface FWRequest()
@property (nonatomic) NSInteger failCounter;
@end

@implementation FWRequest

@synthesize postData = _postData;
@synthesize serverData = _serverData;
@synthesize rawResponse = _rawResponse;
@synthesize StatusCode = _StatusCode;
@synthesize IsSuccess = _IsSuccess;
@synthesize Tag = _Tag;
@synthesize error = _error;
@synthesize methodType = _methodType;


+ (instancetype)requestWithURLPart:(NSString *)url_part
                            method:(RequestMethod)method
                              dict:(NSDictionary *)dict
                             block:(FWResponseBlock)block {
    FWRequest *request = [FWRequest new];
    
    request->_methodType = method;
    request.responseBlock = block;
    request.failCounter=0;
    request->_urlPart = url_part;
    if (dict) {
        request->_postParameters = [dict mutableCopy];
    } else {
        request->_postParameters = [[NSMutableDictionary alloc] init];
    }
    [request startRequest];
    return request;
}

- (id)initWithUrl:(NSString *)urlString andDelegate:(id<FWRequestDelegate>)del {
    return [self initWithUrl:urlString andDelegate:del andMethod:GET];
}

- (id)initWithUrl:(NSString *)urlString andDelegate:(id<FWRequestDelegate>)del andMethod:(RequestMethod)method {
    self = [super init];
    
    if (self)
        {
        _urlPart = urlString;
        _methodType = method;
        _postParameters = [[NSMutableDictionary alloc] init];
        _delegate = del;
        }
    
    return self;
}

- (void)setParameter:(id)parameter forKey:(NSString *)key {
    [_postParameters setObject:parameter forKey:key];
}

- (void) setPostParameters:(NSMutableDictionary*)dict
{
    _postParameters = dict;
}

- (void)startRequest
{
    FieldWorkAccount *account = [AccountManager Instance].activeAccount;
    NSString *api_key = account.api_key;
    if ((![self.Tag isEqual:LOAD_APPONTMENT_DATEWISE])&&(![self.Tag isEqual:LOAD_APPOINTMENTS_ONLYWORKPOOL])&&(![self.Tag isEqual:LOAD_ESTIMATE_DATEWISE])) {
        if ([_urlPart rangeOfString:API_GET_KEY].location != NSNotFound && ![_urlPart hasPrefix:FW_API_VERSION]) {
            _urlPart = [NSString stringWithFormat:@"%@%@", FW_API_VERSION ,_urlPart];
        }else{
            NSString *apikey_query = [NSString stringWithFormat:@"api_key=%@", api_key];
            if (![_urlPart hasPrefix:FW_API_VERSION]) {
                _urlPart = [NSString stringWithFormat:@"%@%@", FW_API_VERSION ,_urlPart];
            }
            if ([_urlPart rangeOfString:apikey_query].location == NSNotFound) {
                _urlPart = [_urlPart URLStringByAppendingQueryString:apikey_query];
            }
            
        }
    }
    if ((([self.Tag isEqual:API_WORK_ORDERS] || [self.Tag isEqual:REFRESH_APPOINTMENTS_FORCEFULLY]) && _methodType == GET) && ([_urlPart rangeOfString:@"start_date"].location == NSNotFound)) {
        _urlPart = [_urlPart URLStringByAppendingQueryString:[NSString stringWithFormat:@"with_workpool=true&start_date=%@&end_date=%@",[NSDate systemDateWithFormatter:MMDDYYYY AddingDay:-2],[NSDate systemDateWithFormatter:MMDDYYYY AddingDay:4]]];
    }
    if (_methodType == GET) {
        [[[FWRequestManager Instance] requestManager] GET:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
            _serverData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = YES;
            [self requestSuccess];
        } failure:^void(NSURLSessionDataTask * task, NSError *error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.serverData = nil;
            [self requestFailedWithError:error];
        }];
    } else if (_methodType == POST){
        [[[FWRequestManager Instance] requestManager] POST:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
            _serverData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = YES;
            [self requestSuccess];
        } failure:^void(NSURLSessionDataTask * task, NSError * error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.serverData = nil;
            [self requestFailedWithError:error];
        }];
    } else if (_methodType == PUT) {
        [[[FWRequestManager Instance] requestManager] PUT:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
            _serverData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = YES;
            [self requestSuccess];
        } failure:^void(NSURLSessionDataTask * task, NSError * error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.serverData = nil;
            [self requestFailedWithError:error];
        }];
    }else if (_methodType == DELETE) {
        [[[FWRequestManager Instance] requestManager] DELETE:_urlPart parameters:_postParameters success:^void(NSURLSessionDataTask * task, id responseObject) {
            _serverData = responseObject;
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = YES;
            [self requestSuccess];
        } failure:^void(NSURLSessionDataTask * task, NSError *error) {
            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
            self.StatusCode = r.statusCode;
            self.IsSuccess = NO;
            self.serverData = nil;
            [self requestFailedWithError:error];
        }];
    }
}

- (NSString *)errorMessageFromError:(NSError *)error
{
    if (error == nil) {
        return nil;
    }
    @try {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:&jsonError];
        if (jsonError != nil || json == nil) {
            NSLog(@"error: %@", json);
            return error.localizedDescription;
        }
        NSDictionary *errors = json[@"errors"];
        if (errors.allKeys.count > 0) {
            NSString *errorKey = errors.allKeys.firstObject;
            NSArray *errorArray = errors[errorKey];
            if (errorArray.count) {
                NSLog(@"error: %@", errorArray.firstObject);
                return errorArray.firstObject;
            }
        }
        NSString *message = json[@"message"];
        if (message) {
            return message;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception: %@", exception.reason);
    }
    return error.localizedDescription;
    
}

- (void) requestSuccess
{
    _failCounter=0;
    _serverData = [self addEntityStatusInResponse:_serverData];
    
    if (_delegate && [_delegate respondsToSelector:@selector(RequestDidSuccess:)]) {
        [_delegate RequestDidSuccess:self];
    }
    if (self.responseBlock) {
        self.responseBlock(YES, self);
    }
}

- (void) requestFailedWithError:(NSError*)error
{
    if (self.StatusCode == 401) {
        NSString *message = [self errorMessageFromError:error];
        if ([message isEqualToString:ERROR_BLOCKED_USER]) {
            [[ActivityIndicator currentIndicator] displayCompleted];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@""
                                                             message:NSLocalizedString(@"You are blocked.", @"")
                                                            delegate:nil
                                                   cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                                                   otherButtonTitles:nil];
            [alert show];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLOGOUT object:nil];
            return;
        }
    }
    if (_failCounter<0) {
        _failCounter++;
        NSLog(@"request fail  %li",(long)_failCounter);
        [self startRequest];
    }
    else{
        self.error = error;
        if (self.responseBlock) {
            self.responseBlock(NO, self);
        }
        else{
            if (_delegate && [_delegate respondsToSelector:@selector(RequestDidFailForRequest:withError:)]) {
                [_delegate RequestDidFailForRequest:self withError:[self errorMessageFromError:error]];
            }
        }
       
    }
}

- (id) addEntityStatusInResponse:(id) data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *temp = [data mutableCopy];
        [temp setValue:c_UNCHANGED forKey:@"entity_status"];
        for (NSString *key in [temp allKeys]) {
            if ([[temp objectForKey:key] isKindOfClass:[NSDictionary class]] || [[temp objectForKey:key] isKindOfClass:[NSArray class]]) {
                [temp setValue:[self addEntityStatusInResponse:[temp objectForKey:key]] forKey:key];
            }
        }
        return temp;
    } else if ([data isKindOfClass:[NSArray class]]){
        if (((NSArray*)data).count > 0 && [[((NSArray*)data) objectAtIndex:0] isKindOfClass:[NSDictionary class]]) {
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            for (id dict in data) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *temp_dict = [self addEntityStatusInResponse:dict];
                    if (temp_dict) {
                        [temp addObject:temp_dict];
                    }
                }
            }
            return [[NSArray alloc] initWithArray:temp];
        }
    }
    return data;
}


+ (void) uploadPDFFile:(NSString*)file_url file_name:(NSString*)file_name formId:(NSString*) formId withFormaData:(NSMutableDictionary*)form_data onServerUrl:(NSString*)url withMethod:(RequestMethod)method withCompletionBlock:(UploadFileCompletionBlock)block
{
    
    FieldWorkAccount *account = [AccountManager Instance].activeAccount;
    NSString *api_key = account.api_key;
    
    NSString *url_part = [NSString stringWithFormat:@"%@%@/%@?pdf_form_id=%@&api_key=%@", FW_BASE_URL, FW_API_VERSION ,url,formId, api_key];
    
    NSString *request_method = @"POST";
    if (method == PUT) {
        request_method = @"PUT";
    }
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:FW_BASE_URL]];
    
    NSURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:request_method URLString:url_part parameters:nil constructingBodyWithBlock:^void(id<AFMultipartFormData> formData) {
        NSError *error = nil;
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:file_url] name:file_name error:&error];
        if (error) {
            NSLog(@"File Upload File Append Error : %@", error);
        }
        for (NSString *key in form_data) {
            [formData appendPartWithFormData:[[form_data objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding] name:key];
        }
    } error:nil];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^void(AFHTTPRequestOperation *operation, id responseObject) {
        FWRequest *request = [[FWRequest alloc] init];
        request.IsSuccess = YES;
        request.serverData = responseObject;
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        request.StatusCode = r.statusCode;
        block(request);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        FWRequest *request = [[FWRequest alloc] init];
        request.IsSuccess = NO;
        request.serverData = nil;
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        request.StatusCode = r.statusCode;
        request.error = error;
        block(request);
    }];
    
    [manager.operationQueue addOperation:operation];
    
    //    if (method == POST) {
    //        [[[FWRequestManager Instance] requestManager] POST:url_part parameters:form_data constructingBodyWithBlock:^void(id<AFMultipartFormData> formData) {
    //            [formData appendPartWithFileURL:[NSURL URLWithString:file_url] name:@"" error:nil];
    //            for (NSString *key in form_data) {
    //                [formData appendPartWithFormData:[[form_data objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding] name:key];
    //            }
    //        } success:^void(NSURLSessionDataTask * task, id responseObject) {
    //            FWRequest *request = [[FWRequest alloc] init];
    //            request.IsSuccess = YES;
    //            request.serverData = responseObject;
    //            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
    //            request.StatusCode = r.statusCode;
    //            block(request);
    //        } failure:^void(NSURLSessionDataTask * task, NSError * error) {
    //            FWRequest *request = [[FWRequest alloc] init];
    //            request.IsSuccess = NO;
    //            request.serverData = nil;
    //            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
    //            request.StatusCode = r.statusCode;
    //            request.error = error;
    //            block(request);
    //        }];
    //    } else if (method == PUT) {
    //
    //
    //    }
}


+ (void) uploadFile:(NSString*)file_url file_name:(NSString*)file_name withFormaData:(NSMutableDictionary*)form_data onServerUrl:(NSString*)url withMethod:(RequestMethod)method withCompletionBlock:(UploadFileCompletionBlock)block
{
    
    FieldWorkAccount *account = [AccountManager Instance].activeAccount;
    NSString *api_key = account.api_key;
    
    NSString *url_part = [NSString stringWithFormat:@"%@%@/%@?api_key=%@", FW_BASE_URL, FW_API_VERSION ,url, api_key];
    
    NSString *request_method = @"POST";
    if (method == PUT) {
        request_method = @"PUT";
    }
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:FW_BASE_URL]];
    
    NSURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:request_method URLString:url_part parameters:nil constructingBodyWithBlock:^void(id<AFMultipartFormData> formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:file_url] name:file_name error:&error];
        if (error) {
            NSLog(@"File Upload File Append Error : %@", error);
        }
        for (NSString *key in form_data) {
            [formData appendPartWithFormData:[[form_data objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding] name:key];
        }
    } error:nil];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^void(AFHTTPRequestOperation *operation, id responseObject) {
        FWRequest *request = [[FWRequest alloc] init];
        request.IsSuccess = YES;
        request.serverData = responseObject;
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        request.StatusCode = r.statusCode;
        NSLog(@"request.StatusCode %ld",(long)request.StatusCode);
        block(request);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        FWRequest *request = [[FWRequest alloc] init];
        request.IsSuccess = NO;
        request.serverData = nil;
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        request.StatusCode = r.statusCode;
        NSLog(@"request.StatusCode %ld",(long)request.StatusCode);
        request.error = error;
        block(request);
    }];
    
    [manager.operationQueue addOperation:operation];
    
        //    if (method == POST) {
        //        [[[FWRequestManager Instance] requestManager] POST:url_part parameters:form_data constructingBodyWithBlock:^void(id<AFMultipartFormData> formData) {
        //            [formData appendPartWithFileURL:[NSURL URLWithString:file_url] name:@"" error:nil];
        //            for (NSString *key in form_data) {
        //                [formData appendPartWithFormData:[[form_data objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding] name:key];
        //            }
        //        } success:^void(NSURLSessionDataTask * task, id responseObject) {
        //            FWRequest *request = [[FWRequest alloc] init];
        //            request.IsSuccess = YES;
        //            request.serverData = responseObject;
        //            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
        //            request.StatusCode = r.statusCode;
        //            block(request);
        //        } failure:^void(NSURLSessionDataTask * task, NSError * error) {
        //            FWRequest *request = [[FWRequest alloc] init];
        //            request.IsSuccess = NO;
        //            request.serverData = nil;
        //            NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
        //            request.StatusCode = r.statusCode;
        //            request.error = error;
        //            block(request);
        //        }];
        //    } else if (method == PUT) {
        //
        //
        //    }
}

//file urls are keys and file names are values (only file url could be uniq)
+ (void) uploadFiles:(NSDictionary*)files withFormaData:(NSMutableDictionary*)form_data onServerUrl:(NSString*)url withMethod:(RequestMethod)method withCompletionBlock:(UploadFileCompletionBlock)block{
   
    FieldWorkAccount *account = [AccountManager Instance].activeAccount;
    NSString *api_key = account.api_key;
    NSString *url_part = [NSString stringWithFormat:@"%@%@/%@?api_key=%@", FW_BASE_URL, FW_API_VERSION ,url, api_key];
    NSString *request_method = @"POST";
    if (method == PUT) {
        request_method = @"PUT";
    }
    NSError* multipartError;
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:FW_BASE_URL]];
    NSURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:request_method URLString:url_part parameters:nil constructingBodyWithBlock:^void(id<AFMultipartFormData> formData) {
        NSArray* fileUrls=[files allKeys];
        for (NSString* file_url in fileUrls) {
            NSString* file_name=[files objectForKey:file_url];
            NSError *error = nil;
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:file_url] name:file_name error:&error];
            if (error) {
                NSLog(@"File Upload File Append Error : %@", error);
            }
        }
        
        for (NSString *key in form_data) {
                [formData appendPartWithFormData:[[form_data objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding] name:key ];
        }
        
      
    } error:&multipartError];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^void(AFHTTPRequestOperation *operation, id responseObject) {
        FWRequest *request = [[FWRequest alloc] init];
        request.IsSuccess = YES;
        request.serverData = responseObject;
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        request.StatusCode = r.statusCode;
        block(request);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        FWRequest *request = [[FWRequest alloc] init];
        request.IsSuccess = NO;
        request.serverData = nil;
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)operation.response;
        request.StatusCode = r.statusCode;
        request.error = error;
        block(request);
    }];
    [manager.operationQueue addOperation:operation];
}

- (void) downloadPlan:(NSString*)file_url saveToFilePath:(NSString*)path withCompletionBlock:(DownloadFileCompletionBlock)block
{
//    FieldWorkAccount *account = [AccountManager Instance].activeAccount;
//    NSString *api_key = account.api_key;
    
//    NSString *url_part = [NSString stringWithFormat:@"%@/%@%@?api_key=%@", FW_BASE_URL ,FW_API_VERSION ,file_url, api_key];
    NSLog(@"url_part %@", file_url);
    AFHTTPSessionManager *manager = [[FWRequestManager Instance] tempRequestManager];
    
    NSURL *formattedURL = [NSURL URLWithString:file_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:formattedURL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        FWRequest *request = [[FWRequest alloc] init];
        request.IsSuccess = YES;
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)response;
        request.StatusCode = r.statusCode;
        block(request);
    }];
    [downloadTask resume];
}


+ (void) downloadFile:(NSString*)file_url saveToFilePath:(NSString*)path withCompletionBlock:(DownloadFileCompletionBlock)block
{
    FieldWorkAccount *account = [AccountManager Instance].activeAccount;
    NSString *api_key = account.api_key;
    
    NSString *url_part = [NSString stringWithFormat:@"%@%@%@", FW_BASE_URL ,FW_API_VERSION ,file_url];
    
    if ([file_url containsString:@"?"]) {
        url_part = [url_part stringByAppendingString:[NSString stringWithFormat:@"&api_key=%@", api_key]];
    } else {
        url_part = [url_part stringByAppendingString:[NSString stringWithFormat:@"?api_key=%@", api_key]];
    }
//=======
//    NSString *url_part =@"";
//    if ([file_url containsString:@"?"]) {
//        url_part= [NSString stringWithFormat:@"%@/%@%@&api_key=%@", FW_BASE_URL ,FW_API_VERSION ,file_url, api_key];
//    }
//    else{
//        url_part= [NSString stringWithFormat:@"%@/%@%@?api_key=%@", FW_BASE_URL ,FW_API_VERSION ,file_url, api_key];
//    }
//   
//>>>>>>> estimates_feature
    NSLog(@"url_part %@", url_part);
    AFHTTPSessionManager *manager = [[FWRequestManager Instance] tempRequestManager];
    
    NSURL *formattedURL = [NSURL URLWithString:url_part];
    NSURLRequest *request = [NSURLRequest requestWithURL:formattedURL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        FWRequest *request = [[FWRequest alloc] init];
        request.IsSuccess = YES;
        NSHTTPURLResponse* r = (NSHTTPURLResponse*)response;
        request.StatusCode = r.statusCode;
        block(request);
    }];
    [downloadTask resume];
}

+ (void)sendReportWithEvent:(NSString *)name attributes:(NSDictionary*)attributes {
    [Answers logCustomEventWithName:name
                   customAttributes:attributes];
}


@end
