#import "StageModel.h"
#import "ServiceLocation.h"
#import "Customer.h"
#import "CDHelper.h"

@interface StageModel ()


@end

@implementation StageModel

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[StageModel entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[StageModel class]] mutableCopy];
    
    [mapping addAttributesFromDictionary:dict];
        mapping.primaryKey=@"entity_id";
    return mapping;
}
+ (NSMutableArray*) getStages
{
    return [[StageModel MR_findAll] mutableCopy];
}

+ (StageModel*) stageByFloor:(NSString*)floor serviceLocation:(ServiceLocation*)sl
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"floor == %@ AND deleted == %@", floor, @(NO)];
    return [sl.floors filteredOrderedSetUsingPredicate:predicate].firstObject;
}


-(void)uploadPlan{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* pngPath=[NSString stringWithFormat:@"%@/%@.png", documentsDirectory, self.filePath];
    NSString* vgPath=[NSString stringWithFormat:@"%@/%@.vg", documentsDirectory, self.filePath];
//    NSString* serviceLocationId=];
    
//    ServiceLocation* serviceLocation=[ServiceLocation MR_findFirstByAttribute:@"entity_id" withValue:self.serviceLocation.entity_id];
    
    NSNumber* customerId=self.serviceLocation.customer_id;
    
//    Customer* customer=[Customer MR_findFirstByAttribute:@"entity_id" withValue:customerId];
//    [dict setValue:vgPath forKey:@"vg"];
//    [dict setValue:pngPath forKey:@"image"];
    [dict setValue:self.floor forKey:@"floor"];
    [dict setValue:self.notes forKey:@"notes"];
    [dict setValue: self.building forKey:@"building"];
    RequestMethod method = POST;
    NSString *server_url = [NSString stringWithFormat:@"customers/%@/service_locations/%@/floor_plans", customerId, self.serviceLocation.entity_id];
    if (self.entity_idValue > 0) {
        method=PUT;
        server_url=[NSString stringWithFormat:@"%@/%@",server_url,self.entity_id];
    }
    // Somehow the appointment relation is breaking after upload call, so will hold the appointment and attach the relation again.
    [FWRequest uploadFiles:@{pngPath:@"image",vgPath:@"vg"} withFormaData:dict onServerUrl:server_url withMethod:method withCompletionBlock:^(FWRequest *request) {
                if (request.IsSuccess) {
                    
                    if(self.entity_idValue<=0){
                        [self.managedObjectContext MR_saveOnlySelfAndWait];
                        NSDictionary *floor = [request.serverData objectForKey:@"floor_plan"];
                        [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
                            StageModel *local = [self MR_inContext:localContext];
                            [FEMDeserializer fillObject:local fromRepresentation:floor mapping:[StageModel defaultMapping]];
                            local.changed = @(NO);
                        }];
                     }
                }
    }];
    
}

-(void)deleteOnServerBlock:(void (^)())block{
    NSNumber* customerId=self.serviceLocation.customer_id;
    NSString *server_url = [NSString stringWithFormat:@"/customers/%@/service_locations/%@/floor_plans/%@", customerId, self.serviceLocation.entity_id,self.entity_id];
   [FWRequest requestWithURLPart:server_url method:DELETE dict:nil block:^(BOOL success, FWRequest *request) {
       if (success) {
           if (block) {
               block();
           }
       }
    }];
}

//-(void)setDataFromDict:(NSDictionary*)dict{
//    NSDictionary* floor=[dict objectForKey:@"floor_plan"];
//    [StageModel defaultMapping].
//}


+(NSArray*)stagesForSync{
//    NSPredicate *buildingFilter = [NSPredicate predicateWithFormat:@"changed == %@ AND opened==%@", @(YES), @(NO)];
    NSPredicate *buildingFilter = [NSPredicate predicateWithFormat:@"changed == %@", @(YES)];
    NSArray* stages=[StageModel MR_findAllWithPredicate:buildingFilter];
    return stages;
}

+(NSArray*)stagesToDelete{
    NSPredicate *buildingFilter = [NSPredicate predicateWithFormat:@"deleted == %@", @(YES)];
    NSArray* stages=[StageModel MR_findAllWithPredicate:buildingFilter];
    return stages;
}

+ (NSArray*)getDirtyForServiceLocation:(ServiceLocation*)serviceLocation {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"changed == %@", @(YES)];
    NSArray *attachments = [[serviceLocation.floors array] filteredArrayUsingPredicate:predicate];
    return attachments;
}

-(NSString* )vgPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.vg", documentsDirectory,self.filePath];
    return filePath;
}

-(NSString*) pngPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.png", documentsDirectory,self.filePath];
    return filePath;
}

- (void) download
{
    // work_orders/%d/attachments/%d.pdf?api_key=%@

    [self downloadWithCompletionBlock:nil];
}

- (void) downloadWithCompletionBlock:(DownloadFileCompletionBlock)block
{
    __block BOOL blockCalled=NO;
    NSNumber* locationId=self.serviceLocation.entity_id;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* directoryPath=[NSString stringWithFormat:@"%@/%@", documentsDirectory, locationId];
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:NO attributes:nil error:nil];
    directoryPath=[NSString stringWithFormat:@"%@/%@/%@",documentsDirectory,  locationId,self.building];
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:NO attributes:nil error:nil];
    self.filePath = [NSString stringWithFormat:@"%@/%@/%@",  locationId,self.building, self.floor];
    NSFileManager *mg = [NSFileManager defaultManager];
    NSString *pathVG = [self vgPath];
    NSString *pathPNG = [self pngPath];
    FWRequest* vgDownloadRequest=[FWRequest new];
    FWRequest* pngDownloadRequest=[FWRequest new];
    if (![mg fileExistsAtPath:pathVG]) {
        NSString *url_partVG = self.vg_url;
        [vgDownloadRequest downloadPlan:url_partVG saveToFilePath:pathVG withCompletionBlock:^(FWRequest *request) {
            NSLog(@"File Downloaded %@", pathVG);
            if (block) {
                block(request);
                blockCalled=YES;
            }
        }];
        
    }
    if (![mg fileExistsAtPath:pathPNG]) {
        NSString *url_partIMG = self.image_url;
        [pngDownloadRequest downloadPlan:url_partIMG saveToFilePath:pathPNG withCompletionBlock:^(FWRequest *request) {
            NSLog(@"File Downloaded %@", pathPNG);
//            if (block) {
//                block(request);
//            }
        }];
    }
//    if ((block)&&(!blockCalled)) {
//        block(nil);
//        blockCalled=YES;
//    }
  
}





// Custom logic goes here.

@end
