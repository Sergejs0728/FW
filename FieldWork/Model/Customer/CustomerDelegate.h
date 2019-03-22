//
//  CustomerDelegate.h
//  FieldWork
//
//  Created by SAMCOM on 26/11/15.
//
//

#import <Foundation/Foundation.h>
@class Customer;
@protocol CustomerDelegate <NSObject>
- (void)CustomerAddedSuccessfully:(Customer *)cust;
- (void)CustomerAddFailWithError:(NSString *)error;
@end
