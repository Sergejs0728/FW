//
//  StaticModelLoader.m
//  FWModel
//
//  Created by SamirMAC on 11/12/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "StaticModelLoader.h"

#import "ApplicationMethods.h"
#import "Statuses.h"
#import "Measurements.h"
#import "BaitConditions.h"
#import "DeviceTypes.h"
#import "TrapConditions.h"
#import "TrapTypes.h"
#import "BillingTerms.h"
#import "Conditions.h"
#import "Evidences.h"
#import "TaxRates.h"
#import "Recommendations.h"
#import "ServiceRoutes.h"
#import "Services.h"
#import "DilutionRates.h"
#import "LocationType.h"
#import "Pest.h"
#import "Material.h"
#import "Estimate.h"
#import "ActivityLevel.h"
#import "FlatConditions.h"
#import "UnitStatus.h"
#import "FlatType.h"

@interface StaticModelLoader()
@property (nonatomic, copy) void (^completion)(NSMutableArray* failedList);

@end

@implementation StaticModelLoader

+ (instancetype) Instance {
    static StaticModelLoader *__sharedDataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedDataModel = [[StaticModelLoader alloc] init];
        __sharedDataModel.pathsList = @[locationtypes,
                                        application_methods,
                                        measurements,
                                        deviceTypes,
                                        trapTypes,
                                        trapConditions,
                                        baitConditions,
                                        billingTerms,
                                        taxRates,
                                        serviceRoutes,
                                        services,
                                        recommendations,
                                        conditions,
                                        evidences,
                                        dialution_rates,
                                        pest_types,
                                        materials,
                                        flatConditions,
                                        activityLevels,
                                        unitStatuses,
                                        flatTypes
                                        ];
        __sharedDataModel.pathsListQueue = [NSMutableArray array];
        __sharedDataModel.pathsListFailedQueue = [NSMutableArray array];
    });
    
    return __sharedDataModel;
}

-(BOOL)isLoading{
    return _pathsListQueue.count > 0;
}

- (void)loadStatuses {
    [self requestGet:statuses];
}

- (NSMutableArray*)emptyLists {
    NSMutableArray *lists = [NSMutableArray array];
    if ([LocationType MR_countOfEntities] == 0) {
        [lists addObject:locationtypes];
    }
    if ([ApplicationMethods MR_countOfEntities] == 0) {
        [lists addObject:application_methods];
    }
    if ([Measurements MR_countOfEntities] == 0) {
        [lists addObject:measurements];
    }
    if ([DeviceTypes MR_countOfEntities] == 0) {
        [lists addObject:deviceTypes];
    }
    if ([TrapTypes MR_countOfEntities] == 0) {
        [lists addObject:trapTypes];
    }
    if ([TrapConditions MR_countOfEntities] == 0) {
        [lists addObject:trapConditions];
    }
    if ([BaitConditions MR_countOfEntities] == 0) {
        [lists addObject:baitConditions];
    }
    if ([BillingTerms MR_countOfEntities] == 0) {
        [lists addObject:billingTerms];
    }
    if ([TaxRates MR_countOfEntities] == 0) {
        [lists addObject:taxRates];
    }
    if ([ServiceRoutes MR_countOfEntities] == 0) {
        [lists addObject:serviceRoutes];
    }
    if ([Services MR_countOfEntities] == 0) {
        [lists addObject:services];
    }
    if ([Recommendations MR_countOfEntities] == 0) {
        [lists addObject:recommendations];
    }
    if ([Conditions MR_countOfEntities] == 0) {
        [lists addObject:conditions];
    }
    if ([Evidences MR_countOfEntities] == 0) {
        [lists addObject:evidences];
    }
    if ([DilutionRates MR_countOfEntities] == 0) {
        [lists addObject:dialution_rates];
    }
    if ([Pest MR_countOfEntities] == 0) {
        [lists addObject:pest_types];
    }
    if ([Material MR_countOfEntities] == 0) {
        [lists addObject:materials];
    }
    if ([ActivityLevel MR_countOfEntities] == 0) {
        [lists addObject:activityLevels];
    }
    if ([FlatConditions MR_countOfEntities] == 0) {
        [lists addObject:flatConditions];
    }
    if ([UnitStatus MR_countOfEntities] == 0) {
        [lists addObject:unitStatuses];
    }
    if ([FlatType MR_countOfEntities] == 0) {
        [lists addObject:flatTypes];
    }
    return lists;
}

