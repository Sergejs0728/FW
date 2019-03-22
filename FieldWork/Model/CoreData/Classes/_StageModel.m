// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StageModel.m instead.

#import "_StageModel.h"

@implementation StageModelID
@end

@implementation _StageModel

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"StageModel" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"StageModel";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"StageModel" inManagedObjectContext:moc_];
}

- (StageModelID*)objectID {
	return (StageModelID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"changedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"changed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"deletedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"deleted"];
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

@dynamic building;

@dynamic changed;

- (BOOL)changedValue {
	NSNumber *result = [self changed];
	return [result boolValue];
}

- (void)setChangedValue:(BOOL)value_ {
	[self setChanged:@(value_)];
}

- (BOOL)primitiveChangedValue {
	NSNumber *result = [self primitiveChanged];
	return [result boolValue];
}

- (void)setPrimitiveChangedValue:(BOOL)value_ {
	[self setPrimitiveChanged:@(value_)];
}

@dynamic deleted;

- (BOOL)deletedValue {
	NSNumber *result = [self deleted];
	return [result boolValue];
}

- (void)setDeletedValue:(BOOL)value_ {
	[self setDeleted:@(value_)];
}

- (BOOL)primitiveDeletedValue {
	NSNumber *result = [self primitiveDeleted];
	return [result boolValue];
}

- (void)setPrimitiveDeletedValue:(BOOL)value_ {
	[self setPrimitiveDeleted:@(value_)];
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

@dynamic filePath;

@dynamic floor;

@dynamic image_url;

@dynamic notes;

@dynamic title;

@dynamic updated_at;

@dynamic vg_url;

@dynamic serviceLocation;

@end

@implementation StageModelAttributes 
+ (NSString *)building {
	return @"building";
}
+ (NSString *)changed {
	return @"changed";
}
+ (NSString *)deleted {
	return @"deleted";
}
+ (NSString *)entity_id {
	return @"entity_id";
}
+ (NSString *)filePath {
	return @"filePath";
}
+ (NSString *)floor {
	return @"floor";
}
+ (NSString *)image_url {
	return @"image_url";
}
+ (NSString *)notes {
	return @"notes";
}
+ (NSString *)title {
	return @"title";
}
+ (NSString *)updated_at {
	return @"updated_at";
}
+ (NSString *)vg_url {
	return @"vg_url";
}
@end

@implementation StageModelRelationships 
+ (NSString *)serviceLocation {
	return @"serviceLocation";
}
@end

