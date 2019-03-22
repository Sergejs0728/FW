// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ServiceRoutes.m instead.

#import "_ServiceRoutes.h"

@implementation ServiceRoutesID
@end

@implementation _ServiceRoutes

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ServiceRoutes" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ServiceRoutes";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ServiceRoutes" inManagedObjectContext:moc_];
}

- (ServiceRoutesID*)objectID {
	return (ServiceRoutesID*)[super objectID];
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

@dynamic service_route_name;

@end

@implementation ServiceRoutesAttributes 
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)service_route_name {
	return @"service_route_name";
}
@end

