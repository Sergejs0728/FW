//
//  FWRequestDelegate.h
//  FWModel
//
//  Created by SamirMAC on 11/8/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FWRequest;

@protocol FWRequestDelegate <NSObject>

- (void) RequestDidSuccess:(FWRequest*)request;

- (void) RequestDidFailForRequest:(FWRequest*)request withError:(NSString*)error;

@end
