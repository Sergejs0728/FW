//
//  KitLocateTasker.h
//  Periodic-Example-iPhone
//
//  Created by KitLocate on 06/03/13.
//  Copyright (c) 2013 KitLocate. All rights reserved.
//
//  The class which implements the CallBack functions of KitLocate
//

#import <Foundation/Foundation.h>
#import <KitLocate/KitLocate.h>


#define kLOCATION_UPDATED_NOTIFICATION @"kLOCATION_UPDATED_NOTIFICATION"

// This class implements KitLocateDelegate 
@interface KitLocateTasker : NSObject <KitLocateDelegate>
{
    CLLocationCoordinate2D _currentCordinates;
}

@property (nonatomic, assign) CLLocationCoordinate2D currentCordinates;

+ (id) Instance;

- (CLLocationCoordinate2D) getCurrentCordinates;

@end
