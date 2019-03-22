// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LocationArea.m instead.

#import "_LocationArea.h"

@implementation LocationAreaID
@end

@implementation _LocationArea

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LocationArea" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LocationArea";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LocationArea" inManagedObjectContext:moc_];
}

- (LocationAreaID*)objectID {
	return (LocationAreaID*)[super objectID];
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

@dynamic location_area_name;

@end

@implementation LocationAreaAttributes 
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)location_area_name {
	return @"location_area_name";
}
@end

