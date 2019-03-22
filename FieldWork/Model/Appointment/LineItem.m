#import "LineItem.h"
#import "CDHelper.h"
#import "NSManagedObject+Mapping.h"
#import "Appointment.h"
#import "Estimate.h"

@interface LineItem ()

// Private interface goes here.

@end

@implementation LineItem

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[LineItem entityName]];
    NSMutableDictionary *line_mapping = [[CDHelper mappingForClass:[LineItem class]] mutableCopy];
    
    [line_mapping removeObjectForKey:@"payable_id"];
    [line_mapping removeObjectForKey:@"quantity"];
    [line_mapping removeObjectForKey:@"price"];
    [line_mapping removeObjectForKey:@"total"];
    [line_mapping removeObjectForKey:@"taxable"];
    
    [mapping addAttributesFromDictionary:line_mapping];
    
    [mapping addAttribute:[LineItem intAttributeFor:@"payable_id" andKeyPath:@"payable_id"]];
    [mapping addAttribute:[LineItem floatAttributeFor:@"quantity" andKeyPath:@"quantity"]];
    [mapping addAttribute:[LineItem floatAttributeFor:@"price" andKeyPath:@"price"]];
    [mapping addAttribute:[LineItem floatAttributeFor:@"total" andKeyPath:@"total"]];
    [mapping addAttribute:[LineItem boolAttributeFor:@"taxable" andKeyPath:@"taxable"]];
    
    mapping.primaryKey = @"entity_id";
    
    
    return mapping;
}


+ (LineItem *)newLineItem {
    LineItem *line_item = [LineItem MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [line_item setPayable_type:@"Service"];
    [line_item setLineitem_type:@"service"];
    [line_item setEntity_id:[NSNumber numberWithInt:[Utils RandomId]]];
    [line_item setEntity_status:c_ADDED];
    return line_item;
}


- (void) saveLineItem
{
    if ([self.entity_status isEqualToNumber:c_UNCHANGED]) {
        [self setEntity_status:c_EDITED];
    }
    if(self.appointment){
        [self.appointment setEntity_status:c_EDITED];
    }
    if (self.estimate) {
        [self.estimate setEntity_status:c_EDITED];
    }
    [self.managedObjectContext MR_saveOnlySelfAndWait];
    [self.appointment.managedObjectContext MR_saveOnlySelfAndWait];
}

- (void)discard {
    if ([self.managedObjectContext hasChanges]) {
        [self.managedObjectContext rollback];
        [self.managedObjectContext refreshObject:self mergeChanges:NO];
        NSLog(@"%@", self.entity_id);
    }
    
}
@end
