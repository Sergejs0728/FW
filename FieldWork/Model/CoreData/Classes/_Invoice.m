// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Invoice.m instead.

#import "_Invoice.h"

@implementation InvoiceID
@end

@implementation _Invoice

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Invoice" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Invoice";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Invoice" inManagedObjectContext:moc_];
}

- (InvoiceID*)objectID {
	return (InvoiceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"approvedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"approved"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"callbackValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"callback"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"discountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"discount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"discount_amountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"discount_amount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"invoice_numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"invoice_number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tax_amountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tax_amount"];
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

@dynamic approved;

- (BOOL)approvedValue {
	NSNumber *result = [self approved];
	return [result boolValue];
}

- (void)setApprovedValue:(BOOL)value_ {
	[self setApproved:@(value_)];
}

- (BOOL)primitiveApprovedValue {
	NSNumber *result = [self primitiveApproved];
	return [result boolValue];
}

- (void)setPrimitiveApprovedValue:(BOOL)value_ {
	[self setPrimitiveApproved:@(value_)];
}

@dynamic callback;

- (BOOL)callbackValue {
	NSNumber *result = [self callback];
	return [result boolValue];
}

- (void)setCallbackValue:(BOOL)value_ {
	[self setCallback:@(value_)];
}

- (BOOL)primitiveCallbackValue {
	NSNumber *result = [self primitiveCallback];
	return [result boolValue];
}

- (void)setPrimitiveCallbackValue:(BOOL)value_ {
	[self setPrimitiveCallback:@(value_)];
}

@dynamic discount;

- (float)discountValue {
	NSNumber *result = [self discount];
	return [result floatValue];
}

- (void)setDiscountValue:(float)value_ {
	[self setDiscount:@(value_)];
}

- (float)primitiveDiscountValue {
	NSNumber *result = [self primitiveDiscount];
	return [result floatValue];
}

- (void)setPrimitiveDiscountValue:(float)value_ {
	[self setPrimitiveDiscount:@(value_)];
}

@dynamic discount_amount;

- (float)discount_amountValue {
	NSNumber *result = [self discount_amount];
	return [result floatValue];
}

- (void)setDiscount_amountValue:(float)value_ {
	[self setDiscount_amount:@(value_)];
}

- (float)primitiveDiscount_amountValue {
	NSNumber *result = [self primitiveDiscount_amount];
	return [result floatValue];
}

- (void)setPrimitiveDiscount_amountValue:(float)value_ {
	[self setPrimitiveDiscount_amount:@(value_)];
}

@dynamic invoice_number;

- (int32_t)invoice_numberValue {
	NSNumber *result = [self invoice_number];
	return [result intValue];
}

- (void)setInvoice_numberValue:(int32_t)value_ {
	[self setInvoice_number:@(value_)];
}

- (int32_t)primitiveInvoice_numberValue {
	NSNumber *result = [self primitiveInvoice_number];
	return [result intValue];
}

- (void)setPrimitiveInvoice_numberValue:(int32_t)value_ {
	[self setPrimitiveInvoice_number:@(value_)];
}

@dynamic tax_amount;

- (float)tax_amountValue {
	NSNumber *result = [self tax_amount];
	return [result floatValue];
}

- (void)setTax_amountValue:(float)value_ {
	[self setTax_amount:@(value_)];
}

- (float)primitiveTax_amountValue {
	NSNumber *result = [self primitiveTax_amount];
	return [result floatValue];
}

- (void)setPrimitiveTax_amountValue:(float)value_ {
	[self setPrimitiveTax_amount:@(value_)];
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

@dynamic payments;

- (NSMutableSet<Payment*>*)paymentsSet {
	[self willAccessValueForKey:@"payments"];

	NSMutableSet<Payment*> *result = (NSMutableSet<Payment*>*)[self mutableSetValueForKey:@"payments"];

	[self didAccessValueForKey:@"payments"];
	return result;
}

@end

@implementation InvoiceAttributes 
+ (NSString *)approved {
	return @"approved";
}
+ (NSString *)callback {
	return @"callback";
}
+ (NSString *)discount {
	return @"discount";
}
+ (NSString *)discount_amount {
	return @"discount_amount";
}
+ (NSString *)invoice_number {
	return @"invoice_number";
}
+ (NSString *)tax_amount {
	return @"tax_amount";
}
+ (NSString *)total {
	return @"total";
}
@end

@implementation InvoiceRelationships 
+ (NSString *)appointment {
	return @"appointment";
}
+ (NSString *)payments {
	return @"payments";
}
@end

