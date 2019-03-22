//
//  PhoneInfo.h
//  FieldWork
//
//  Created by SamirMAC on 1/20/16.
//
//

#import <Foundation/Foundation.h>

@class Customer;
@class ServiceLocation;

@interface PhoneInfo : NSObject
{
    NSString *_phone;
    NSString *_phone_ext;
    NSString *_phone_kind;
}


@property (nonatomic, retain, readwrite) NSString *phone;
@property (nonatomic, retain, readwrite) NSString *phone_ext;
@property (nonatomic, retain, readwrite) NSString *phone_kind;

+ (NSMutableArray*) createBillingPhoneArray:(Customer*)cust;

+ (NSMutableArray*) createServicePhoneArray:(ServiceLocation*)ser_loc;

@end
