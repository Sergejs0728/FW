// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Material.m instead.

#import "_Material.h"

@implementation MaterialID
@end

@implementation _Material

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Material" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Material";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Material" inManagedObjectContext:moc_];
}

- (MaterialID*)objectID {
	return (MaterialID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"default_dilution_rate_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"default_dilution_rate_id"];
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
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic active_ingredient;

@dynamic active_ingredient_percent;

@dynamic default_dilution_rate_id;

- (int32_t)default_dilution_rate_idValue {
	NSNumber *result = [self default_dilution_rate_id];
	return [result intValue];
}

- (void)setDefault_dilution_rate_idValue:(int32_t)value_ {
	[self setDefault_dilution_rate_id:@(value_)];
}

- (int32_t)primitiveDefault_dilution_rate_idValue {
	NSNumber *result = [self primitiveDefault_dilution_rate_id];
	return [result intValue];
}

- (void)setPrimitiveDefault_dilution_rate_idValue:(int32_t)value_ {
	[self setPrimitiveDefault_dilution_rate_id:@(value_)];
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

@dynamic epa_number;

@dynamic name;

@dynamic price;

- (float)priceValue {
	NSNumber *result = [self price];
	return [result floatValue];
}

- (void)setPriceValue:(float)value_ {
	[self setPrice:@(value_)];
}

- (float)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result floatValue];
}

- (void)setPrimitivePriceValue:(float)value_ {
	[self setPrimitivePrice:@(value_)];
}

@end

@implementation MaterialAttributes 
+ (NSString *)active_ingredient {
	return @"active_ingredient";
}
+ (NSString *)active_ingredient_percent {
	return @"active_ingredient_percent";
}
+ (NSString *)default_dilution_rate_id {
	return @"default_dilution_rate_id";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)epa_number {
	return @"epa_number";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)price {
	return @"price";
}
@end

