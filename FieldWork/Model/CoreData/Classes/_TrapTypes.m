// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TrapTypes.m instead.

#import "_TrapTypes.h"

@implementation TrapTypesID
@end

@implementation _TrapTypes

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TrapTypes" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TrapTypes";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TrapTypes" inManagedObjectContext:moc_];
}

- (TrapTypesID*)objectID {
	return (TrapTypesID*)[super objectID];
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

@dynamic trap_type_name;

@end

@implementation TrapTypesAttributes 
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)trap_type_name {
	return @"trap_type_name";
}
@end

