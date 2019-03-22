//
//  ListItemDelegate.h
//  FieldWork
//
//  Created by SAMCOM on 26/11/15.
//
//

#import <Foundation/Foundation.h>

@protocol ListItemDelegate <NSObject>

- (void) ListItemAddedSuccessfully;
- (void) ListItemAdditionFailedWithError:(NSString*) error;
- (void) ListItemDeletionFailedWithError:(NSString*) error;
- (void) ListItemDeletedSuccessfully;
@end
