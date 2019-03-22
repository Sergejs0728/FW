//
//  PestSelectionDelegate.h
//  FieldWork
//
//  Created by Samir Khatri on 4/3/14.
//
//

#import <Foundation/Foundation.h>

@class TargetPest;

typedef enum _SelectionFor
{
    MaterialUse,
    Inspection
} SelectionFor;

@protocol PestSelectionDelegate <NSObject>

- (void) pestRecordSelectedFor:(SelectionFor)selectionFor withTargetPest:(Pest*)targetPest;

- (void) pestRecordSelectionCanceledFor:(SelectionFor)selectionFor;

@end
