//
//  FWRequestManager.h
//  FWModel
//
//  Created by SamirMAC on 11/8/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "FWURLSchema.h"

@interface FWRequestManager : NSObject
{
    AFHTTPSessionManager *_manager;
}


+ (id) Instance;

- (AFHTTPSessionManager*) requestManager;

- (AFHTTPSessionManager*) tempRequestManager;

@end
