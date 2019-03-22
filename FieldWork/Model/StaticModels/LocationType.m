#import "LocationType.h"
#import "CDHelper.h"

@interface LocationType ()

// Private interface goes here.

@end

@implementation LocationType

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[LocationType entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[LocationType class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    [mapping addToManyRelationshipMapping:[LocationArea defaultMapping] forProperty:@"location_areas" keyPath:@"location_areas"];
    
    return mapping;
}

+(NSMutableArray *)getLocationTypes{
    return [[LocationType MR_findAllSortedBy:@"location_type_name" ascending:YES]mutableCopy];
}

+ (LocationType *)getLocationTypeById:(int)location_type_id {
    return [LocationType MR_findFirstByAttribute:@"entity_id" withValue:[NSNumber numberWithInt:location_type_id]];

}

+ (NSMutableArray *)getLocationAreasByLocationTypeId:(int)location_type_id {
    LocationType *ltype = [LocationType getLocationTypeById:location_type_id];
    return [[ltype.location_areas allObjects] mutableCopy];
}

- (void)addLocationArea:(NSString *)name block:(ItemLoadedBlock)block {
    NSDictionary *dict = @{@"name":name};
    NSString *url = [NSString stringWithFormat:API_LOCATION_AREAS, self.entity_id];
    [FWRequest requestWithURLPart:url method:POST dict:dict block:^(BOOL success, FWRequest *request) {
        if (success) {
            NSDictionary *main = request.serverData;
            __block NSDictionary *dict = [main objectForKey:@"location_area"];
            __block LocationArea *area = nil;
//            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                @try {
                    area = [FEMDeserializer objectFromRepresentation:dict mapping:[LocationArea defaultMapping] context:[NSManagedObjectContext MR_defaultContext]];
                    LocationType *type = [self MR_inContext:[NSManagedObjectContext MR_defaultContext]];
                    [type addLocation_areasObject:area];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }
                @catch (NSException *exception) {
                    [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                         @"Method":NSStringFromSelector(@selector(addLocationArea:block:)),
                                                                         @"Exception":exception.description,
                                                                         @"UserId":self.entity_id,
                                                                         @"RequestTag":url,
                                                                         @"RequestMethod":@"POST",
                                                                         @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                }
                
//            } completion:^(BOOL contextDidSave, NSError *error) {
                if (block) {
                    block(area, nil);
                }
                
//            }];
        } else {
            block(nil, [request errorMessageFromError:request.error]);
        }
    }];

}

@end
