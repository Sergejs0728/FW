// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MaterialUsageRecord.m instead.

#import "_MaterialUsageRecord.h"

@implementation MaterialUsageRecordID
@end

@implementation _MaterialUsageRecord

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MaterialUsageRecord" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MaterialUsageRecord";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MaterialUsageRecord" inManagedObjectContext:moc_];
}

- (MaterialUsageRecordID*)objectID {
	return (MaterialUsageRecordID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"amountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"amount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"application_device_type_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"application_device_type_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"application_method_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"application_method_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"dilution_rate_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"dilution_rate_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"entity_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"location_area_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"location_area_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic amount;

- (float)amountValue {
	NSNumber *result = [self amount];
	return [result floatValue];
}

- (void)setAmountValue:(float)value_ {
	[self setAmount:@(value_)];
}

- (float)primitiveAmountValue {
	NSNumber *result = [self primitiveAmount];
	return [result floatValue];
}

- (void)setPrimitiveAmountValue:(float)value_ {
	[self setPrimitiveAmount:@(value_)];
}

@dynamic application_device_type_id;

- (int32_t)application_device_type_idValue {
	NSNumber *result = [self application_device_type_id];
	return [result intValue];
}

- (void)setApplication_device_type_idValue:(int32_t)value_ {
	[self setApplication_device_type_id:@(value_)];
}

- (int32_t)primitiveApplication_device_type_idValue {
	NSNumber *result = [self primitiveApplication_device_type_id];
	return [result intValue];
}

- (void)setPrimitiveApplication_device_type_idValue:(int32_t)value_ {
	[self setPrimitiveApplication_device_type_id:@(value_)];
}

@dynamic application_method;

@dynamic application_method_id;

- (int32_t)application_method_idValue {
	NSNumber *result = [self application_method_id];
	return [result intValue];
}

- (void)setApplication_method_idValue:(int32_t)value_ {
	[self setApplication_method_id:@(value_)];
}

- (int32_t)primitiveApplication_method_idValue {
	NSNumber *result = [self primitiveApplication_method_id];
	return [result intValue];
}

- (void)setPrimitiveApplication_method_idValue:(int32_t)value_ {
	[self setPrimitiveApplication_method_id:@(value_)];
}

@dynamic device;

@dynamic dilution_rate_id;

- (int32_t)dilution_rate_idValue {
	NSNumber *result = [self dilution_rate_id];
	return [result intValue];
}

- (void)setDilution_rate_idValue:(int32_t)value_ {
	[self setDilution_rate_id:@(value_)];
}

- (int32_t)primitiveDilution_rate_idValue {
	NSNumber *result = [self primitiveDilution_rate_id];
	return [result intValue];
}

- (void)setPrimitiveDilution_rate_idValue:(int32_t)value_ {
	[self setPrimitiveDilution_rate_id:@(value_)];
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

@dynamic lot_number;

@dynamic measurement;

@dynamic target_pests;

- (NSMutableSet<TargetPest*>*)target_pestsSet {
	[self willAccessValueForKey:@"target_pests"];

	NSMutableSet<TargetPest*> *result = (NSMutableSet<TargetPest*>*)[self mutableSetValueForKey:@"target_pests"];

	[self didAccessValueForKey:@"target_pests"];
	return result;
}

@end

@implementation MaterialUsageRecordAttributes 
+ (NSString *)amount {
	return @"amount";
}
+ (NSString *)application_device_type_id {
	return @"application_device_type_id";
}
+ (NSString *)application_method {
	return @"application_method";
}
+ (NSString *)application_method_id {
	return @"application_method_id";
}
+ (NSString *)device {
	return @"device";
}
+ (NSString *)dilution_rate_id {
	return @"dilution_rate_id";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)location_area_id {
	return @"location_area_id";
}
+ (NSString *)lot_number {
	return @"lot_number";
}
+ (NSString *)measurement {
	return @"measurement";
}
@end

@implementation MaterialUsageRecordRelationships 
+ (NSString *)target_pests {
	return @"target_pests";
}
@end

