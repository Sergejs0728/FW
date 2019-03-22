#import "Pest.h"
#import "NSManagedObject+Mapping.h"

@interface Pest ()

// Private interface goes here.

@end

@implementation Pest

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Pest entityName]];
    [mapping addAttribute:[Pest stringAttributeFor:@"name" andKeyPath:@"name"]];
    [mapping addAttribute:[Pest intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (NSMutableArray *)fetchAll {
    NSMutableArray *arr = [[Pest MR_findAll] mutableCopy];
    return arr;
}

+ (void) fetchAllWithBlock:(ItemLoadedBlock)block
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        __block NSMutableArray *arr = [[Pest MR_findAll] mutableCopy];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (block) {
//                block(arr, nil);
//            }
//        });
//    });
    
    NSMutableArray *arr = [[Pest MR_findAll] mutableCopy];
    if (block) {
        block(arr, nil);
    }
}

-(void)postPest:(PestResponseBlock) block{
//    FWRequest* request=[[FWRequest alloc] initWithUrl:API_PEST_TYPES andDelegate:self andMethod:POST];
    FWRequest* request=[FWRequest requestWithURLPart:API_PEST_TYPES method:POST dict:@{@"name":self.name} block:^(BOOL success, FWRequest *request) {
        if (success) {
            NSDictionary* pest_type=[request.serverData objectForKey:@"pest_type"];
//            Pest* pest=[FEMDeserializer objectFromRepresentation:pest_type mapping:[Pest defaultMapping] context:self.managedObjectContext];
            if(block){
                block([pest_type objectForKey:@"id"], nil);
            }
        } else {
            if(block){
                block(nil, [request errorMessageFromError:request.error]);
            }
        }
    }];
    [request startRequest];
}

+ (Pest*) pestById:(NSNumber*)pest_id
{
    return [Pest MR_findFirstByAttribute:@"entity_id" withValue:pest_id];
}

+ (Pest*) pestByName:(NSString*)name
{
    return [Pest MR_findFirstByAttribute:@"name" withValue:name];
}

@end
