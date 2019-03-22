// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PDFAttachment.m instead.

#import "_PDFAttachment.h"

@implementation PDFAttachmentID
@end

@implementation _PDFAttachment

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PDFAttachment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PDFAttachment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PDFAttachment" inManagedObjectContext:moc_];
}

- (PDFAttachmentID*)objectID {
	return (PDFAttachmentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"appointment_occurrence_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"appointment_occurrence_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"attached_pdf_form_file_sizeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"attached_pdf_form_file_size"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"attachment_file_sizeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"attachment_file_size"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"entity_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"entity_statusValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_status"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"pdf_form_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pdf_form_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic appointment_occurrence_id;

- (int32_t)appointment_occurrence_idValue {
	NSNumber *result = [self appointment_occurrence_id];
	return [result intValue];
}

- (void)setAppointment_occurrence_idValue:(int32_t)value_ {
	[self setAppointment_occurrence_id:@(value_)];
}

- (int32_t)primitiveAppointment_occurrence_idValue {
	NSNumber *result = [self primitiveAppointment_occurrence_id];
	return [result intValue];
}

- (void)setPrimitiveAppointment_occurrence_idValue:(int32_t)value_ {
	[self setPrimitiveAppointment_occurrence_id:@(value_)];
}

@dynamic attached_pdf_form_content_type;

@dynamic attached_pdf_form_file_name;

@dynamic attached_pdf_form_file_size;

- (int32_t)attached_pdf_form_file_sizeValue {
	NSNumber *result = [self attached_pdf_form_file_size];
	return [result intValue];
}

- (void)setAttached_pdf_form_file_sizeValue:(int32_t)value_ {
	[self setAttached_pdf_form_file_size:@(value_)];
}

- (int32_t)primitiveAttached_pdf_form_file_sizeValue {
	NSNumber *result = [self primitiveAttached_pdf_form_file_size];
	return [result intValue];
}

- (void)setPrimitiveAttached_pdf_form_file_sizeValue:(int32_t)value_ {
	[self setPrimitiveAttached_pdf_form_file_size:@(value_)];
}

@dynamic attachment_content_type;

@dynamic attachment_file_name;

@dynamic attachment_file_size;

- (int32_t)attachment_file_sizeValue {
	NSNumber *result = [self attachment_file_size];
	return [result intValue];
}

- (void)setAttachment_file_sizeValue:(int32_t)value_ {
	[self setAttachment_file_size:@(value_)];
}

- (int32_t)primitiveAttachment_file_sizeValue {
	NSNumber *result = [self primitiveAttachment_file_size];
	return [result intValue];
}

- (void)setPrimitiveAttachment_file_sizeValue:(int32_t)value_ {
	[self setPrimitiveAttachment_file_size:@(value_)];
}

@dynamic comments;

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

@dynamic entity_status;

- (int32_t)entity_statusValue {
	NSNumber *result = [self entity_status];
	return [result intValue];
}

- (void)setEntity_statusValue:(int32_t)value_ {
	[self setEntity_status:@(value_)];
}

- (int32_t)primitiveEntity_statusValue {
	NSNumber *result = [self primitiveEntity_status];
	return [result intValue];
}

- (void)setPrimitiveEntity_statusValue:(int32_t)value_ {
	[self setPrimitiveEntity_status:@(value_)];
}

@dynamic pdf_file_name;

@dynamic pdf_form_id;

- (int32_t)pdf_form_idValue {
	NSNumber *result = [self pdf_form_id];
	return [result intValue];
}

- (void)setPdf_form_idValue:(int32_t)value_ {
	[self setPdf_form_id:@(value_)];
}

- (int32_t)primitivePdf_form_idValue {
	NSNumber *result = [self primitivePdf_form_id];
	return [result intValue];
}

- (void)setPrimitivePdf_form_idValue:(int32_t)value_ {
	[self setPrimitivePdf_form_id:@(value_)];
}

@dynamic updated_at;

@dynamic appointment;

@dynamic estimate;

@dynamic field_values;

- (NSMutableOrderedSet<PDFField*>*)field_valuesSet {
	[self willAccessValueForKey:@"field_values"];

	NSMutableOrderedSet<PDFField*> *result = (NSMutableOrderedSet<PDFField*>*)[self mutableOrderedSetValueForKey:@"field_values"];

	[self didAccessValueForKey:@"field_values"];
	return result;
}

@dynamic pdf_form;

@end

@implementation _PDFAttachment (Field_valuesCoreDataGeneratedAccessors)
- (void)addField_values:(NSOrderedSet<PDFField*>*)value_ {
	[self.field_valuesSet unionOrderedSet:value_];
}
- (void)removeField_values:(NSOrderedSet<PDFField*>*)value_ {
	[self.field_valuesSet minusOrderedSet:value_];
}
- (void)addField_valuesObject:(PDFField*)value_ {
	[self.field_valuesSet addObject:value_];
}
- (void)removeField_valuesObject:(PDFField*)value_ {
	[self.field_valuesSet removeObject:value_];
}
- (void)insertObject:(PDFField*)value inField_valuesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"field_values"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self field_values] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"field_values"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"field_values"];
}
- (void)removeObjectFromField_valuesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"field_values"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self field_values] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"field_values"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"field_values"];
}
- (void)insertField_values:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"field_values"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self field_values] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"field_values"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"field_values"];
}
- (void)removeField_valuesAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"field_values"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self field_values] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"field_values"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"field_values"];
}
- (void)replaceObjectInField_valuesAtIndex:(NSUInteger)idx withObject:(PDFField*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"field_values"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self field_values] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"field_values"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"field_values"];
}
- (void)replaceField_valuesAtIndexes:(NSIndexSet *)indexes withField_values:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"field_values"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self field_values] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"field_values"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"field_values"];
}
@end

@implementation PDFAttachmentAttributes 
+ (NSString *)appointment_occurrence_id {
	return @"appointment_occurrence_id";
}
+ (NSString *)attached_pdf_form_content_type {
	return @"attached_pdf_form_content_type";
}
+ (NSString *)attached_pdf_form_file_name {
	return @"attached_pdf_form_file_name";
}
+ (NSString *)attached_pdf_form_file_size {
	return @"attached_pdf_form_file_size";
}
+ (NSString *)attachment_content_type {
	return @"attachment_content_type";
}
+ (NSString *)attachment_file_name {
	return @"attachment_file_name";
}
+ (NSString *)attachment_file_size {
	return @"attachment_file_size";
}
+ (NSString *)comments {
	return @"comments";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)pdf_file_name {
	return @"pdf_file_name";
}
+ (NSString *)pdf_form_id {
	return @"pdf_form_id";
}
+ (NSString *)updated_at {
	return @"updated_at";
}
@end

@implementation PDFAttachmentRelationships 
+ (NSString *)appointment {
	return @"appointment";
}
+ (NSString *)estimate {
	return @"estimate";
}
+ (NSString *)field_values {
	return @"field_values";
}
+ (NSString *)pdf_form {
	return @"pdf_form";
}
@end

