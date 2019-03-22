//
//  Constants.h
//  FWModel
//
//  Created by SamirMAC on 11/13/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#ifndef FWModel_Constants_h
#define FWModel_Constants_h

#define c_ADDED                                     [NSNumber numberWithInt:100]
#define c_EDITED                                    [NSNumber numberWithInt:101]
#define c_DELETED                                   [NSNumber numberWithInt:102]
#define c_UNCHANGED                                 [NSNumber numberWithInt:0]

#define c_SYNC                                      [NSNumber numberWithInt:103]
#define c_DIRTY                                     [NSNumber numberWithInt:104]

#define wo_STATUS_COMPLETE                          @"Complete"
#define wo_STATUS_MISSED                            @"Missed"
#define wo_STATUS_SHEDULED                          @"Scheduled"
//Missed



#define ERROR_BLOCKED_USER              @"fieldwork-user-not-active"

#define c_DATABASE_PRIMARY_KEY_COLUMN_NAME          @"entity_id"

typedef void (^ItemSavedBlock)(id item, BOOL is_success, NSString* error);

typedef void (^ItemLoadedBlock)(id result, NSString *error);

typedef void (^DownloadCompletion)(id result);

typedef void (^TaskCompleted) (id result, BOOL is_success);

typedef void (^DataSelectionOrAddedBlock)(id result);

typedef void (^GeneralNotificationBlock)();


#define ALERT_TITLE @"FieldWork"

#define BLUE_COLOR [UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0]

#define WIND_DIRECTIONS @[ @"North", @"North East",@"North West", @"East",@"South", @"South East",@"South West", @"West",@"None"]

#define RED_COLOR [UIColor colorWithRed:232.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0]

#define TRIM(str)   [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]

// Macros

#define IntNumber(X)                                [NSNumber numberWithInt:X]
#define FloatNumber(X)                              [NSNumber numberWithFloat:X]


// Notifications

#define kMAKE_DIRTY_NOTIFICATION                    @"MarkAppointmentDirtyNotificaiton"

#define kFORFULLY_UPDATE_APPOINTMENTS               @"FORFULLY_UPDATE_APPOINTMENT"

#define kRELOAD_WORKORDERS_FROM_SERVER              @"RELOAD_WORKORDERS_FROM_SERVER"

#define kRELOAD_WORKORDERS_TABLE                    @"RELOAD_WORKORDERS_TABLE"

#define kCUSTOMER_HAS_CHANGED                       @"CUSTOMER_HAS_CHANGED"

#define kWORKORDER_DETAIL_UPDATE_SECTION            @"WORKORDER_DETAIL_UPDATE_SECTION"

#define kMATERIAL_ADDED                             @"MATERIAL_ADDED"

#define kHIDE_PICKERVIEW                            @"HIDE_PICKERVIEW"

#define kLOGOUT                                     @"LOGOUT"

#endif
