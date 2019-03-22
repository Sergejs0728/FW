// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UnitInspection.m instead.

#import "_UnitInspection.h"

@implementation UnitInspectionID
@end

@implementation _UnitInspection

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"UnitInspection" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"UnitInspection";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"UnitInspection" inManagedObjectContext:moc_];
}

- (UnitInspectionID*)objectID {
	return (UnitInspectionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"appointment_occurrence_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"appointment_occurrence_id"];
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
	if ([key isEqualToString:@"flat_condition_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"flat_condition_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"flat_type_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"flat_type_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"unit_status_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"unit_status_id"];
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

@dynamic created_at;

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

@dynamic flat_condition_id;

- (int32_t)flat_condition_idValue {
	NSNumber *result = [self flat_condition_id];
	return [result intValue];
}

- (void)setFlat_condition_idValue:(int32_t)value_ {
	[self setFlat_condition_id:@(value_)];
}

- (int32_t)primitiveFlat_condition_idValue {
	NSNumber *result = [self primitiveFlat_condition_id];
	return [result intValue];
}

- (void)setPrimitiveFlat_condition_idValue:(int32_t)value_ {
	[self setPrimitiveFlat_condition_id:@(value_)];
}

@dynamic flat_type_id;

- (int32_t)flat_type_idValue {
	NSNumber *result = [self flat_type_id];
	return [result intValue];
}

- (void)setFlat_type_idValue:(int32_t)value_ {
	[self setFlat_type_id:@(value_)];
}

- (int32_t)primitiveFlat_type_idValue {
	NSNumber *result = [self primitiveFlat_type_id];
	return [result intValue];
}

- (void)setPrimitiveFlat_type_idValue:(int32_t)value_ {
	[self setPrimitiveFlat_type_id:@(value_)];
}

@dynamic notes;

@dynamic service_time;

@dynamic tenant_email_1;

@dynamic tenant_email_2;

@dynamic tenant_name;

@dynamic tenant_phone_1;

@dynamic tenant_phone_2;

@dynamic tenant_signature;

@dynamic unit_number;

@dynamic unit_status_id;

- (int32_t)unit_status_idValue {
	NSNumber *result = [self unit_status_id];
	return [result intValue];
}

- (void)setUnit_status_idValue:(int32_t)value_ {
	[self setUnit_status_id:@(value_)];
}

- (int32_t)primitiveUnit_status_idValue {
	NSNumber *result = [self primitiveUnit_status_id];
	return [result intValue];
}

- (void)setPrimitiveUnit_status_idValue:(int32_t)value_ {
	[self setPrimitiveUnit_status_id:@(value_)];
}

@dynamic updated_at;

@dynamic appointment;

@dynamic material_usages;

- (NSMutableSet<MaterialUsage*>*)material_usagesSet {
	[self willAccessValueForKey:@"material_usages"];

	NSMutableSet<MaterialUsage*> *result = (NSMutableSet<MaterialUsage*>*)[self mutableSetValueForKey:@"material_usages"];

	[self didAccessValueForKey:@"material_usages"];
	return result;
}

@dynamic pests_activities;

- (NSMutableSet<PestActivity*>*)pests_activitiesSet {
	[self willAccessValueForKey:@"pests_activities"];

	NSMutableSet<PestActivity*> *result = (NSMutableSet<PestActivity*>*)[self mutableSetValueForKey:@"pests_activities"];

	[self didAccessValueForKey:@"pests_activities"];
	return result;
}

@end

@implementation UnitInspectionAttributes 
+ (NSString *)appointment_occurrence_id {
	return @"appointment_occurrence_id";
}
+ (NSString *)created_at {
	return @"created_at";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)flat_condition_id {
	return @"flat_condition_id";
}
+ (NSString *)flat_type_id {
	return @"flat_type_id";
}
+ (NSString *)notes {
	return @"notes";
}
+ (NSString *)service_time {
	return @"service_time";
}
+ (NSString *)tenant_email_1 {
	return @"tenant_email_1";
}
+ (NSString *)tenant_email_2 {
	return @"tenant_email_2";
}
+ (NSString *)tenant_name {
	return @"tenant_name";
}
+ (NSString *)tenant_phone_1 {
	return @"tenant_phone_1";
}
+ (NSString *)tenant_phone_2 {
	return @"tenant_phone_2";
}
+ (NSString *)tenant_signature {
	return @"tenant_signature";
}
+ (NSString *)unit_number {
	return @"unit_number";
}
+ (NSString *)unit_status_id {
	return @"unit_status_id";
}
+ (NSString *)updated_at {
	return @"updated_at";
}
@end

@implementation UnitInspectionRelationships 
+ (NSString *)appointment {
	return @"appointment";
}
+ (NSString *)material_usages {
	return @"material_usages";
}
+ (NSString *)pests_activities {
	return @"pests_activities";
}
@end

