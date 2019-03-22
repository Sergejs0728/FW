//
//  AccountAuthenticateDelegate.h
//  FieldWork
//
//  Created by Samir Kha on 06/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FieldWorkAccount;

@protocol AccountAuthenticateDelegate <NSObject>

-(void)accountAuthenticatedWithAccount:(FieldWorkAccount*) account;
-(void)accountDidFailAuthentication:(NSError*) error;

@end
