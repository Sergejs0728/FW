//
//  MaterialUsageSelectionDelegate.h
//  FieldWork
//
//  Created by Samir Khatri on 4/3/14.
//
//

#import <Foundation/Foundation.h>

@class MaterialUsage;

@protocol MaterialUsageSelectionDelegate <NSObject>

- (void) materialUsageSelectedWithMaterialUsage:(MaterialUsage*)materialUsage;

- (void) materialUsageSelectionCanceled;

@end
