// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PestActivity.m instead.

#import "_PestActivity.h"

@implementation PestActivityID
@end

@implementation _PestActivity

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PestActivity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PestActivity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PestActivity" inManagedObjectContext:moc_];
}

- (PestActivityID*)objectID {
	return (PestActivityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"activity_level_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"activity_level_id"];
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
	if ([key isEqualToString:@"pest_type_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pest_type_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"unit_record_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"unit_record_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic activity_level_id;

- (int32_t)activity_level_idValue {
	NSNumber *result = [self activity_level_id];
	return [result intValue];
}

- (void)setActivity_level_idValue:(int32_t)value_ {
	[self setActivity_level_id:@(value_)];
}

- (int32_t)primitiveActivity_level_idValue {
	NSNumber *result = [self primitiveActivity_level_id];
	return [result intValue];
}

- (void)setPrimitiveActivity_level_idValue:(int32_t)value_ {
	[self setPrimitiveActivity_level_id:@(value_)];
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

@dynamic pest_type_id;

- (int32_t)pest_type_idValue {
	NSNumber *result = [self pest_type_id];
	return [result intValue];
}

- (void)setPest_type_idValue:(int32_t)value_ {
	[self setPest_type_id:@(value_)];
}

- (int32_t)primitivePest_type_idValue {
	NSNumber *result = [self primitivePest_type_id];
	return [result intValue];
}

- (void)setPrimitivePest_type_idValue:(int32_t)value_ {
	[self setPrimitivePest_type_id:@(value_)];
}

@dynamic unit_record_id;

- (int32_t)unit_record_idValue {
	NSNumber *result = [self unit_record_id];
	return [result intValue];
}

- (void)setUnit_record_idValue:(int32_t)value_ {
	[self setUnit_record_id:@(value_)];
}

- (int32_t)primitiveUnit_record_idValue {
	NSNumber *result = [self primitiveUnit_record_id];
	return [result intValue];
}

- (void)setPrimitiveUnit_record_idValue:(int32_t)value_ {
	[self setPrimitiveUnit_record_id:@(value_)];
}

@dynamic updated_at;

@end

@implementation PestActivityAttributes 
+ (NSString *)activity_level_id {
	return @"activity_level_id";
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
+ (NSString *)pest_type_id {
	return @"pest_type_id";
}
+ (NSString *)unit_record_id {
	return @"unit_record_id";
}
+ (NSString *)updated_at {
	return @"updated_at";
}
@end

