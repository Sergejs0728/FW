// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LocationType.m instead.

#import "_LocationType.h"

@implementation LocationTypeID
@end

@implementation _LocationType

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LocationType" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LocationType";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LocationType" inManagedObjectContext:moc_];
}

- (LocationTypeID*)objectID {
	return (LocationTypeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"entity_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entity_id"];
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

@dynamic location_type_color;

@dynamic location_type_name;

@dynamic location_areas;

- (NSMutableSet<LocationArea*>*)location_areasSet {
	[self willAccessValueForKey:@"location_areas"];

	NSMutableSet<LocationArea*> *result = (NSMutableSet<LocationArea*>*)[self mutableSetValueForKey:@"location_areas"];

	[self didAccessValueForKey:@"location_areas"];
	return result;
}

@end

@implementation LocationTypeAttributes 
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)location_type_color {
	return @"location_type_color";
}
+ (NSString *)location_type_name {
	return @"location_type_name";
}
@end

@implementation LocationTypeRelationships 
+ (NSString *)location_areas {
	return @"location_areas";
}
@end

