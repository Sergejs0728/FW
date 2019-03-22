// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

@implementation UserID
@end

@implementation _User

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (UserID*)objectID {
	return (UserID*)[super objectID];
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
	if ([key isEqualToString:@"hide_customer_detailsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hide_customer_details"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"inspections_enabledValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"inspections_enabled"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"is_adminValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"is_admin"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"mobile_customers_accessValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"mobile_customers_access"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"service_route_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"service_route_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"show_balance_forwardValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"show_balance_forward"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"show_environment_fieldsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"show_environment_fields"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"show_photosValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"show_photos"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic account_features;

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

@dynamic country;

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

@dynamic first_name;

@dynamic hide_customer_details;

- (BOOL)hide_customer_detailsValue {
	NSNumber *result = [self hide_customer_details];
	return [result boolValue];
}

- (void)setHide_customer_detailsValue:(BOOL)value_ {
	[self setHide_customer_details:@(value_)];
}

- (BOOL)primitiveHide_customer_detailsValue {
	NSNumber *result = [self primitiveHide_customer_details];
	return [result boolValue];
}

- (void)setPrimitiveHide_customer_detailsValue:(BOOL)value_ {
	[self setPrimitiveHide_customer_details:@(value_)];
}

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

@dynamic is_admin;

- (BOOL)is_adminValue {
	NSNumber *result = [self is_admin];
	return [result boolValue];
}

- (void)setIs_adminValue:(BOOL)value_ {
	[self setIs_admin:@(value_)];
}

- (BOOL)primitiveIs_adminValue {
	NSNumber *result = [self primitiveIs_admin];
	return [result boolValue];
}

- (void)setPrimitiveIs_adminValue:(BOOL)value_ {
	[self setPrimitiveIs_admin:@(value_)];
}

@dynamic last_name;

@dynamic license_number;

@dynamic mobile_customers_access;

- (BOOL)mobile_customers_accessValue {
	NSNumber *result = [self mobile_customers_access];
	return [result boolValue];
}

- (void)setMobile_customers_accessValue:(BOOL)value_ {
	[self setMobile_customers_access:@(value_)];
}

- (BOOL)primitiveMobile_customers_accessValue {
	NSNumber *result = [self primitiveMobile_customers_access];
	return [result boolValue];
}

- (void)setPrimitiveMobile_customers_accessValue:(BOOL)value_ {
	[self setPrimitiveMobile_customers_access:@(value_)];
}

@dynamic service_route_id;

- (int32_t)service_route_idValue {
	NSNumber *result = [self service_route_id];
	return [result intValue];
}

- (void)setService_route_idValue:(int32_t)value_ {
	[self setService_route_id:@(value_)];
}

- (int32_t)primitiveService_route_idValue {
	NSNumber *result = [self primitiveService_route_id];
	return [result intValue];
}

- (void)setPrimitiveService_route_idValue:(int32_t)value_ {
	[self setPrimitiveService_route_id:@(value_)];
}

@dynamic show_balance_forward;

- (BOOL)show_balance_forwardValue {
	NSNumber *result = [self show_balance_forward];
	return [result boolValue];
}

- (void)setShow_balance_forwardValue:(BOOL)value_ {
	[self setShow_balance_forward:@(value_)];
}

- (BOOL)primitiveShow_balance_forwardValue {
	NSNumber *result = [self primitiveShow_balance_forward];
	return [result boolValue];
}

- (void)setPrimitiveShow_balance_forwardValue:(BOOL)value_ {
	[self setPrimitiveShow_balance_forward:@(value_)];
}

@dynamic show_environment_fields;

- (BOOL)show_environment_fieldsValue {
	NSNumber *result = [self show_environment_fields];
	return [result boolValue];
}

- (void)setShow_environment_fieldsValue:(BOOL)value_ {
	[self setShow_environment_fields:@(value_)];
}

- (BOOL)primitiveShow_environment_fieldsValue {
	NSNumber *result = [self primitiveShow_environment_fields];
	return [result boolValue];
}

- (void)setPrimitiveShow_environment_fieldsValue:(BOOL)value_ {
	[self setPrimitiveShow_environment_fields:@(value_)];
}

@dynamic show_photos;

- (BOOL)show_photosValue {
	NSNumber *result = [self show_photos];
	return [result boolValue];
}

- (void)setShow_photosValue:(BOOL)value_ {
	[self setShow_photos:@(value_)];
}

- (BOOL)primitiveShow_photosValue {
	NSNumber *result = [self primitiveShow_photos];
	return [result boolValue];
}

- (void)setPrimitiveShow_photosValue:(BOOL)value_ {
	[self setPrimitiveShow_photos:@(value_)];
}

@dynamic stripe_pk;

@end

@implementation UserAttributes 
+ (NSString *)account_features {
	return @"account_features";
}
+ (NSString *)account_id {
	return @"account_id";
}
+ (NSString *)country {
	return @"country";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)first_name {
	return @"first_name";
}
+ (NSString *)hide_customer_details {
	return @"hide_customer_details";
}
+ (NSString *)inspections_enabled {
	return @"inspections_enabled";
}
+ (NSString *)is_admin {
	return @"is_admin";
}
+ (NSString *)last_name {
	return @"last_name";
}
+ (NSString *)license_number {
	return @"license_number";
}
+ (NSString *)mobile_customers_access {
	return @"mobile_customers_access";
}
+ (NSString *)service_route_id {
	return @"service_route_id";
}
+ (NSString *)show_balance_forward {
	return @"show_balance_forward";
}
+ (NSString *)show_environment_fields {
	return @"show_environment_fields";
}
+ (NSString *)show_photos {
	return @"show_photos";
}
+ (NSString *)stripe_pk {
	return @"stripe_pk";
}
@end

