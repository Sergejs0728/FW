// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.m instead.

#import "_Contact.h"

@implementation ContactID
@end

@implementation _Contact

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Contact";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:moc_];
}

- (ContactID*)objectID {
	return (ContactID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"email_invoicesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"email_invoices"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"email_work_ordersValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"email_work_orders"];
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

@dynamic contact_description;

@dynamic email;

@dynamic email_invoices;

- (BOOL)email_invoicesValue {
	NSNumber *result = [self email_invoices];
	return [result boolValue];
}

- (void)setEmail_invoicesValue:(BOOL)value_ {
	[self setEmail_invoices:@(value_)];
}

- (BOOL)primitiveEmail_invoicesValue {
	NSNumber *result = [self primitiveEmail_invoices];
	return [result boolValue];
}

- (void)setPrimitiveEmail_invoicesValue:(BOOL)value_ {
	[self setPrimitiveEmail_invoices:@(value_)];
}

@dynamic email_work_orders;

- (BOOL)email_work_ordersValue {
	NSNumber *result = [self email_work_orders];
	return [result boolValue];
}

- (void)setEmail_work_ordersValue:(BOOL)value_ {
	[self setEmail_work_orders:@(value_)];
}

- (BOOL)primitiveEmail_work_ordersValue {
	NSNumber *result = [self primitiveEmail_work_orders];
	return [result boolValue];
}

- (void)setPrimitiveEmail_work_ordersValue:(BOOL)value_ {
	[self setPrimitiveEmail_work_orders:@(value_)];
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

@dynamic first_name;

@dynamic last_name;

@dynamic phone;

@dynamic phone_ext;

@dynamic phone_kind;

@dynamic phones;

@dynamic phones_exts;

@dynamic phones_kinds;

@dynamic title;

@end

@implementation ContactAttributes 
+ (NSString *)contact_description {
	return @"contact_description";
}
+ (NSString *)email {
	return @"email";
}
+ (NSString *)email_invoices {
	return @"email_invoices";
}
+ (NSString *)email_work_orders {
	return @"email_work_orders";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)first_name {
	return @"first_name";
}
+ (NSString *)last_name {
	return @"last_name";
}
+ (NSString *)phone {
	return @"phone";
}
+ (NSString *)phone_ext {
	return @"phone_ext";
}
+ (NSString *)phone_kind {
	return @"phone_kind";
}
+ (NSString *)phones {
	return @"phones";
}
+ (NSString *)phones_exts {
	return @"phones_exts";
}
+ (NSString *)phones_kinds {
	return @"phones_kinds";
}
+ (NSString *)title {
	return @"title";
}
@end

