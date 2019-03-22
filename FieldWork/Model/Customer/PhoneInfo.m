//
//  PhoneInfo.m
//  FieldWork
//
//  Created by SamirMAC on 1/20/16.
//
//

#import "PhoneInfo.h"

#import "Customer.h"

@implementation PhoneInfo

@synthesize phone = _phone;
@synthesize phone_ext = _phone_ext;
@synthesize phone_kind = _phone_kind;

+ (NSMutableArray*) createBillingPhoneArray:(Customer*)cust
{
    
    NSMutableArray *phones = cust.billing_phones;
    NSMutableArray *phone_ext = cust.billing_phones_exts;
    NSMutableArray *phone_kind = cust.billing_phones_kinds;
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    if (cust.billing_phone) {
        PhoneInfo *info = [[PhoneInfo alloc] init];
        info.phone = cust.billing_phone;
        info.phone_ext = cust.billing_phone_ext;
        info.phone_kind = cust.billing_phone_kind;
        [arr addObject:info];
    }
    
    int i = 0;
    for (NSString *phone in phones) {
        PhoneInfo *info = [[PhoneInfo alloc] init];
        info.phone = phone;
        if (phone_ext.count > i && [phone_ext objectAtIndex:i]) {
            info.phone_ext = [phone_ext objectAtIndex:i];
        }
        
        if (phone_kind.count > i && [phone_kind objectAtIndex:i]) {
            info.phone_kind = [phone_kind objectAtIndex:i];
        }
        
        [arr addObject:info];
        
        i++;
    }
    return arr;
}


+ (NSMutableArray*) createServicePhoneArray:(ServiceLocation*)ser_loc
{
    
    NSMutableArray *phones = ser_loc.phones;
    NSMutableArray *phone_ext = ser_loc.phones_exts;
    NSMutableArray *phone_kind = ser_loc.phones_kinds;
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    if (ser_loc.phone) {
        PhoneInfo *info = [[PhoneInfo alloc] init];
        info.phone = ser_loc.phone;
        info.phone_ext = ser_loc.phone_ext;
        info.phone_kind = ser_loc.phone_kind;
        [arr addObject:info];
    }
    
    int i = 0;
    for (NSString *phone in phones) {
        PhoneInfo *info = [[PhoneInfo alloc] init];
        info.phone = phone;
        if (phone_ext.count > i && [phone_ext objectAtIndex:i]) {
            info.phone_ext = [phone_ext objectAtIndex:i];
        }
        
        if (phone_kind.count > i && [phone_kind objectAtIndex:i]) {
            info.phone_kind = [phone_kind objectAtIndex:i];
        }
        
        [arr addObject:info];
        
        i++;
    }
    return arr;
}

@end
