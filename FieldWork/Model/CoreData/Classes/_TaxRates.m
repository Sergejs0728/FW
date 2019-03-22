// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TaxRates.m instead.

#import "_TaxRates.h"

@implementation TaxRatesID
@end

@implementation _TaxRates

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TaxRates" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TaxRates";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TaxRates" inManagedObjectContext:moc_];
}

- (TaxRatesID*)objectID {
	return (TaxRatesID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

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
	if ([key isEqualToString:@"rateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"service_taxableValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"service_taxable"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic code;

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

@dynamic rate;

- (float)rateValue {
	NSNumber *result = [self rate];
	return [result floatValue];
}

- (void)setRateValue:(float)value_ {
	[self setRate:@(value_)];
}

- (float)primitiveRateValue {
	NSNumber *result = [self primitiveRate];
	return [result floatValue];
}

- (void)setPrimitiveRateValue:(float)value_ {
	[self setPrimitiveRate:@(value_)];
}

@dynamic service_taxable;

- (BOOL)service_taxableValue {
	NSNumber *result = [self service_taxable];
	return [result boolValue];
}

- (void)setService_taxableValue:(BOOL)value_ {
	[self setService_taxable:@(value_)];
}

- (BOOL)primitiveService_taxableValue {
	NSNumber *result = [self primitiveService_taxable];
	return [result boolValue];
}

- (void)setPrimitiveService_taxableValue:(BOOL)value_ {
	[self setPrimitiveService_taxable:@(value_)];
}

@dynamic appointments;

- (NSMutableSet<Appointment*>*)appointmentsSet {
	[self willAccessValueForKey:@"appointments"];

	NSMutableSet<Appointment*> *result = (NSMutableSet<Appointment*>*)[self mutableSetValueForKey:@"appointments"];

	[self didAccessValueForKey:@"appointments"];
	return result;
}

@end

@implementation TaxRatesAttributes 
+ (NSString *)code {
	return @"code";
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
+ (NSString *)rate {
	return @"rate";
}
+ (NSString *)service_taxable {
	return @"service_taxable";
}
@end

@implementation TaxRatesRelationships 
+ (NSString *)appointments {
	return @"appointments";
}
@end

