#import "Material.h"
#import "CDHelper.h"
#import "NSManagedObject+Mapping.h"

@interface Material ()

// Private interface goes here.

@end

@implementation Material

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Material entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[Material class]] mutableCopy];
    
    [dict removeObjectForKey:@"price"];
    
    [mapping addAttributesFromDictionary:dict];
    
    [mapping addAttribute:[Material floatAttributeFor:@"price" andKeyPath:@"price"]];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (Material*) newEntity
{
    Material *mat = [Material MR_createEntity];
    [mat setEntity_status:c_ADDED];
    return mat;
}

+ (void)loadAllWithBlock:(ItemLoadedBlock)block {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        __block NSMutableArray *arr = [[Material MR_findAll] mutableCopy];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (block) {
//                block(arr, nil);
//            }
//        });
//    });
    
    NSMutableArray *arr = [[Material MR_findAll] mutableCopy];
    if (block) {
        block(arr, nil);
    }
}

+ (Material*) getById:(NSNumber*) material_id
{
    return [Material MR_findFirstByAttribute:@"entity_id" withValue:material_id];
}

+ (Material*) materialByName:(NSString*) name
{
    return [Material MR_findFirstByAttribute:@"name" withValue:name];
}

- (void)addNewMaterialOnServerWithBlock:(ItemSavedBlock)block {
    
    NSDictionary *dict = @{@"name":self.name, @"epa_number":self.epa_number};
    
    [FWRequest requestWithURLPart:API_MATERIAL method:POST dict:dict block:^(BOOL success, FWRequest *request) {
        if (request.IsSuccess) {
            NSDictionary *main = request.serverData;
            NSDictionary* material=[main objectForKey:@"material"];
            NSNumber* idFromServer= [material objectForKey:@"id"];
            [self setEntity_id:idFromServer];
            [self.managedObjectContext MR_saveToPersistentStoreAndWait];
            block(self, YES, nil);
        } else {
            [self.managedObjectContext rollback];
            [self.managedObjectContext refreshObject:self mergeChanges:NO];
            block(nil, NO, [request errorMessageFromError:request.error]);
        }
    }];
}

@end
