// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TargetPest.m instead.

#import "_TargetPest.h"

@implementation TargetPestID
@end

@implementation _TargetPest

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TargetPest" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TargetPest";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TargetPest" inManagedObjectContext:moc_];
}

- (TargetPestID*)objectID {
	return (TargetPestID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

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
	if ([key isEqualToString:@"pest_type_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pest_type_id"];
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

@dynamic pest_type_id;

- (int32_t)pest_type_idValue {
	NSNumber *result = [self pest_type_id];
	return [result intValue];
}

- (void)setPest_type_idValue:(int32_t)value_ {
	[self setPest_type_id:@(value_)];
}

- (int32_t)primitivePest_type_idValue {
	NSNumber *result = [self primitivePest_type_id];
	return [result intValue];
}

- (void)setPrimitivePest_type_idValue:(int32_t)value_ {
	[self setPrimitivePest_type_id:@(value_)];
}

@end

@implementation TargetPestAttributes 
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)entity_status {
	return @"entity_status";
}
+ (NSString *)pest_type_id {
	return @"pest_type_id";
}
@end

