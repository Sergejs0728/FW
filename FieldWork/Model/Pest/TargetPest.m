#import "TargetPest.h"
#import "NSManagedObject+Mapping.h"

@interface TargetPest ()

// Private interface goes here.

@end

@implementation TargetPest

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[TargetPest entityName]];
    [mapping addAttribute:[TargetPest intAttributeFor:@"pest_type_id" andKeyPath:@"pest_type_id"]];
    [mapping addAttribute:[TargetPest intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+(FEMMapping *)reverseMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[TargetPest entityName]];
    NSDictionary *appt_mapping_dict = @{@"pest_type_id":@"pest_type_id"
                                        };
    
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    return mapping;
}

+ (TargetPest *)newTargetPestWithPestId:(NSNumber *)pest_id {
    return [self newTargetPestWithPestId:pest_id inContext:[NSManagedObjectContext MR_defaultContext]];
}

+ (TargetPest *)newTargetPestWithPestId:(NSNumber *)pest_id inContext:(NSManagedObjectContext*)context {
    TargetPest *tp = [TargetPest MR_createEntityInContext:context];
    [tp setEntity_id:[NSNumber numberWithInt:[Utils RandomId]]];
    [tp setPest_type_id:pest_id];
    return tp;
}

- (Pest*) getPest
{
    return [Pest MR_findFirstByAttribute:@"entity_id" withValue:self.pest_type_id];
}

+(NSMutableArray *)getPestIdsByTargetPests:(NSMutableArray *)arr{
    NSMutableArray * temp = [[NSMutableArray alloc]init];
    for (TargetPest *tp in arr) {
        [temp addObject:tp];
    }
    return temp;
}

@end
