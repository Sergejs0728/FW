//
//  Account.m
//  FieldWork
//
//  Created by Samir Kha on 05/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FieldWorkAccount.h"

#define ENCODING_VERSION        2

@implementation FieldWorkAccount

@synthesize userName  = _userName;
@synthesize password = _password;
@synthesize api_key = _api_key;
@synthesize delegate = _delegate;

-(id)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self)
    {
        if ([aDecoder decodeIntForKey:@"version"] == ENCODING_VERSION)
        {
            _userName = [aDecoder decodeObjectForKey:@"username"] ;
            _password = [aDecoder decodeObjectForKey:@"password"];
            _api_key = [aDecoder decodeObjectForKey:@"api_key"];
        }
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:ENCODING_VERSION forKey:@"version"];
    [aCoder encodeObject:_userName forKey:@"username"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_api_key forKey:@"api_key"];
}

@dynamic authenticated;

-(BOOL)authenticated
{
    return _api_key != nil;
}

- (void)authenticatedWithUserName:(NSString *)username andPassword:(NSString *)password withDelegate:(id<AccountAuthenticateDelegate>) del{
    _userName = username;
    _password = password;
    _delegate = del;
    NSString* urlStr=[NSString stringWithFormat:@"%@?email=%@&password=%@", API_GET_KEY, _userName, _password];
    FWRequest *request = [[FWRequest alloc] initWithUrl:urlStr andDelegate:self andMethod:POST];
    [request startRequest];
}

#pragma FWRequestDelegate


- (void)RequestDidSuccess:(FWRequest *)request {
    if(request.IsSuccess){
        NSDictionary *data = request.serverData;
        NSString* apikey = [data objectForKey:@"api_key"];
        if (apikey.length > 0) {
            _api_key = apikey;
            [_delegate accountAuthenticatedWithAccount:self];
        }else{
            NSError *error = [NSError errorWithDomain:@"RequestError" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Can not get authenticate, please try again later.", @"message", nil]];
            [_delegate accountDidFailAuthentication:error];
        }
    } else{
    }
}

- (void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error{
    [_delegate accountDidFailAuthentication:[NSError errorWithDomain:@"FieldWork" code:1010 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:error, @"message", nil]]];
}


@end
