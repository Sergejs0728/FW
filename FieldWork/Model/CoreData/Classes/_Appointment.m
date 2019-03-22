// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Appointment.m instead.

#import "_Appointment.h"

@implementation AppointmentID
@end

@implementation _Appointment

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Appointment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Appointment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Appointment" inManagedObjectContext:moc_];
}

- (AppointmentID*)objectID {
	return (AppointmentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"auto_generates_invoiceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"auto_generates_invoice"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"balance_forwardValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"balance_forward"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"callbackValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"callback"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"confirmedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"confirmed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
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
	if ([key isEqualToString:@"discount_amountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"discount_amount"];
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
	if ([key isEqualToString:@"hide_invoice_informationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hide_invoice_information"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"is_editing_nowValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"is_editing_now"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"is_syncValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"is_sync"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"report_numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"report_number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"service_location_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"service_location_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"specificValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"specific"];
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
	if ([key isEqualToString:@"worker_latValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"worker_lat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"worker_lngValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"worker_lng"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic appointment_condition_ids;

@dynamic arrival_time_end;

@dynamic arrival_time_start;

@dynamic auto_generates_invoice;

- (BOOL)auto_generates_invoiceValue {
	NSNumber *result = [self auto_generates_invoice];
	return [result boolValue];
}

- (void)setAuto_generates_invoiceValue:(BOOL)value_ {
	[self setAuto_generates_invoice:@(value_)];
}

- (BOOL)primitiveAuto_generates_invoiceValue {
	NSNumber *result = [self primitiveAuto_generates_invoice];
	return [result boolValue];
}

- (void)setPrimitiveAuto_generates_invoiceValue:(BOOL)value_ {
	[self setPrimitiveAuto_generates_invoice:@(value_)];
}

@dynamic balance_forward;

- (float)balance_forwardValue {
	NSNumber *result = [self balance_forward];
	return [result floatValue];
}

- (void)setBalance_forwardValue:(float)value_ {
	[self setBalance_forward:@(value_)];
}

- (float)primitiveBalance_forwardValue {
	NSNumber *result = [self primitiveBalance_forward];
	return [result floatValue];
}

- (void)setPrimitiveBalance_forwardValue:(float)value_ {
	[self setPrimitiveBalance_forward:@(value_)];
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

@dynamic confirmed;

- (BOOL)confirmedValue {
	NSNumber *result = [self confirmed];
	return [result boolValue];
}

- (void)setConfirmedValue:(BOOL)value_ {
	[self setConfirmed:@(value_)];
}

- (BOOL)primitiveConfirmedValue {
	NSNumber *result = [self primitiveConfirmed];
	return [result boolValue];
}

- (void)setPrimitiveConfirmedValue:(BOOL)value_ {
	[self setPrimitiveConfirmed:@(value_)];
}

@dynamic confirmed_by;

@dynamic corrective_action_ids;

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

@dynamic customer_signature;

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

@dynamic duration;

- (float)durationValue {
	NSNumber *result = [self duration];
	return [result floatValue];
}

- (void)setDurationValue:(float)value_ {
	[self setDuration:@(value_)];
}

- (float)primitiveDurationValue {
	NSNumber *result = [self primitiveDuration];
	return [result floatValue];
}

- (void)setPrimitiveDurationValue:(float)value_ {
	[self setPrimitiveDuration:@(value_)];
}

@dynamic ends_at;

@dynamic ends_at_date;

@dynamic ends_at_time;

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

@dynamic error_sync_message;

@dynamic finished_at_time;

@dynamic hide_invoice_information;

- (BOOL)hide_invoice_informationValue {
	NSNumber *result = [self hide_invoice_information];
	return [result boolValue];
}

- (void)setHide_invoice_informationValue:(BOOL)value_ {
	[self setHide_invoice_information:@(value_)];
}

- (BOOL)primitiveHide_invoice_informationValue {
	NSNumber *result = [self primitiveHide_invoice_information];
	return [result boolValue];
}

- (void)setPrimitiveHide_invoice_informationValue:(BOOL)value_ {
	[self setPrimitiveHide_invoice_information:@(value_)];
}

@dynamic instructions;

@dynamic is_editing_now;

- (BOOL)is_editing_nowValue {
	NSNumber *result = [self is_editing_now];
	return [result boolValue];
}

- (void)setIs_editing_nowValue:(BOOL)value_ {
	[self setIs_editing_now:@(value_)];
}

- (BOOL)primitiveIs_editing_nowValue {
	NSNumber *result = [self primitiveIs_editing_now];
	return [result boolValue];
}

- (void)setPrimitiveIs_editing_nowValue:(BOOL)value_ {
	[self setPrimitiveIs_editing_now:@(value_)];
}

@dynamic is_sync;

- (BOOL)is_syncValue {
	NSNumber *result = [self is_sync];
	return [result boolValue];
}

- (void)setIs_syncValue:(BOOL)value_ {
	[self setIs_sync:@(value_)];
}

- (BOOL)primitiveIs_syncValue {
	NSNumber *result = [self primitiveIs_sync];
	return [result boolValue];
}

- (void)setPrimitiveIs_syncValue:(BOOL)value_ {
	[self setPrimitiveIs_sync:@(value_)];
}

@dynamic last_sync_date;

@dynamic notes;

@dynamic private_notes;

@dynamic purchase_order_no;

@dynamic recommendation_ids;

@dynamic report_number;

- (int32_t)report_numberValue {
	NSNumber *result = [self report_number];
	return [result intValue];
}

- (void)setReport_numberValue:(int32_t)value_ {
	[self setReport_number:@(value_)];
}

- (int32_t)primitiveReport_numberValue {
	NSNumber *result = [self primitiveReport_number];
	return [result intValue];
}

- (void)setPrimitiveReport_numberValue:(int32_t)value_ {
	[self setPrimitiveReport_number:@(value_)];
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

@dynamic specific;

- (BOOL)specificValue {
	NSNumber *result = [self specific];
	return [result boolValue];
}

- (void)setSpecificValue:(BOOL)value_ {
	[self setSpecific:@(value_)];
}

- (BOOL)primitiveSpecificValue {
	NSNumber *result = [self primitiveSpecific];
	return [result boolValue];
}

- (void)setPrimitiveSpecificValue:(BOOL)value_ {
	[self setPrimitiveSpecific:@(value_)];
}

@dynamic square_feet;

@dynamic started_at_time;

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

@dynamic technician_signature;

@dynamic technician_signature_name;

@dynamic temperature;

@dynamic updated_at;

@dynamic wind_direction;

@dynamic wind_speed;

@dynamic worker_lat;

- (double)worker_latValue {
	NSNumber *result = [self worker_lat];
	return [result doubleValue];
}

- (void)setWorker_latValue:(double)value_ {
	[self setWorker_lat:@(value_)];
}

- (double)primitiveWorker_latValue {
	NSNumber *result = [self primitiveWorker_lat];
	return [result doubleValue];
}

- (void)setPrimitiveWorker_latValue:(double)value_ {
	[self setPrimitiveWorker_lat:@(value_)];
}

@dynamic worker_lng;

- (double)worker_lngValue {
	NSNumber *result = [self worker_lng];
	return [result doubleValue];
}

- (void)setWorker_lngValue:(double)value_ {
	[self setWorker_lng:@(value_)];
}

- (double)primitiveWorker_lngValue {
	NSNumber *result = [self primitiveWorker_lng];
	return [result doubleValue];
}

- (void)setPrimitiveWorker_lngValue:(double)value_ {
	[self setPrimitiveWorker_lng:@(value_)];
}

@dynamic attachments;

- (NSMutableSet<PDFAttachment*>*)attachmentsSet {
	[self willAccessValueForKey:@"attachments"];

	NSMutableSet<PDFAttachment*> *result = (NSMutableSet<PDFAttachment*>*)[self mutableSetValueForKey:@"attachments"];

	[self didAccessValueForKey:@"attachments"];
	return result;
}

@dynamic inspection_records;

- (NSMutableSet<InspectionRecord*>*)inspection_recordsSet {
	[self willAccessValueForKey:@"inspection_records"];

	NSMutableSet<InspectionRecord*> *result = (NSMutableSet<InspectionRecord*>*)[self mutableSetValueForKey:@"inspection_records"];

	[self didAccessValueForKey:@"inspection_records"];
	return result;
}

@dynamic invoice;

@dynamic line_items;

- (NSMutableOrderedSet<LineItem*>*)line_itemsSet {
	[self willAccessValueForKey:@"line_items"];

	NSMutableOrderedSet<LineItem*> *result = (NSMutableOrderedSet<LineItem*>*)[self mutableOrderedSetValueForKey:@"line_items"];

	[self didAccessValueForKey:@"line_items"];
	return result;
}

@dynamic material_usages;

- (NSMutableSet<MaterialUsage*>*)material_usagesSet {
	[self willAccessValueForKey:@"material_usages"];

	NSMutableSet<MaterialUsage*> *result = (NSMutableSet<MaterialUsage*>*)[self mutableSetValueForKey:@"material_usages"];

	[self didAccessValueForKey:@"material_usages"];
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

@dynamic tax_rate;

@dynamic unit_records;

- (NSMutableSet<UnitInspection*>*)unit_recordsSet {
	[self willAccessValueForKey:@"unit_records"];

	NSMutableSet<UnitInspection*> *result = (NSMutableSet<UnitInspection*>*)[self mutableSetValueForKey:@"unit_records"];

	[self didAccessValueForKey:@"unit_records"];
	return result;
}

@end

@implementation _Appointment (Line_itemsCoreDataGeneratedAccessors)
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

@implementation AppointmentAttributes 
+ (NSString *)appointment_condition_ids {
	return @"appointment_condition_ids";
}
+ (NSString *)arrival_time_end {
	return @"arrival_time_end";
}
+ (NSString *)arrival_time_start {
	return @"arrival_time_start";
}
+ (NSString *)auto_generates_invoice {
	return @"auto_generates_invoice";
}
+ (NSString *)balance_forward {
	return @"balance_forward";
}
+ (NSString *)callback {
	return @"callback";
}
+ (NSString *)confirmed {
	return @"confirmed";
}
+ (NSString *)confirmed_by {
	return @"confirmed_by";
}
+ (NSString *)corrective_action_ids {
	return @"corrective_action_ids";
}
+ (NSString *)created_at {
	return @"created_at";
}
+ (NSString *)customer_id {
	return @"customer_id";
}
+ (NSString *)customer_signature {
	return @"customer_signature";
}
+ (NSString *)discount {
	return @"discount";
}
+ (NSString *)discount_amount {
	return @"discount_amount";
}
+ (NSString *)duration {
	return @"duration";
}
+ (NSString *)ends_at {
	return @"ends_at";
}
+ (NSString *)ends_at_date {
	return @"ends_at_date";
}
+ (NSString *)ends_at_time {
	return @"ends_at_time";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)error_sync_message {
	return @"error_sync_message";
}
+ (NSString *)finished_at_time {
	return @"finished_at_time";
}
+ (NSString *)hide_invoice_information {
	return @"hide_invoice_information";
}
+ (NSString *)instructions {
	return @"instructions";
}
+ (NSString *)is_editing_now {
	return @"is_editing_now";
}
+ (NSString *)is_sync {
	return @"is_sync";
}
+ (NSString *)last_sync_date {
	return @"last_sync_date";
}
+ (NSString *)notes {
	return @"notes";
}
+ (NSString *)private_notes {
	return @"private_notes";
}
+ (NSString *)purchase_order_no {
	return @"purchase_order_no";
}
+ (NSString *)recommendation_ids {
	return @"recommendation_ids";
}
+ (NSString *)report_number {
	return @"report_number";
}
+ (NSString *)service_location_id {
	return @"service_location_id";
}
+ (NSString *)service_route_ids {
	return @"service_route_ids";
}
+ (NSString *)specific {
	return @"specific";
}
+ (NSString *)square_feet {
	return @"square_feet";
}
+ (NSString *)started_at_time {
	return @"started_at_time";
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
+ (NSString *)technician_signature {
	return @"technician_signature";
}
+ (NSString *)technician_signature_name {
	return @"technician_signature_name";
}
+ (NSString *)temperature {
	return @"temperature";
}
+ (NSString *)updated_at {
	return @"updated_at";
}
+ (NSString *)wind_direction {
	return @"wind_direction";
}
+ (NSString *)wind_speed {
	return @"wind_speed";
}
+ (NSString *)worker_lat {
	return @"worker_lat";
}
+ (NSString *)worker_lng {
	return @"worker_lng";
}
@end

@implementation AppointmentRelationships 
+ (NSString *)attachments {
	return @"attachments";
}
+ (NSString *)inspection_records {
	return @"inspection_records";
}
+ (NSString *)invoice {
	return @"invoice";
}
+ (NSString *)line_items {
	return @"line_items";
}
+ (NSString *)material_usages {
	return @"material_usages";
}
+ (NSString *)pdf_forms {
	return @"pdf_forms";
}
+ (NSString *)photo_attachments {
	return @"photo_attachments";
}
+ (NSString *)tax_rate {
	return @"tax_rate";
}
+ (NSString *)unit_records {
	return @"unit_records";
}
@end

