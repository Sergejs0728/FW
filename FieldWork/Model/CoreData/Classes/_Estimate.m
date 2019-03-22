// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Estimate.m instead.

#import "_Estimate.h"

@implementation EstimateID
@end

@implementation _Estimate

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Estimate" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Estimate";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Estimate" inManagedObjectContext:moc_];
}

- (EstimateID*)objectID {
	return (EstimateID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"customer_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"customer_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"discountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"discount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"durationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"duration"];
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
	if ([key isEqualToString:@"estimate_numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"estimate_number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"purchase_order_numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"purchase_order_number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"service_location_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"service_location_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tax_amountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tax_amount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tax_rate_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tax_rate_id"];
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

@dynamic created_at;

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

@dynamic duration;

- (int32_t)durationValue {
	NSNumber *result = [self duration];
	return [result intValue];
}

- (void)setDurationValue:(int32_t)value_ {
	[self setDuration:@(value_)];
}

- (int32_t)primitiveDurationValue {
	NSNumber *result = [self primitiveDuration];
	return [result intValue];
}

- (void)setPrimitiveDurationValue:(int32_t)value_ {
	[self setPrimitiveDuration:@(value_)];
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

@dynamic estimate_number;

- (int32_t)estimate_numberValue {
	NSNumber *result = [self estimate_number];
	return [result intValue];
}

- (void)setEstimate_numberValue:(int32_t)value_ {
	[self setEstimate_number:@(value_)];
}

- (int32_t)primitiveEstimate_numberValue {
	NSNumber *result = [self primitiveEstimate_number];
	return [result intValue];
}

- (void)setPrimitiveEstimate_numberValue:(int32_t)value_ {
	[self setPrimitiveEstimate_number:@(value_)];
}

@dynamic expires_on;

@dynamic issued_on;

@dynamic notes;

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

@dynamic purchase_order_number;

- (int32_t)purchase_order_numberValue {
	NSNumber *result = [self purchase_order_number];
	return [result intValue];
}

- (void)setPurchase_order_numberValue:(int32_t)value_ {
	[self setPurchase_order_number:@(value_)];
}

- (int32_t)primitivePurchase_order_numberValue {
	NSNumber *result = [self primitivePurchase_order_number];
	return [result intValue];
}

- (void)setPrimitivePurchase_order_numberValue:(int32_t)value_ {
	[self setPrimitivePurchase_order_number:@(value_)];
}

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

@dynamic service_route_ids;

@dynamic starts_at;

@dynamic starts_at_date;

@dynamic starts_at_time;

@dynamic status;

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

@dynamic tax_rate_id;

- (int32_t)tax_rate_idValue {
	NSNumber *result = [self tax_rate_id];
	return [result intValue];
}

- (void)setTax_rate_idValue:(int32_t)value_ {
	[self setTax_rate_id:@(value_)];
}

- (int32_t)primitiveTax_rate_idValue {
	NSNumber *result = [self primitiveTax_rate_id];
	return [result intValue];
}

- (void)setPrimitiveTax_rate_idValue:(int32_t)value_ {
	[self setPrimitiveTax_rate_id:@(value_)];
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

@dynamic updated_at;

@dynamic attachments;

- (NSMutableSet<PDFAttachment*>*)attachmentsSet {
	[self willAccessValueForKey:@"attachments"];

	NSMutableSet<PDFAttachment*> *result = (NSMutableSet<PDFAttachment*>*)[self mutableSetValueForKey:@"attachments"];

	[self didAccessValueForKey:@"attachments"];
	return result;
}

@dynamic line_items;

- (NSMutableOrderedSet<LineItem*>*)line_itemsSet {
	[self willAccessValueForKey:@"line_items"];

	NSMutableOrderedSet<LineItem*> *result = (NSMutableOrderedSet<LineItem*>*)[self mutableOrderedSetValueForKey:@"line_items"];

	[self didAccessValueForKey:@"line_items"];
	return result;
}

@dynamic pdf_forms;

- (NSMutableSet<FWPDFForm*>*)pdf_formsSet {
	[self willAccessValueForKey:@"pdf_forms"];

	NSMutableSet<FWPDFForm*> *result = (NSMutableSet<FWPDFForm*>*)[self mutableSetValueForKey:@"pdf_forms"];

	[self didAccessValueForKey:@"pdf_forms"];
	return result;
}

@dynamic photo_attachments;

- (NSMutableSet<PhotoAttachment*>*)photo_attachmentsSet {
	[self willAccessValueForKey:@"photo_attachments"];

	NSMutableSet<PhotoAttachment*> *result = (NSMutableSet<PhotoAttachment*>*)[self mutableSetValueForKey:@"photo_attachments"];

	[self didAccessValueForKey:@"photo_attachments"];
	return result;
}

@end

@implementation _Estimate (Line_itemsCoreDataGeneratedAccessors)
- (void)addLine_items:(NSOrderedSet<LineItem*>*)value_ {
	[self.line_itemsSet unionOrderedSet:value_];
}
- (void)removeLine_items:(NSOrderedSet<LineItem*>*)value_ {
	[self.line_itemsSet minusOrderedSet:value_];
}
- (void)addLine_itemsObject:(LineItem*)value_ {
	[self.line_itemsSet addObject:value_];
}
- (void)removeLine_itemsObject:(LineItem*)value_ {
	[self.line_itemsSet removeObject:value_];
}
- (void)insertObject:(LineItem*)value inLine_itemsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"line_items"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self line_items] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"line_items"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"line_items"];
}
- (void)removeObjectFromLine_itemsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"line_items"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self line_items] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"line_items"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"line_items"];
}
- (void)insertLine_items:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"line_items"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self line_items] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"line_items"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"line_items"];
}
- (void)removeLine_itemsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"line_items"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self line_items] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"line_items"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"line_items"];
}
- (void)replaceObjectInLine_itemsAtIndex:(NSUInteger)idx withObject:(LineItem*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"line_items"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self line_items] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"line_items"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"line_items"];
}
- (void)replaceLine_itemsAtIndexes:(NSIndexSet *)indexes withLine_items:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"line_items"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self line_items] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"line_items"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"line_items"];
}
@end

