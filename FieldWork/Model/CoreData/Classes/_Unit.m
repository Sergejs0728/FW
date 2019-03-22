// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Unit.m instead.

#import "_Unit.h"

@implementation UnitID
@end

@implementation _Unit

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Unit" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Unit";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Unit" inManagedObjectContext:moc_];
}

- (UnitID*)objectID {
	return (UnitID*)[super objectID];
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
	if ([key isEqualToString:@"flat_type_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"flat_type_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
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

@dynamic tenant_email_1;

@dynamic tenant_email_2;

@dynamic tenant_name;

@dynamic tenant_phone_1;

@dynamic tenant_phone_2;

@dynamic unit_number;

@dynamic updated_at;

@dynamic service_location;

@end

@implementation UnitAttributes 
+ (NSString *)created_at {
	return @"created_at";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)flat_type_id {
	return @"flat_type_id";
}
+ (NSString *)notes {
	return @"notes";
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
+ (NSString *)unit_number {
	return @"unit_number";
}
+ (NSString *)updated_at {
	return @"updated_at";
}
@end

@implementation UnitRelationships 
+ (NSString *)service_location {
	return @"service_location";
}
@end

