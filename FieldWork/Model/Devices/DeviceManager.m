//
//  DeviceManager.m
//  FieldWork
//
//  Created by Borys Duda on 2/14/18.
//

#import "DeviceManager.h"
#import "DeviceArea.h"

@implementation DeviceManager

+ (instancetype) Instance {
    static DeviceManager *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[DeviceManager alloc] init];
    });
    return __sharedInstance;
}

- (void) loadAllDevices:(ItemLoadedBlock)block {
    __load_block = block;
    RequestMethod method = GET;
    NSString *tag = API_DEVICE_AREA;
    FWRequest *request = [[FWRequest alloc] initWithUrl:API_DEVICE_AREA andDelegate:self andMethod:method];
    request.Tag = tag;
    [request startRequest];
}

#pragma mark - FWRequestDelegate
- (void)RequestDidSuccess:(FWRequest *)request {
    if ([request.Tag isEqualToString:API_DEVICE_AREA]) {
        if (request.IsSuccess) {
            __block NSArray *cstmrs=[NSArray new];
            //            [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            cstmrs = [FEMDeserializer collectionFromRepresentation:request.serverData mapping:[DeviceArea defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                if (__load_block) {
                    __load_block(cstmrs, nil);
                }
            });
            
        } else {
            if (__load_block) {
                __load_block(nil, [request errorMessageFromError:request.error]);
            }
        }
        
    }
}

- (void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error {
    if (__load_block) {
        __load_block(nil, [request errorMessageFromError:request.error]);
    }
}

@end

