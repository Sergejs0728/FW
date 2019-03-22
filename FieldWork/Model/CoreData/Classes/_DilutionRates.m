// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DilutionRates.m instead.

#import "_DilutionRates.h"

@implementation DilutionRatesID
@end

@implementation _DilutionRates

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"DilutionRates" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"DilutionRates";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"DilutionRates" inManagedObjectContext:moc_];
}

- (DilutionRatesID*)objectID {
	return (DilutionRatesID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"account_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"account_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"entity_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"entity_id1Value"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_id1"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic account_id;

- (int32_t)account_idValue {
	NSNumber *result = [self account_id];
	return [result intValue];
}

- (void)setAccount_idValue:(int32_t)value_ {
	[self setAccount_id:@(value_)];
}

- (int32_t)primitiveAccount_idValue {
	NSNumber *result = [self primitiveAccount_id];
	return [result intValue];
}

- (void)setPrimitiveAccount_idValue:(int32_t)value_ {
	[self setPrimitiveAccount_id:@(value_)];
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

@dynamic entity_id1;

- (int32_t)entity_id1Value {
	NSNumber *result = [self entity_id1];
	return [result intValue];
}

- (void)setEntity_id1Value:(int32_t)value_ {
	[self setEntity_id1:@(value_)];
}

- (int32_t)primitiveEntity_id1Value {
	NSNumber *result = [self primitiveEntity_id1];
	return [result intValue];
}

- (void)setPrimitiveEntity_id1Value:(int32_t)value_ {
	[self setPrimitiveEntity_id1:@(value_)];
}

@dynamic name;

@dynamic name1;

@dynamic updated_at;

@end

@implementation DilutionRatesAttributes 
+ (NSString *)account_id {
	return @"account_id";
}
+ (NSString *)created_at {
	return @"created_at";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_id1 {
	return @"entity_id1";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)name1 {
	return @"name1";
}
+ (NSString *)updated_at {
	return @"updated_at";
}
@end

