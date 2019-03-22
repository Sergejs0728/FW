// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Payment.m instead.

#import "_Payment.h"

@implementation PaymentID
@end

@implementation _Payment

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Payment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Payment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Payment" inManagedObjectContext:moc_];
}

- (PaymentID*)objectID {
	return (PaymentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"amountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"amount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"created_from_mobileValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"created_from_mobile"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"entity_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_id"];
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

@dynamic check_number;

@dynamic created_from_mobile;

- (BOOL)created_from_mobileValue {
	NSNumber *result = [self created_from_mobile];
	return [result boolValue];
}

- (void)setCreated_from_mobileValue:(BOOL)value_ {
	[self setCreated_from_mobile:@(value_)];
}

- (BOOL)primitiveCreated_from_mobileValue {
	NSNumber *result = [self primitiveCreated_from_mobile];
	return [result boolValue];
}

- (void)setPrimitiveCreated_from_mobileValue:(BOOL)value_ {
	[self setPrimitiveCreated_from_mobile:@(value_)];
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

@dynamic payment_date;

@dynamic payment_method;

@end

@implementation PaymentAttributes 
+ (NSString *)amount {
	return @"amount";
}
+ (NSString *)check_number {
	return @"check_number";
}
+ (NSString *)created_from_mobile {
	return @"created_from_mobile";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)payment_date {
	return @"payment_date";
}
+ (NSString *)payment_method {
	return @"payment_method";
}
@end

