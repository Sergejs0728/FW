// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PDFField.m instead.

#import "_PDFField.h"

@implementation PDFFieldID
@end

@implementation _PDFField

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PDFField" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PDFField";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PDFField" inManagedObjectContext:moc_];
}

- (PDFFieldID*)objectID {
	return (PDFFieldID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"hiddenValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hidden"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"max_lengthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"max_length"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"requiredValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"required"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic default_value;

@dynamic field_type;

@dynamic field_value;

@dynamic hidden;

- (BOOL)hiddenValue {
	NSNumber *result = [self hidden];
	return [result boolValue];
}

- (void)setHiddenValue:(BOOL)value_ {
	[self setHidden:@(value_)];
}

- (BOOL)primitiveHiddenValue {
	NSNumber *result = [self primitiveHidden];
	return [result boolValue];
}

- (void)setPrimitiveHiddenValue:(BOOL)value_ {
	[self setPrimitiveHidden:@(value_)];
}

@dynamic label;

@dynamic max_length;

- (int32_t)max_lengthValue {
	NSNumber *result = [self max_length];
	return [result intValue];
}

- (void)setMax_lengthValue:(int32_t)value_ {
	[self setMax_length:@(value_)];
}

- (int32_t)primitiveMax_lengthValue {
	NSNumber *result = [self primitiveMax_length];
	return [result intValue];
}

- (void)setPrimitiveMax_lengthValue:(int32_t)value_ {
	[self setPrimitiveMax_length:@(value_)];
}

@dynamic name;

@dynamic options;

@dynamic pdf_name;

@dynamic required;

- (BOOL)requiredValue {
	NSNumber *result = [self required];
	return [result boolValue];
}

- (void)setRequiredValue:(BOOL)value_ {
	[self setRequired:@(value_)];
}

- (BOOL)primitiveRequiredValue {
	NSNumber *result = [self primitiveRequired];
	return [result boolValue];
}

- (void)setPrimitiveRequiredValue:(BOOL)value_ {
	[self setPrimitiveRequired:@(value_)];
}

@dynamic selected_options;

@dynamic pdf_attachment;

@dynamic pdf_form;

@end

@implementation PDFFieldAttributes 
+ (NSString *)default_value {
	return @"default_value";
}
+ (NSString *)field_type {
	return @"field_type";
}
+ (NSString *)field_value {
	return @"field_value";
}
+ (NSString *)hidden {
	return @"hidden";
}
+ (NSString *)label {
	return @"label";
}
+ (NSString *)max_length {
	return @"max_length";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)options {
	return @"options";
}
+ (NSString *)pdf_name {
	return @"pdf_name";
}
+ (NSString *)required {
	return @"required";
}
+ (NSString *)selected_options {
	return @"selected_options";
}
@end

@implementation PDFFieldRelationships 
+ (NSString *)pdf_attachment {
	return @"pdf_attachment";
}
+ (NSString *)pdf_form {
	return @"pdf_form";
}
@end