- (void)loadAllListsWithCompletion:(void (^)(NSMutableArray* failedList))completion {
    [self loadLists:_pathsList completion:completion];
}

- (void)loadLists:(NSArray*)lists completion:(void (^)(NSMutableArray* failedList))completion {
    _completion = completion;
    if (lists) {
        if (lists.count) {
            _pathsListQueue = [NSMutableArray arrayWithArray:lists];
        } else {
            if (_completion) {
                _completion([NSMutableArray array]);
            }
        }
    } else {
        _pathsListQueue = [NSMutableArray arrayWithArray:_pathsList];
    }
    _pathsListFailedQueue = [NSMutableArray array];
    for (NSString *path in _pathsListQueue) {
        [self requestGet:path];
    }
}


-(void)deleteAll{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate resetCoreDataDB];
    //    [ApplicationMethods MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [Statuses MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [Measurements MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [BaitConditions MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [DeviceTypes MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [TrapConditions MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [TrapTypes MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [BillingTerms MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [Conditions MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [Evidences MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [Recommendations MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [ServiceRoutes MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [Services MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [DilutionRates MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [LocationType MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [Pest MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    //    [Material MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
}

- (void) requestGet:(NSString*)url_part
{
    FWRequest *request = [[FWRequest alloc] initWithUrl:url_part andDelegate:self];
    request.Tag = url_part;
    [request startRequest];
}



#pragma mark - FWRequestDelegate

