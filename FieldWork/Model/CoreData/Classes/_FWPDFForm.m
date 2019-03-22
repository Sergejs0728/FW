// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FWPDFForm.m instead.

#import "_FWPDFForm.h"

@implementation FWPDFFormID
@end

@implementation _FWPDFForm

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FWPDFForm" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FWPDFForm";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FWPDFForm" inManagedObjectContext:moc_];
}

- (FWPDFFormID*)objectID {
	return (FWPDFFormID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"appointment_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"appointment_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"document_file_sizeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"document_file_size"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"entity_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"use_acrobatValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"use_acrobat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic appointment_id;

- (int32_t)appointment_idValue {
	NSNumber *result = [self appointment_id];
	return [result intValue];
}

- (void)setAppointment_idValue:(int32_t)value_ {
	[self setAppointment_id:@(value_)];
}

- (int32_t)primitiveAppointment_idValue {
	NSNumber *result = [self primitiveAppointment_id];
	return [result intValue];
}

- (void)setPrimitiveAppointment_idValue:(int32_t)value_ {
	[self setPrimitiveAppointment_id:@(value_)];
}

@dynamic document_content_type;

@dynamic document_file_name;

@dynamic document_file_size;

- (int64_t)document_file_sizeValue {
	NSNumber *result = [self document_file_size];
	return [result longLongValue];
}

- (void)setDocument_file_sizeValue:(int64_t)value_ {
	[self setDocument_file_size:@(value_)];
}

- (int64_t)primitiveDocument_file_sizeValue {
	NSNumber *result = [self primitiveDocument_file_size];
	return [result longLongValue];
}

- (void)setPrimitiveDocument_file_sizeValue:(int64_t)value_ {
	[self setPrimitiveDocument_file_size:@(value_)];
}

@dynamic document_url;

@dynamic entity_id;

- (int32_t)entity_idValue {
	NSNumber *result = [self entity_id];
	return [result intValue];
}

- (void)setEntity_idValue:(int32_t)value_ {
	[self setEntity_id:@(value_)];
}

- (int32_t)primitiveEntity_idValue {
	NSNumber *result = [self primitiveEntity_id];
	return [result intValue];
}

- (void)setPrimitiveEntity_idValue:(int32_t)value_ {
	[self setPrimitiveEntity_id:@(value_)];
}

@dynamic name;

@dynamic use_acrobat;

- (BOOL)use_acrobatValue {
	NSNumber *result = [self use_acrobat];
	return [result boolValue];
}

- (void)setUse_acrobatValue:(BOOL)value_ {
	[self setUse_acrobat:@(value_)];
}

- (BOOL)primitiveUse_acrobatValue {
	NSNumber *result = [self primitiveUse_acrobat];
	return [result boolValue];
}

- (void)setPrimitiveUse_acrobatValue:(BOOL)value_ {
	[self setPrimitiveUse_acrobat:@(value_)];
}

@dynamic appointment;

@dynamic attachment;

- (NSMutableSet<PDFAttachment*>*)attachmentSet {
	[self willAccessValueForKey:@"attachment"];

	NSMutableSet<PDFAttachment*> *result = (NSMutableSet<PDFAttachment*>*)[self mutableSetValueForKey:@"attachment"];

	[self didAccessValueForKey:@"attachment"];
	return result;
}

@dynamic estimate;

@dynamic fields;

- (NSMutableOrderedSet<PDFField*>*)fieldsSet {
	[self willAccessValueForKey:@"fields"];

	NSMutableOrderedSet<PDFField*> *result = (NSMutableOrderedSet<PDFField*>*)[self mutableOrderedSetValueForKey:@"fields"];

	[self didAccessValueForKey:@"fields"];
	return result;
}

@end

@implementation _FWPDFForm (FieldsCoreDataGeneratedAccessors)
- (void)addFields:(NSOrderedSet<PDFField*>*)value_ {
	[self.fieldsSet unionOrderedSet:value_];
}
- (void)removeFields:(NSOrderedSet<PDFField*>*)value_ {
	[self.fieldsSet minusOrderedSet:value_];
}
- (void)addFieldsObject:(PDFField*)value_ {
	[self.fieldsSet addObject:value_];
}
- (void)removeFieldsObject:(PDFField*)value_ {
	[self.fieldsSet removeObject:value_];
}
- (void)insertObject:(PDFField*)value inFieldsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"fields"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self fields] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"fields"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"fields"];
}
- (void)removeObjectFromFieldsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"fields"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self fields] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"fields"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"fields"];
}
- (void)insertFields:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"fields"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self fields] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"fields"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"fields"];
}
- (void)removeFieldsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"fields"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self fields] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"fields"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"fields"];
}
- (void)replaceObjectInFieldsAtIndex:(NSUInteger)idx withObject:(PDFField*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"fields"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self fields] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"fields"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"fields"];
}
- (void)replaceFieldsAtIndexes:(NSIndexSet *)indexes withFields:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"fields"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self fields] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"fields"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"fields"];
}
@end

@implementation FWPDFFormAttributes 
+ (NSString *)appointment_id {
	return @"appointment_id";
}
+ (NSString *)document_content_type {
	return @"document_content_type";
}
+ (NSString *)document_file_name {
	return @"document_file_name";
}
+ (NSString *)document_file_size {
	return @"document_file_size";
}
+ (NSString *)document_url {
	return @"document_url";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)use_acrobat {
	return @"use_acrobat";
}
@end

@implementation FWPDFFormRelationships 
+ (NSString *)appointment {
	return @"appointment";
}
+ (NSString *)attachment {
	return @"attachment";
}
+ (NSString *)estimate {
	return @"estimate";
}
+ (NSString *)fields {
	return @"fields";
}
@end

