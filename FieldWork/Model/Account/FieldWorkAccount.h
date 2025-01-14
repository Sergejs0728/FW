//
//  Account.h
//  FieldWork
//
//  Created by Samir Kha on 05/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWRequestKit.h"
#import "AccountAuthenticateDelegate.h"

@interface FieldWorkAccount : NSObject <NSCoding, FWRequestDelegate>
{
    NSString *_userName;
    NSString *_password;
    NSString *_api_key;
    
    id<AccountAuthenticateDelegate> _delegate;
}

@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSString *password;
@property (nonatomic, readonly) NSString *api_key;
@property (nonatomic, readwrite, retain) id<AccountAuthenticateDelegate> delegate;
@property (nonatomic, readonly) BOOL authenticated;

- (void) authenticatedWithUserName:(NSString*) username andPassword:(NSString*) password withDelegate:(id<AccountAuthenticateDelegate>) del;
@end
