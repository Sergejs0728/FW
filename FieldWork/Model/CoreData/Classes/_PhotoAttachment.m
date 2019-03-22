// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PhotoAttachment.m instead.

#import "_PhotoAttachment.h"

@implementation PhotoAttachmentID
@end

@implementation _PhotoAttachment

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PhotoAttachment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PhotoAttachment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PhotoAttachment" inManagedObjectContext:moc_];
}

- (PhotoAttachmentID*)objectID {
	return (PhotoAttachmentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"appointment_occurrence_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"appointment_occurrence_id"];
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
	if ([key isEqualToString:@"sync_statusValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sync_status"];
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

@dynamic attachment_content_type;

@dynamic attachment_file_name;

@dynamic attachment_file_size;

- (int64_t)attachment_file_sizeValue {
	NSNumber *result = [self attachment_file_size];
	return [result longLongValue];
}

- (void)setAttachment_file_sizeValue:(int64_t)value_ {
	[self setAttachment_file_size:@(value_)];
}

- (int64_t)primitiveAttachment_file_sizeValue {
	NSNumber *result = [self primitiveAttachment_file_size];
	return [result longLongValue];
}

- (void)setPrimitiveAttachment_file_sizeValue:(int64_t)value_ {
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

@dynamic sync_status;

- (int32_t)sync_statusValue {
	NSNumber *result = [self sync_status];
	return [result intValue];
}

- (void)setSync_statusValue:(int32_t)value_ {
	[self setSync_status:@(value_)];
}

- (int32_t)primitiveSync_statusValue {
	NSNumber *result = [self primitiveSync_status];
	return [result intValue];
}

- (void)setPrimitiveSync_statusValue:(int32_t)value_ {
	[self setPrimitiveSync_status:@(value_)];
}

@dynamic updated_at;

@dynamic appointment;

@dynamic estimate;

@end

@implementation PhotoAttachmentAttributes 
+ (NSString *)appointment_occurrence_id {
	return @"appointment_occurrence_id";
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
+ (NSString *)sync_status {
	return @"sync_status";
}
+ (NSString *)updated_at {
	return @"updated_at";
}
@end

@implementation PhotoAttachmentRelationships 
+ (NSString *)appointment {
	return @"appointment";
}
+ (NSString *)estimate {
	return @"estimate";
}
@end

