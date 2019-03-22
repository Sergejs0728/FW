// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BaitConditions.m instead.

#import "_BaitConditions.h"

@implementation BaitConditionsID
@end

@implementation _BaitConditions

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BaitConditions" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BaitConditions";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BaitConditions" inManagedObjectContext:moc_];
}

- (BaitConditionsID*)objectID {
	return (BaitConditionsID*)[super objectID];
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

@dynamic bait_condition_name;

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

@end

@implementation BaitConditionsAttributes 
+ (NSString *)bait_condition_name {
	return @"bait_condition_name";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
@end

