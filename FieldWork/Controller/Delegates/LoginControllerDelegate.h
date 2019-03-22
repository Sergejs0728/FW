//
//  LoginControllerDelegate.h
//  FieldWork
//
//  Created by Samir Kha on 05/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FieldWorkAccount;

@protocol LoginControllerDelegate <NSObject>

-(void)userDidLoginWithAccount:(FieldWorkAccount *)account;

@end
