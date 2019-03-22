#import "PDFField.h"
#import "CDHelper.h"
#import "FEMAttribute.h"
#import "NSManagedObject+Mapping.h"
#import "FWPDFForm.h"

@interface PDFField ()

// Private interface goes here.

@end

@implementation PDFField

// Custom logic goes here.
+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[PDFField entityName]];
    [mapping addAttribute:[PDFField intAttributeFor:@"max_length" andKeyPath:@"max_length"]];
    [mapping addAttribute:[PDFField boolAttributeFor:@"required" andKeyPath:@"required"]];
    [mapping addAttribute:[PDFField boolAttributeFor:@"hidden" andKeyPath:@"hidden"]];
    [mapping addAttribute:[PDFField stringAttributeFor:@"label" andKeyPath:@"label"]];
    [mapping addAttribute:[PDFField stringAttributeFor:@"pdf_name" andKeyPath:@"pdf_name"]];
    [mapping addAttribute:[PDFField stringAttributeFor:@"name" andKeyPath:@"name"]];
    [mapping addAttribute:[PDFField stringAttributeFor:@"field_type" andKeyPath:@"type"]];
    [mapping addAttribute:[PDFField stringAttributeFor:@"field_value" andKeyPath:@"value"]];
    [mapping addAttribute:[PDFField stringAttributeFor:@"default_value" andKeyPath:@"default"]];
    [mapping addAttribute:[FEMAttribute mappingOfProperty:@"options" toKeyPath:@"options" map:^id(id value) {
        if ( [value isKindOfClass:NSArray.class]) {
            return (NSArray*)value;
        }
        return value;
    } reverseMap:nil]];
    [mapping addAttribute:[FEMAttribute mappingOfProperty:@"selected_options" toKeyPath:@"selected_options" map:^id(id value) {
        if ( [value isKindOfClass:NSArray.class]) {
            return (NSArray*)value;
        }
        return value;
    } reverseMap:nil]];
    
    return mapping;
}


- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    PDFField *field = [PDFField MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    field.default_value = self.default_value;
    field.field_value = self.field_value;
    field.field_type = self.field_type;
    field.label = self.label;
    field.name = self.name;
    field.pdf_name = self.pdf_name;
    field.required = self.required;
    field.hidden = self.hidden;
    field.max_length = self.max_length;
    field.options = self.options;
    field.selected_options = self.selected_options;
    return field;
}

@end
