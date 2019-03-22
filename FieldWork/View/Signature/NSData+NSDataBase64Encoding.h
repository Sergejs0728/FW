//
//  NSData+NSDataBase64Encoding.h
//  TopBlip
//
//  Created by Avantar Developer on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSDataBase64Encoding)
{
    
}
+ (NSData *)dataWithBase64String:(NSString *)strBase64;
-(NSString *)base64String;

-(NSString*)hexadecimalString;

@end
