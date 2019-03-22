// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ServiceLocation.m instead.

#import "_ServiceLocation.h"

@implementation ServiceLocationID
@end

@implementation _ServiceLocation

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ServiceLocation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ServiceLocation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ServiceLocation" inManagedObjectContext:moc_];
}

- (ServiceLocationID*)objectID {
	return (ServiceLocationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"customer_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"customer_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"entity_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"hide_balanceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hide_balance"];
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
	if ([key isEqualToString:@"location_type_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"location_type_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"service_route_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"service_route_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tax_rate_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tax_rate_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic attention;

@dynamic city;

@dynamic contact_name;

@dynamic country;

@dynamic county;

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

@dynamic email;

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

@dynamic hide_balance;

- (BOOL)hide_balanceValue {
	NSNumber *result = [self hide_balance];
	return [result boolValue];
}

- (void)setHide_balanceValue:(BOOL)value_ {
	[self setHide_balance:@(value_)];
}

- (BOOL)primitiveHide_balanceValue {
	NSNumber *result = [self primitiveHide_balance];
	return [result boolValue];
}

- (void)setPrimitiveHide_balanceValue:(BOOL)value_ {
	[self setPrimitiveHide_balance:@(value_)];
}

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

@dynamic location_type_id;

- (int32_t)location_type_idValue {
	NSNumber *result = [self location_type_id];
	return [result intValue];
}

- (void)setLocation_type_idValue:(int32_t)value_ {
	[self setLocation_type_id:@(value_)];
}

- (int32_t)primitiveLocation_type_idValue {
	NSNumber *result = [self primitiveLocation_type_id];
	return [result intValue];
}

- (void)setPrimitiveLocation_type_idValue:(int32_t)value_ {
	[self setPrimitiveLocation_type_id:@(value_)];
}

@dynamic name;

@dynamic notes;

@dynamic phone;

@dynamic phone_ext;

@dynamic phone_kind;

@dynamic phones;

@dynamic phones_exts;

@dynamic phones_kinds;

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

@dynamic state;

@dynamic street;

@dynamic street2;

@dynamic suite;

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

@dynamic zip;

@dynamic contacts;

- (NSMutableSet<Contact*>*)contactsSet {
	[self willAccessValueForKey:@"contacts"];

	NSMutableSet<Contact*> *result = (NSMutableSet<Contact*>*)[self mutableSetValueForKey:@"contacts"];

	[self didAccessValueForKey:@"contacts"];
	return result;
}

@dynamic customer;

@dynamic devices;

- (NSMutableSet<CustomerDevice*>*)devicesSet {
	[self willAccessValueForKey:@"devices"];

	NSMutableSet<CustomerDevice*> *result = (NSMutableSet<CustomerDevice*>*)[self mutableSetValueForKey:@"devices"];

	[self didAccessValueForKey:@"devices"];
	return result;
}

@dynamic flats;

- (NSMutableSet<Unit*>*)flatsSet {
	[self willAccessValueForKey:@"flats"];

	NSMutableSet<Unit*> *result = (NSMutableSet<Unit*>*)[self mutableSetValueForKey:@"flats"];

	[self didAccessValueForKey:@"flats"];
	return result;
}

@dynamic floors;

- (NSMutableOrderedSet<StageModel*>*)floorsSet {
	[self willAccessValueForKey:@"floors"];

	NSMutableOrderedSet<StageModel*> *result = (NSMutableOrderedSet<StageModel*>*)[self mutableOrderedSetValueForKey:@"floors"];

	[self didAccessValueForKey:@"floors"];
	return result;
}

@end

@implementation _ServiceLocation (FloorsCoreDataGeneratedAccessors)
- (void)addFloors:(NSOrderedSet<StageModel*>*)value_ {
	[self.floorsSet unionOrderedSet:value_];
}
- (void)removeFloors:(NSOrderedSet<StageModel*>*)value_ {
	[self.floorsSet minusOrderedSet:value_];
}
- (void)addFloorsObject:(StageModel*)value_ {
	[self.floorsSet addObject:value_];
}
- (void)removeFloorsObject:(StageModel*)value_ {
	[self.floorsSet removeObject:value_];
}
- (void)insertObject:(StageModel*)value inFloorsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"floors"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self floors] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"floors"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"floors"];
}
- (void)removeObjectFromFloorsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"floors"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self floors] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"floors"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"floors"];
}
- (void)insertFloors:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"floors"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self floors] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"floors"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"floors"];
}
- (void)removeFloorsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"floors"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self floors] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"floors"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"floors"];
}
- (void)replaceObjectInFloorsAtIndex:(NSUInteger)idx withObject:(StageModel*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"floors"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self floors] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"floors"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"floors"];
}
- (void)replaceFloorsAtIndexes:(NSIndexSet *)indexes withFloors:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"floors"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self floors] ?: [NSOrderedSet orderedSet]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"floors"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"floors"];
}
@end

@implementation ServiceLocationAttributes 
+ (NSString *)attention {
	return @"attention";
}
+ (NSString *)city {
	return @"city";
}
+ (NSString *)contact_name {
	return @"contact_name";
}
+ (NSString *)country {
	return @"country";
}
+ (NSString *)county {
	return @"county";
}
+ (NSString *)customer_id {
	return @"customer_id";
}
+ (NSString *)email {
	return @"email";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)hide_balance {
	return @"hide_balance";
}
+ (NSString *)lat {
	return @"lat";
}
+ (NSString *)lng {
	return @"lng";
}
+ (NSString *)location_type_id {
	return @"location_type_id";
}
+ (NSString *)name {
	return @"name";
}
+ (NSString *)notes {
	return @"notes";
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
+ (NSString *)service_route_id {
	return @"service_route_id";
}
+ (NSString *)state {
	return @"state";
}
+ (NSString *)street {
	return @"street";
}
+ (NSString *)street2 {
	return @"street2";
}
+ (NSString *)suite {
	return @"suite";
}
+ (NSString *)tax_rate_id {
	return @"tax_rate_id";
}
+ (NSString *)zip {
	return @"zip";
}
@end

@implementation ServiceLocationRelationships 
+ (NSString *)contacts {
	return @"contacts";
}
+ (NSString *)customer {
	return @"customer";
}
+ (NSString *)devices {
	return @"devices";
}
+ (NSString *)flats {
	return @"flats";
}
+ (NSString *)floors {
	return @"floors";
}
@end