- (void)RequestDidSuccess:(FWRequest *)request {
    if (!request.IsSuccess) {
        if ([_pathsListQueue containsObject:request.Tag]) {
            [_pathsListQueue removeObject:request.Tag];
        }
        if (![_pathsListFailedQueue containsObject:request.Tag]) {
            [_pathsListFailedQueue addObject:request.Tag];
        }
        if (_pathsListQueue.count == 0 && _completion && [_pathsList containsObject:request.Tag]) {
            _completion(_pathsListFailedQueue);
        }
        NSLog(@"Error loading list %@", request.Tag);
        return;
    }
    FEMMapping *mapping = nil;
    if ([request.Tag isEqualToString:statuses]) {
        [Statuses MR_truncateAll];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait]; //save truncation
        mapping = [Statuses defaultMapping];
        [FEMDeserializer collectionFromRepresentation:request.serverData mapping:mapping context:[NSManagedObjectContext MR_defaultContext]];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        return;
    }
    if ([request.Tag isEqualToString:measurements]) {
        mapping = [Measurements defaultMapping];
        [Measurements MR_truncateAll];
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NSArray *records = request.serverData;
            for (NSString *val in records) {
                if ([Measurements MR_findByAttribute:@"measurement" withValue:val].count <= 0) {
                    Measurements *m = [Measurements MR_createEntityInContext:localContext];
                    [m setMeasurement:[NSString stringWithFormat:@"%@",val]];
                }
            }
        } completion:^(BOOL contextDidSave, NSError *error) {
            if ([_pathsListQueue containsObject:request.Tag]) {
                [_pathsListQueue removeObject:request.Tag];
            }
            if(contextDidSave) {
                NSLog(@"%@ Updated", request.Tag);
            }
            else {
                if (![_pathsListFailedQueue containsObject:request.Tag]) {
                    [_pathsListFailedQueue addObject:request.Tag];
                }
                NSLog(@"StaticModelLoader :  RequestDidSuccess : Error in %@ - %@", request.Tag, error);
            }
            if (_pathsListQueue.count == 0 && _completion && [_pathsList containsObject:request.Tag]) {
                _completion(_pathsListFailedQueue);
            }
            
            
        }];
        return;
    }

    
    if ([request.Tag isEqualToString:application_methods]) {
        [ApplicationMethods MR_truncateAll];
        mapping = [ApplicationMethods defaultMapping];
    }
    
    if ([request.Tag isEqualToString:locationtypes]) {
        [LocationType MR_truncateAll];
        mapping = [LocationType defaultMapping];
    }
    
    if ([request.Tag isEqualToString:deviceTypes]) {
        [DeviceTypes MR_truncateAll];
        mapping = [DeviceTypes defaultMapping];
    }
    
    if ([request.Tag isEqualToString:trapTypes]) {
        [TrapTypes MR_truncateAll];
        mapping = [TrapTypes defaultMapping];
    }
    
    if ([request.Tag isEqualToString:trapConditions]) {
        [TrapConditions MR_truncateAll];
        mapping = [TrapConditions defaultMapping];
    }
    
    if ([request.Tag isEqualToString:baitConditions]) {
        [BaitConditions MR_truncateAll];
        mapping = [BaitConditions defaultMapping];
    }
    
    if ([request.Tag isEqualToString:billingTerms]) {
        [BillingTerms MR_truncateAll];
        mapping = [BillingTerms defaultMapping];
    }
    
    if ([request.Tag isEqualToString:taxRates]) {
        [TaxRates MR_truncateAll];
        mapping = [TaxRates defaultMapping];
    }
    
    if ([request.Tag isEqualToString:serviceRoutes]) {
        [ServiceRoutes MR_truncateAll];
        mapping = [ServiceRoutes defaultMapping];
    }
    
    if ([request.Tag isEqualToString:services]) {
        [Services MR_truncateAll];
        mapping = [Services defaultMapping];
    }
    
    if ([request.Tag isEqualToString:recommendations]) {
        [Recommendations MR_truncateAll];
        mapping = [Recommendations defaultMapping];
    }
    
    if ([request.Tag isEqualToString:conditions]) {
        [Conditions MR_truncateAll];
        mapping = [Conditions defaultMapping];
    }
    
    if ([request.Tag isEqualToString:evidences]) {
        [Evidences MR_truncateAll];
        mapping = [Evidences defaultMapping];
    }
    
    if ([request.Tag isEqualToString:dialution_rates]) {
        [DilutionRates MR_truncateAll];
        mapping = [DilutionRates defaultMapping];
    }
    
    if ([request.Tag isEqualToString:pest_types]) {
        [Pest MR_truncateAll];
        mapping = [Pest defaultMapping];
    }
    
    if ([request.Tag isEqualToString:materials]) {
        [Material MR_truncateAll];
        mapping = [Material defaultMapping];
    }
    if ([request.Tag isEqualToString:estimates]) {
        [Estimate MR_truncateAll];
        mapping = [Estimate defaultMapping];
    }
    //---multiunits feature
    if ([request.Tag isEqualToString:activityLevels]) {
        [ActivityLevel MR_truncateAll];
        mapping = [ActivityLevel defaultMapping];
    }
    if ([request.Tag isEqualToString:flatConditions]) {
        [FlatConditions MR_truncateAll];
        mapping = [FlatConditions defaultMapping];
    }
    if ([request.Tag isEqualToString:unitStatuses]) {
        [UnitStatus MR_truncateAll];
        mapping = [UnitStatus defaultMapping];
    }
    if ([request.Tag isEqualToString:flatTypes]) {
        [FlatType MR_truncateAll];
        mapping = [FlatType defaultMapping];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait]; //save truncation
    if (mapping) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [FEMDeserializer collectionFromRepresentation:request.serverData mapping:mapping context:localContext];
        } completion:^(BOOL contextDidSave, NSError *error) {
            if ([_pathsListQueue containsObject:request.Tag]) {
                [_pathsListQueue removeObject:request.Tag];
            }
            if (contextDidSave) {
                NSLog(@"%@ Updated", request.Tag);
            } else {
                if ([request.serverData isKindOfClass:[NSArray class]]) {
                    if ([(NSArray*)request.serverData count] == 0) {
                        NSLog(@"%@ Updated", request.Tag);
                    } else {
                        if (![_pathsListFailedQueue containsObject:request.Tag]) {
                            [_pathsListFailedQueue addObject:request.Tag];
                        }
                        NSLog(@"StaticModelLoader :  RequestDidSuccess : Error in %@ - %@", request.Tag, error);
                    }
                } else {
                    if (![_pathsListFailedQueue containsObject:request.Tag]) {
                        [_pathsListFailedQueue addObject:request.Tag];
                    }
                    NSLog(@"StaticModelLoader :  RequestDidSuccess : Error in %@ - %@", request.Tag, error);
                }
                
            }
            if (_pathsListQueue.count == 0 && _completion && [_pathsList containsObject:request.Tag]) {
                _completion(_pathsListFailedQueue);
            }
        }];
    }
}

- (void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error {
    NSLog(@"RequestDidFailForRequest - Error in %@ - %@", request.Tag, error);
    if (![_pathsListFailedQueue containsObject:request.Tag]) {
        [_pathsListFailedQueue addObject:request.Tag];
    }
    if ([_pathsListQueue containsObject:request.Tag]) {
        [_pathsListQueue removeObject:request.Tag];
    }
    if (_pathsListQueue.count == 0 && _completion && [_pathsList containsObject:request.Tag]) {
        _completion(_pathsListFailedQueue);
    }
}


@end
