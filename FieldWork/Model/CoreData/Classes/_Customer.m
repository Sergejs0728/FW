// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Customer.m instead.

#import "_Customer.h"

@implementation CustomerID
@end

@implementation _Customer

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Customer";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:moc_];
}

- (CustomerID*)objectID {
	return (CustomerID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"account_numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"account_number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"balanceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"balance"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"billing_term_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"billing_term_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"email_marketingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"email_marketing"];
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
	if ([key isEqualToString:@"inspections_enabledValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"inspections_enabled"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"latValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"lngValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lng"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"send_report_emailValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"send_report_email"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic account_number;

- (int32_t)account_numberValue {
	NSNumber *result = [self account_number];
	return [result intValue];
}

- (void)setAccount_numberValue:(int32_t)value_ {
	[self setAccount_number:@(value_)];
}

- (int32_t)primitiveAccount_numberValue {
	NSNumber *result = [self primitiveAccount_number];
	return [result intValue];
}

- (void)setPrimitiveAccount_numberValue:(int32_t)value_ {
	[self setPrimitiveAccount_number:@(value_)];
}

@dynamic balance;

- (float)balanceValue {
	NSNumber *result = [self balance];
	return [result floatValue];
}

- (void)setBalanceValue:(float)value_ {
	[self setBalance:@(value_)];
}

- (float)primitiveBalanceValue {
	NSNumber *result = [self primitiveBalance];
	return [result floatValue];
}

- (void)setPrimitiveBalanceValue:(float)value_ {
	[self setPrimitiveBalance:@(value_)];
}

@dynamic billing_attention;

@dynamic billing_city;

@dynamic billing_contact;

@dynamic billing_county;

@dynamic billing_name;

@dynamic billing_phone;

@dynamic billing_phone_ext;

@dynamic billing_phone_kind;

@dynamic billing_phones;

@dynamic billing_phones_exts;

@dynamic billing_phones_kinds;

@dynamic billing_state;

@dynamic billing_street;

@dynamic billing_street2;

@dynamic billing_suite;

@dynamic billing_term_id;

- (int32_t)billing_term_idValue {
	NSNumber *result = [self billing_term_id];
	return [result intValue];
}

- (void)setBilling_term_idValue:(int32_t)value_ {
	[self setBilling_term_id:@(value_)];
}

- (int32_t)primitiveBilling_term_idValue {
	NSNumber *result = [self primitiveBilling_term_id];
	return [result intValue];
}

- (void)setPrimitiveBilling_term_idValue:(int32_t)value_ {
	[self setPrimitiveBilling_term_id:@(value_)];
}

@dynamic billing_zip;

@dynamic customer_name;

@dynamic customer_type;

@dynamic email_marketing;

- (BOOL)email_marketingValue {
	NSNumber *result = [self email_marketing];
	return [result boolValue];
}

- (void)setEmail_marketingValue:(BOOL)value_ {
	[self setEmail_marketing:@(value_)];
}

- (BOOL)primitiveEmail_marketingValue {
	NSNumber *result = [self primitiveEmail_marketing];
	return [result boolValue];
}

- (void)setPrimitiveEmail_marketingValue:(BOOL)value_ {
	[self setPrimitiveEmail_marketing:@(value_)];
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

@dynamic first_name;

@dynamic inspections_enabled;

- (BOOL)inspections_enabledValue {
	NSNumber *result = [self inspections_enabled];
	return [result boolValue];
}

- (void)setInspections_enabledValue:(BOOL)value_ {
	[self setInspections_enabled:@(value_)];
}

- (BOOL)primitiveInspections_enabledValue {
	NSNumber *result = [self primitiveInspections_enabled];
	return [result boolValue];
}

- (void)setPrimitiveInspections_enabledValue:(BOOL)value_ {
	[self setPrimitiveInspections_enabled:@(value_)];
}

@dynamic invoice_email;

@dynamic last_name;

@dynamic lat;

- (double)latValue {
	NSNumber *result = [self lat];
	return [result doubleValue];
}

- (void)setLatValue:(double)value_ {
	[self setLat:@(value_)];
}

- (double)primitiveLatValue {
	NSNumber *result = [self primitiveLat];
	return [result doubleValue];
}

- (void)setPrimitiveLatValue:(double)value_ {
	[self setPrimitiveLat:@(value_)];
}

@dynamic lng;

- (double)lngValue {
	NSNumber *result = [self lng];
	return [result doubleValue];
}

- (void)setLngValue:(double)value_ {
	[self setLng:@(value_)];
}

- (double)primitiveLngValue {
	NSNumber *result = [self primitiveLng];
	return [result doubleValue];
}

- (void)setPrimitiveLngValue:(double)value_ {
	[self setPrimitiveLng:@(value_)];
}

@dynamic name;

@dynamic name_prefix;

@dynamic payment_methods;

@dynamic send_report_email;

- (BOOL)send_report_emailValue {
	NSNumber *result = [self send_report_email];
	return [result boolValue];
}

- (void)setSend_report_emailValue:(BOOL)value_ {
	[self setSend_report_email:@(value_)];
}

- (BOOL)primitiveSend_report_emailValue {
	NSNumber *result = [self primitiveSend_report_email];
	return [result boolValue];
}

- (void)setPrimitiveSend_report_emailValue:(BOOL)value_ {
	[self setPrimitiveSend_report_email:@(value_)];
}

@dynamic site;

@dynamic service_locations;

- (NSMutableSet<ServiceLocation*>*)service_locationsSet {
	[self willAccessValueForKey:@"service_locations"];

	NSMutableSet<ServiceLocation*> *result = (NSMutableSet<ServiceLocation*>*)[self mutableSetValueForKey:@"service_locations"];

	[self didAccessValueForKey:@"service_locations"];
	return result;
}

@end

@implementation CustomerAttributes 
+ (NSString *)account_number {
	return @"account_number";
}
+ (NSString *)balance {
	return @"balance";
}
+ (NSString *)billing_attention {
	return @"billing_attention";
}
+ (NSString *)billing_city {
	return @"billing_city";
}
+ (NSString *)billing_contact {
	return @"billing_contact";
}
+ (NSString *)billing_county {
	return @"billing_county";
}
+ (NSString *)billing_name {
	return @"billing_name";
}
+ (NSString *)billing_phone {
	return @"billing_phone";
}
+ (NSString *)billing_phone_ext {
	return @"billing_phone_ext";
}
+ (NSString *)billing_phone_kind {
	return @"billing_phone_kind";
}
+ (NSString *)billing_phones {
	return @"billing_phones";
}
+ (NSString *)billing_phones_exts {
	return @"billing_phones_exts";
}
+ (NSString *)billing_phones_kinds {
	return @"billing_phones_kinds";
}
+ (NSString *)billing_state {
	return @"billing_state";
}
+ (NSString *)billing_street {
	return @"billing_street";
}
+ (NSString *)billing_street2 {
	return @"billing_street2";
}
+ (NSString *)billing_suite {
	return @"billing_suite";
}
+ (NSString *)billing_term_id {
	return @"billing_term_id";
}
+ (NSString *)billing_zip {
	return @"billing_zip";
}
+ (NSString *)customer_name {
	return @"customer_name";
}
+ (NSString *)customer_type {
	return @"customer_type";
}
+ (NSString *)email_marketing {
	return @"email_marketing";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)first_name {
	return @"first_name";
}
+ (NSString *)inspections_enabled {
	return @"inspections_enabled";
}
+ (NSString *)invoice_email {
	return @"invoice_email";
}
+ (NSString *)last_name {
	return @"last_name";
}
+ (NSString *)lat {
	return @"lat";
}
+ (NSString *)lng {
	return @"lng";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)name_prefix {
	return @"name_prefix";
}
+ (NSString *)payment_methods {
	return @"payment_methods";
}
+ (NSString *)send_report_email {
	return @"send_report_email";
}
+ (NSString *)site {
	return @"site";
}
@end

@implementation CustomerRelationships 
+ (NSString *)service_locations {
	return @"service_locations";
}
@end

