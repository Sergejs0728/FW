//
//  CustomerListDelegate.h
//  FieldWork
//
//  Created by SAMCOM on 26/11/15.
//
//

#import <Foundation/Foundation.h>

@protocol CustomerListDelegate <NSObject>

- (void)CustomerListLoaded;
- (void)CustomerListLoadFailed:(NSString *)error;
@end
