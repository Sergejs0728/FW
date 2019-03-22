// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LineItem.m instead.

#import "_LineItem.h"

@implementation LineItemID
@end

@implementation _LineItem

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LineItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LineItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LineItem" inManagedObjectContext:moc_];
}

- (LineItemID*)objectID {
	return (LineItemID*)[super objectID];
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
	if ([key isEqualToString:@"payable_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"payable_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"quantityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"quantity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"taxableValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"taxable"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"totalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"total"];
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

@dynamic lineitem_type;

@dynamic name;

@dynamic payable_id;

- (int32_t)payable_idValue {
	NSNumber *result = [self payable_id];
	return [result intValue];
}

- (void)setPayable_idValue:(int32_t)value_ {
	[self setPayable_id:@(value_)];
}

- (int32_t)primitivePayable_idValue {
	NSNumber *result = [self primitivePayable_id];
	return [result intValue];
}

- (void)setPrimitivePayable_idValue:(int32_t)value_ {
	[self setPrimitivePayable_id:@(value_)];
}

@dynamic payable_type;

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

@dynamic quantity;

- (float)quantityValue {
	NSNumber *result = [self quantity];
	return [result floatValue];
}

- (void)setQuantityValue:(float)value_ {
	[self setQuantity:@(value_)];
}

- (float)primitiveQuantityValue {
	NSNumber *result = [self primitiveQuantity];
	return [result floatValue];
}

- (void)setPrimitiveQuantityValue:(float)value_ {
	[self setPrimitiveQuantity:@(value_)];
}

@dynamic taxable;

- (BOOL)taxableValue {
	NSNumber *result = [self taxable];
	return [result boolValue];
}

- (void)setTaxableValue:(BOOL)value_ {
	[self setTaxable:@(value_)];
}

- (BOOL)primitiveTaxableValue {
	NSNumber *result = [self primitiveTaxable];
	return [result boolValue];
}

- (void)setPrimitiveTaxableValue:(BOOL)value_ {
	[self setPrimitiveTaxable:@(value_)];
}

@dynamic total;

- (float)totalValue {
	NSNumber *result = [self total];
	return [result floatValue];
}

- (void)setTotalValue:(float)value_ {
	[self setTotal:@(value_)];
}

- (float)primitiveTotalValue {
	NSNumber *result = [self primitiveTotal];
	return [result floatValue];
}

- (void)setPrimitiveTotalValue:(float)value_ {
	[self setPrimitiveTotal:@(value_)];
}

@dynamic appointment;

@dynamic estimate;

@end

@implementation LineItemAttributes 
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)lineitem_type {
	return @"lineitem_type";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)payable_id {
	return @"payable_id";
}
+ (NSString *)payable_type {
	return @"payable_type";
}
+ (NSString *)price {
	return @"price";
}
+ (NSString *)quantity {
	return @"quantity";
}
+ (NSString *)taxable {
	return @"taxable";
}
+ (NSString *)total {
	return @"total";
}
@end

@implementation LineItemRelationships 
+ (NSString *)appointment {
	return @"appointment";
}
+ (NSString *)estimate {
	return @"estimate";
}
@end

