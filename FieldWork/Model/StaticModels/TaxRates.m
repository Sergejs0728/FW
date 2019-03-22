#import "TaxRates.h"
#import "NSManagedObject+Mapping.h"

@interface TaxRates ()

// Private interface goes here.

@end

@implementation TaxRates

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[TaxRates entityName]];
    [mapping addAttribute:[TaxRates floatAttributeFor:@"rate" andKeyPath:@"total_sales_tax"]];
    [mapping addAttribute:[TaxRates stringAttributeFor:@"name" andKeyPath:@"name"]];
    [mapping addAttribute:[TaxRates stringAttributeFor:@"code" andKeyPath:@"code"]];
    [mapping addAttribute:[TaxRates boolAttributeFor:@"service_taxable" andKeyPath:@"service_taxable"]];
    [mapping addAttribute:[TaxRates boolAttributeFor:@"is_default" andKeyPath:@"is_default"]];
    [mapping addAttribute:[TaxRates intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    mapping.primaryKey = @"entity_id";
    return mapping;
}


+ (NSMutableArray *)fetchAll{
    return [[TaxRates MR_findAllSortedBy:@"name" ascending:YES]mutableCopy];
}

+ (TaxRates *)getTaxRatesById:(NSNumber *)tax_rate_id {
//    [TaxRates printLog];
    return [TaxRates MR_findFirstByAttribute:@"entity_id" withValue:tax_rate_id];
}

+ (TaxRates *)getTaxRatesById:(NSNumber *)tax_rate_id inContext:(NSManagedObjectContext*)context {
//    [TaxRates printLog];
    return [TaxRates MR_findFirstByAttribute:@"entity_id" withValue:tax_rate_id inContext:context];
}

+(void)printLog{
     NSMutableArray *arr = [[TaxRates MR_findAll] mutableCopy];
    for (TaxRates *tr in arr) {
        NSLog(@"Id %@ and Rate %@",tr.entity_id,tr.rate);
    }
    
}

+ (void)retriveTaxRate:(NSNumber *)taxRateId withBlock:(ItemLoadedBlock)block {
    NSString *url = [NSString stringWithFormat:API_TAX_RATE, taxRateId];
    
    [FWRequest requestWithURLPart:url method:GET dict:nil block:^(BOOL success, FWRequest *request) {
        if (success) {
            __block TaxRates *taxRate = nil;
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                @try {
                    taxRate = [FEMDeserializer objectFromRepresentation:request.serverData mapping:[TaxRates defaultMapping] context:localContext];
                }
                @catch (NSException *exception) {
                    
                }
            } completion:^(BOOL contextDidSave, NSError *error) {
                if (block) {
                    block(taxRate, nil);
                }
            }];
        } else {
            if (block) {
                block(self, [request errorMessageFromError:request.error]);
            }
            
        }
    }];
}


@end
