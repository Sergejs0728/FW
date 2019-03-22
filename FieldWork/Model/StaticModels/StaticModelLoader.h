//
//  StaticModelLoader.h
//  FWModel
//
//  Created by SamirMAC on 11/12/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWRequestKit.h"

static NSString *application_methods = @"/application_methods_with_id";
static NSString *statuses = @"/statuses";
static NSString *measurements = @"/measurements";
static NSString *locationtypes= @"/location_types";
static NSString *estimates= @"/estimates";
static NSString *deviceTypes= @"/application_device_types";
static NSString *trapTypes= @"/trap_types";
static NSString *trapConditions= @"/trap_conditions";
static NSString *baitConditions= @"/bait_conditions";
static NSString *billingTerms= @"/billing_terms";
static NSString *taxRates= @"/tax_rates";
static NSString *serviceRoutes= @"/service_routes";
static NSString *services= @"/services";
static NSString *recommendations = @"/recommendations";
static NSString *conditions = @"/appointment_conditions";
static NSString *evidences = @"/evidences";
static NSString *dialution_rates = @"/dilution_rates";
static NSString *pest_types = @"/pest_types";
static NSString *materials = @"/materials";
//---multiunits feature
static NSString *activityLevels = @"/activity_levels";
static NSString *flatConditions = @"/flat_conditions";
static NSString *unitStatuses = @"/unit_statuses";
static NSString *flatTypes = @"/flat_types";

@interface StaticModelLoader : NSObject <FWRequestDelegate>

@property (nonatomic, strong) NSArray *pathsList;
@property (nonatomic, strong) NSMutableArray *pathsListQueue;
@property (nonatomic, strong) NSMutableArray *pathsListFailedQueue;
@property (nonatomic) BOOL isLoading;

+ (instancetype) Instance;

- (void)loadAllListsWithCompletion:(void (^)(NSMutableArray* failedList))completion;
- (void)loadLists:(NSArray*)lists completion:(void (^)(NSMutableArray* failedList))completion;
- (void)loadStatuses;
- (NSMutableArray*)emptyLists;

- (void)deleteAll;
@end
