// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BillingTerms.m instead.

#import "_BillingTerms.h"

@implementation BillingTermsID
@end

@implementation _BillingTerms

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BillingTerms" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BillingTerms";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BillingTerms" inManagedObjectContext:moc_];
}

- (BillingTermsID*)objectID {
	return (BillingTermsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"daysValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"days"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"entity_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"is_defaultValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"is_default"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic days;

- (int32_t)daysValue {
	NSNumber *result = [self days];
	return [result intValue];
}

- (void)setDaysValue:(int32_t)value_ {
	[self setDays:@(value_)];
}

- (int32_t)primitiveDaysValue {
	NSNumber *result = [self primitiveDays];
	return [result intValue];
}

- (void)setPrimitiveDaysValue:(int32_t)value_ {
	[self setPrimitiveDays:@(value_)];
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

@dynamic is_default;

- (BOOL)is_defaultValue {
	NSNumber *result = [self is_default];
	return [result boolValue];
}

- (void)setIs_defaultValue:(BOOL)value_ {
	[self setIs_default:@(value_)];
}

- (BOOL)primitiveIs_defaultValue {
	NSNumber *result = [self primitiveIs_default];
	return [result boolValue];
}

- (void)setPrimitiveIs_defaultValue:(BOOL)value_ {
	[self setPrimitiveIs_default:@(value_)];
}

@dynamic name;

@end

@implementation BillingTermsAttributes 
+ (NSString *)days {
	return @"days";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)is_default {
	return @"is_default";
}
+ (NSString *)name {
	return @"name";
}
@end

