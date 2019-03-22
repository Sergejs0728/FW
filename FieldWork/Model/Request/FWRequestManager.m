//
//  FWRequestManager.m
//  FWModel
//
//  Created by SamirMAC on 11/8/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "FWRequestManager.h"

@implementation FWRequestManager

+ (id) Instance {
    static FWRequestManager *__sharedDataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedDataModel = [[FWRequestManager alloc] init];
    });
    
    return __sharedDataModel;
}


- (AFHTTPSessionManager*) requestManager
{
    if (_manager == nil) {
        NSURL *url = [NSURL URLWithString:FW_BASE_URL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
        
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _manager;
}

- (AFHTTPSessionManager*) tempRequestManager
{
    NSURL *url = [NSURL URLWithString:FW_BASE_URL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    return manager;
}

@end
