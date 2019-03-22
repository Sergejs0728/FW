// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InspectionRecord.m instead.

#import "_InspectionRecord.h"

@implementation InspectionRecordID
@end

@implementation _InspectionRecord

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"InspectionRecord" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"InspectionRecord";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"InspectionRecord" inManagedObjectContext:moc_];
}

- (InspectionRecordID*)objectID {
	return (InspectionRecordID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"bait_condition_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"bait_condition_id"];
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
	if ([key isEqualToString:@"is_cleanValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"is_clean"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"location_area_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"location_area_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"removedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"removed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"trap_condition_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"trap_condition_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"trap_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"trap_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"trap_type_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"trap_type_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic bait_condition_id;

- (int32_t)bait_condition_idValue {
	NSNumber *result = [self bait_condition_id];
	return [result intValue];
}

- (void)setBait_condition_idValue:(int32_t)value_ {
	[self setBait_condition_id:@(value_)];
}

- (int32_t)primitiveBait_condition_idValue {
	NSNumber *result = [self primitiveBait_condition_id];
	return [result intValue];
}

- (void)setPrimitiveBait_condition_idValue:(int32_t)value_ {
	[self setPrimitiveBait_condition_id:@(value_)];
}

@dynamic barcode;

@dynamic building;

@dynamic device_number;

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

@dynamic evidence;

@dynamic evidence_ids;

@dynamic exception;

@dynamic floor;

@dynamic is_clean;

- (BOOL)is_cleanValue {
	NSNumber *result = [self is_clean];
	return [result boolValue];
}

- (void)setIs_cleanValue:(BOOL)value_ {
	[self setIs_clean:@(value_)];
}

- (BOOL)primitiveIs_cleanValue {
	NSNumber *result = [self primitiveIs_clean];
	return [result boolValue];
}

- (void)setPrimitiveIs_cleanValue:(BOOL)value_ {
	[self setPrimitiveIs_clean:@(value_)];
}

@dynamic location_area_id;

- (int32_t)location_area_idValue {
	NSNumber *result = [self location_area_id];
	return [result intValue];
}

- (void)setLocation_area_idValue:(int32_t)value_ {
	[self setLocation_area_id:@(value_)];
}

- (int32_t)primitiveLocation_area_idValue {
	NSNumber *result = [self primitiveLocation_area_id];
	return [result intValue];
}

- (void)setPrimitiveLocation_area_idValue:(int32_t)value_ {
	[self setPrimitiveLocation_area_id:@(value_)];
}

@dynamic location_details;

@dynamic notes;

@dynamic removed;

- (BOOL)removedValue {
	NSNumber *result = [self removed];
	return [result boolValue];
}

- (void)setRemovedValue:(BOOL)value_ {
	[self setRemoved:@(value_)];
}

- (BOOL)primitiveRemovedValue {
	NSNumber *result = [self primitiveRemoved];
	return [result boolValue];
}

- (void)setPrimitiveRemovedValue:(BOOL)value_ {
	[self setPrimitiveRemoved:@(value_)];
}

@dynamic scanned_on;

@dynamic trap_condition_id;

- (int32_t)trap_condition_idValue {
	NSNumber *result = [self trap_condition_id];
	return [result intValue];
}

- (void)setTrap_condition_idValue:(int32_t)value_ {
	[self setTrap_condition_id:@(value_)];
}

- (int32_t)primitiveTrap_condition_idValue {
	NSNumber *result = [self primitiveTrap_condition_id];
	return [result intValue];
}

- (void)setPrimitiveTrap_condition_idValue:(int32_t)value_ {
	[self setPrimitiveTrap_condition_id:@(value_)];
}

@dynamic trap_id;

- (int32_t)trap_idValue {
	NSNumber *result = [self trap_id];
	return [result intValue];
}

- (void)setTrap_idValue:(int32_t)value_ {
	[self setTrap_id:@(value_)];
}

- (int32_t)primitiveTrap_idValue {
	NSNumber *result = [self primitiveTrap_id];
	return [result intValue];
}

- (void)setPrimitiveTrap_idValue:(int32_t)value_ {
	[self setPrimitiveTrap_id:@(value_)];
}

@dynamic trap_number;

@dynamic trap_type_id;

- (int32_t)trap_type_idValue {
	NSNumber *result = [self trap_type_id];
	return [result intValue];
}

- (void)setTrap_type_idValue:(int32_t)value_ {
	[self setTrap_type_id:@(value_)];
}

- (int32_t)primitiveTrap_type_idValue {
	NSNumber *result = [self primitiveTrap_type_id];
	return [result intValue];
}

- (void)setPrimitiveTrap_type_idValue:(int32_t)value_ {
	[self setPrimitiveTrap_type_id:@(value_)];
}

@dynamic appointment;

@dynamic material_usages;

- (NSMutableSet<MaterialUsage*>*)material_usagesSet {
	[self willAccessValueForKey:@"material_usages"];

	NSMutableSet<MaterialUsage*> *result = (NSMutableSet<MaterialUsage*>*)[self mutableSetValueForKey:@"material_usages"];

	[self didAccessValueForKey:@"material_usages"];
	return result;
}

@dynamic pests_records;

- (NSMutableSet<InspectionPest*>*)pests_recordsSet {
	[self willAccessValueForKey:@"pests_records"];

	NSMutableSet<InspectionPest*> *result = (NSMutableSet<InspectionPest*>*)[self mutableSetValueForKey:@"pests_records"];

	[self didAccessValueForKey:@"pests_records"];
	return result;
}

@end

@implementation InspectionRecordAttributes 
+ (NSString *)bait_condition_id {
	return @"bait_condition_id";
}
+ (NSString *)barcode {
	return @"barcode";
}
+ (NSString *)building {
	return @"building";
}
+ (NSString *)device_number {
	return @"device_number";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)evidence {
	return @"evidence";
}
+ (NSString *)evidence_ids {
	return @"evidence_ids";
}
+ (NSString *)exception {
	return @"exception";
}
+ (NSString *)floor {
	return @"floor";
}
+ (NSString *)is_clean {
	return @"is_clean";
}
+ (NSString *)location_area_id {
	return @"location_area_id";
}
+ (NSString *)location_details {
	return @"location_details";
}
+ (NSString *)notes {
	return @"notes";
}
+ (NSString *)removed {
	return @"removed";
}
+ (NSString *)scanned_on {
	return @"scanned_on";
}
+ (NSString *)trap_condition_id {
	return @"trap_condition_id";
}
+ (NSString *)trap_id {
	return @"trap_id";
}
+ (NSString *)trap_number {
	return @"trap_number";
}
+ (NSString *)trap_type_id {
	return @"trap_type_id";
}
@end

@implementation InspectionRecordRelationships 
+ (NSString *)appointment {
	return @"appointment";
}
+ (NSString *)material_usages {
	return @"material_usages";
}
+ (NSString *)pests_records {
	return @"pests_records";
}
@end

