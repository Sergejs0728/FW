// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MaterialUsage.m instead.

#import "_MaterialUsage.h"

@implementation MaterialUsageID
@end

@implementation _MaterialUsage

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MaterialUsage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MaterialUsage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MaterialUsage" inManagedObjectContext:moc_];
}

- (MaterialUsageID*)objectID {
	return (MaterialUsageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

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
	if ([key isEqualToString:@"inspection_record_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"inspection_record_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"material_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"material_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

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

@dynamic inspection_record_id;

- (int32_t)inspection_record_idValue {
	NSNumber *result = [self inspection_record_id];
	return [result intValue];
}

- (void)setInspection_record_idValue:(int32_t)value_ {
	[self setInspection_record_id:@(value_)];
}

- (int32_t)primitiveInspection_record_idValue {
	NSNumber *result = [self primitiveInspection_record_id];
	return [result intValue];
}

- (void)setPrimitiveInspection_record_idValue:(int32_t)value_ {
	[self setPrimitiveInspection_record_id:@(value_)];
}

@dynamic material_id;

- (int32_t)material_idValue {
	NSNumber *result = [self material_id];
	return [result intValue];
}

- (void)setMaterial_idValue:(int32_t)value_ {
	[self setMaterial_id:@(value_)];
}

- (int32_t)primitiveMaterial_idValue {
	NSNumber *result = [self primitiveMaterial_id];
	return [result intValue];
}

- (void)setPrimitiveMaterial_idValue:(int32_t)value_ {
	[self setPrimitiveMaterial_id:@(value_)];
}

@dynamic notes;

@dynamic appointment;

@dynamic material_usage_records;

- (NSMutableSet<MaterialUsageRecord*>*)material_usage_recordsSet {
	[self willAccessValueForKey:@"material_usage_records"];

	NSMutableSet<MaterialUsageRecord*> *result = (NSMutableSet<MaterialUsageRecord*>*)[self mutableSetValueForKey:@"material_usage_records"];

	[self didAccessValueForKey:@"material_usage_records"];
	return result;
}

@end

@implementation MaterialUsageAttributes 
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)inspection_record_id {
	return @"inspection_record_id";
}
+ (NSString *)material_id {
	return @"material_id";
}
+ (NSString *)notes {
	return @"notes";
}
@end

@implementation MaterialUsageRelationships 
+ (NSString *)appointment {
	return @"appointment";
}
+ (NSString *)material_usage_records {
	return @"material_usage_records";
}
@end

