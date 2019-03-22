#import "Unit.h"
#import "NSManagedObject+Mapping.h"

@interface Unit ()

// Private interface goes here.

@end

@implementation Unit
+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Unit entityName]];
    [mapping addAttribute:[Unit dateTimeGMT0AttributeFor:@"updated_at" andKeyPath:@"updated_at"]];
    [mapping addAttribute:[Unit dateTimeGMT0AttributeFor:@"created_at" andKeyPath:@"created_at"]];
    [mapping addAttribute:[Unit stringAttributeFor:@"unit_number" andKeyPath:@"unit_number"]];
    [mapping addAttribute:[Unit intAttributeFor:@"flat_type_id" andKeyPath:@"flat_type_id"]];
    [mapping addAttribute:[Unit stringAttributeFor:@"notes" andKeyPath:@"notes"]];
    [mapping addAttribute:[Unit stringAttributeFor:@"tenant_name" andKeyPath:@"tenant_name"]];
    [mapping addAttribute:[Unit stringAttributeFor:@"tenant_email_1" andKeyPath:@"tenant_email_1"]];
    [mapping addAttribute:[Unit stringAttributeFor:@"tenant_email_2" andKeyPath:@"tenant_email_2"]];
    [mapping addAttribute:[Unit stringAttributeFor:@"tenant_phone_1" andKeyPath:@"tenant_phone_1"]];
    [mapping addAttribute:[Unit stringAttributeFor:@"tenant_phone_2" andKeyPath:@"tenant_phone_2"]];
    [mapping addAttribute:[Unit intAttributeFor:@"entity_id" andKeyPath:@"id"]];

    mapping.primaryKey=@"entity_id";
    return mapping;
}

+ (FEMMapping *)reverseMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Unit entityName]];
    NSDictionary *mapping_dict = @{@"unit_number":@"unit_number",
                                   @"flat_type_id":@"flat_type_id",
                                   @"tenant_name":@"tenant_name",
                                   @"tenant_phone_1":@"tenant_phone_1",
                                   @"tenant_phone_2":@"tenant_phone_2",
                                   @"tenant_email_1":@"tenant_email_1",
                                   @"tenant_email_2":@"tenant_email_2",
                                   @"notes":@"notes"
                                    };
    [mapping addAttributesFromDictionary:mapping_dict];
    return mapping;
}

+ (Unit*)unitWithUnitNumber:(NSString*)unitNumber serviceLocation:(ServiceLocation*)serviceLocation {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"unit_number == %@", unitNumber];
    NSArray *flats = [[serviceLocation.flats allObjects] filteredArrayUsingPredicate:predicate];
    Unit *record = flats.firstObject;
    return record;
}

- (void) saveForServiceLocation:(ServiceLocation*)serviceLocation completion:(ItemSavedBlock)completion
{
    
    NSDictionary *dict = [FEMSerializer serializeObject:self usingMapping:[Unit reverseMapping]];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    if (dict) {
        
        NSString *url = [NSString stringWithFormat:API_UNITS, serviceLocation.customer.entity_id, serviceLocation.entity_id];
        RequestMethod method = POST;
        [FWRequest requestWithURLPart:url method:method dict:dict block:^(BOOL success, FWRequest *request) {
            if (success) {
                [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
                    NSDictionary *dict = [request.serverData objectForKey:@"flat"];
                    BOOL saved = YES;
                    @try {
                        [FEMDeserializer fillObject:self fromRepresentation:dict mapping:[Unit defaultMapping]];
                    } @catch (NSException *exception) {
                        saved = NO;
                    } @finally {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (completion) {
                                completion(self, saved, nil);
                            }
                        });
                    }
                }];
            } else {
                if (completion) {
                    completion(self, NO, request.error.localizedDescription);
                }
            }
        }];
        
        
    }
    
    
}



@end
