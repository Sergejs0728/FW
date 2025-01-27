// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ApplicationMethods.m instead.

#import "_ApplicationMethods.h"

@implementation ApplicationMethodsID
@end

@implementation _ApplicationMethods

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ApplicationMethods" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ApplicationMethods";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ApplicationMethods" inManagedObjectContext:moc_];
}

- (ApplicationMethodsID*)objectID {
	return (ApplicationMethodsID*)[super objectID];
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

@dynamic methodName;

@end

@implementation ApplicationMethodsAttributes 
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)methodName {
	return @"methodName";
}
@end