@implementation EstimateAttributes 
+ (NSString *)created_at {
	return @"created_at";
}
+ (NSString *)customer_id {
	return @"customer_id";
}
+ (NSString *)discount {
	return @"discount";
}
+ (NSString *)duration {
	return @"duration";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)estimate_number {
	return @"estimate_number";
}
+ (NSString *)expires_on {
	return @"expires_on";
}
+ (NSString *)issued_on {
	return @"issued_on";
}
+ (NSString *)notes {
	return @"notes";
}
+ (NSString *)price {
	return @"price";
}
+ (NSString *)purchase_order_number {
	return @"purchase_order_number";
}
+ (NSString *)service_location_id {
	return @"service_location_id";
}
+ (NSString *)service_route_ids {
	return @"service_route_ids";
}
+ (NSString *)starts_at {
	return @"starts_at";
}
+ (NSString *)starts_at_date {
	return @"starts_at_date";
}
+ (NSString *)starts_at_time {
	return @"starts_at_time";
}
+ (NSString *)status {
	return @"status";
}
+ (NSString *)tax_amount {
	return @"tax_amount";
}
+ (NSString *)tax_rate_id {
	return @"tax_rate_id";
}
+ (NSString *)total {
	return @"total";
}
+ (NSString *)updated_at {
	return @"updated_at";
}
@end

@implementation EstimateRelationships 
+ (NSString *)attachments {
	return @"attachments";
}
+ (NSString *)line_items {
	return @"line_items";
}
+ (NSString *)pdf_forms {
	return @"pdf_forms";
}
+ (NSString *)photo_attachments {
	return @"photo_attachments";
}
@end

