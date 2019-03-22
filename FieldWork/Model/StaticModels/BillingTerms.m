#import "BillingTerms.h"
#import "CDHelper.h"

@interface BillingTerms ()

// Private interface goes here.

@end

@implementation BillingTerms

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[BillingTerms entityName]];
    NSDictionary *dict = [CDHelper mappingForClass:[BillingTerms class]];
    [mapping addAttributesFromDictionary:dict];
    mapping.primaryKey = @"entity_id";
    
    
    return mapping;
}

+(NSMutableArray *)fetchAll{
    return [[BillingTerms MR_findAll] mutableCopy];
}

+ (BillingTerms *) getbillingTermsById:(int)billing_term_id{
    return [BillingTerms MR_findFirstByAttribute:@"entity_id" withValue:[NSNumber numberWithInt:billing_term_id]];
    
}

@end
