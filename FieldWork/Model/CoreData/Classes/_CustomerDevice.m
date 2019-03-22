// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CustomerDevice.m instead.

#import "_CustomerDevice.h"

@implementation CustomerDeviceID
@end

@implementation _CustomerDevice

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CustomerDevice" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CustomerDevice";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CustomerDevice" inManagedObjectContext:moc_];
}

- (CustomerDeviceID*)objectID {
	return (CustomerDeviceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"customer_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"customer_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"device_area_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"device_area_id"];
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
	if ([key isEqualToString:@"service_location_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"service_location_id"];
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

@dynamic barcode;

@dynamic building;

@dynamic customer_id;

- (int32_t)customer_idValue {
	NSNumber *result = [self customer_id];
	return [result intValue];
}

- (void)setCustomer_idValue:(int32_t)value_ {
	[self setCustomer_id:@(value_)];
}

- (int32_t)primitiveCustomer_idValue {
	NSNumber *result = [self primitiveCustomer_id];
	return [result intValue];
}

- (void)setPrimitiveCustomer_idValue:(int32_t)value_ {
	[self setPrimitiveCustomer_id:@(value_)];
}

@dynamic device_area_id;

- (int32_t)device_area_idValue {
	NSNumber *result = [self device_area_id];
	return [result intValue];
}

- (void)setDevice_area_idValue:(int32_t)value_ {
	[self setDevice_area_id:@(value_)];
}

- (int32_t)primitiveDevice_area_idValue {
	NSNumber *result = [self primitiveDevice_area_id];
	return [result intValue];
}

- (void)setPrimitiveDevice_area_idValue:(int32_t)value_ {
	[self setPrimitiveDevice_area_id:@(value_)];
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

@dynamic floor;

@dynamic location_details;

@dynamic notes;

@dynamic number;

@dynamic service_frequency;

@dynamic service_location_id;

- (int32_t)service_location_idValue {
	NSNumber *result = [self service_location_id];
	return [result intValue];
}

- (void)setService_location_idValue:(int32_t)value_ {
	[self setService_location_id:@(value_)];
}

- (int32_t)primitiveService_location_idValue {
	NSNumber *result = [self primitiveService_location_id];
	return [result intValue];
}

- (void)setPrimitiveService_location_idValue:(int32_t)value_ {
	[self setPrimitiveService_location_id:@(value_)];
}

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

@end

@implementation CustomerDeviceAttributes 
+ (NSString *)barcode {
	return @"barcode";
}
+ (NSString *)building {
	return @"building";
}
+ (NSString *)customer_id {
	return @"customer_id";
}
+ (NSString *)device_area_id {
	return @"device_area_id";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)floor {
	return @"floor";
}
+ (NSString *)location_details {
	return @"location_details";
}
+ (NSString *)notes {
	return @"notes";
}
+ (NSString *)number {
	return @"number";
}
+ (NSString *)service_frequency {
	return @"service_frequency";
}
+ (NSString *)service_location_id {
	return @"service_location_id";
}
+ (NSString *)trap_type_id {
	return @"trap_type_id";
}
@end

