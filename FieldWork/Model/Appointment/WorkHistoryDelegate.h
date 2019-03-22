//
//  WorkHistoryDelegate.h
//  FieldWork
//
//  Created by SAMCOM on 26/11/15.
//
//

#import <Foundation/Foundation.h>

@protocol WorkHistoryDelegate <NSObject>

- (void)WorkHistoryLoaded;
- (void)WorkHistoryLoadFailWithError:(NSString *)error;

@end
