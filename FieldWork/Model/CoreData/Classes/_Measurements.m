// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Measurements.m instead.

#import "_Measurements.h"

@implementation MeasurementsID
@end

@implementation _Measurements

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Measurements" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Measurements";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Measurements" inManagedObjectContext:moc_];
}

- (MeasurementsID*)objectID {
	return (MeasurementsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic measurement;

@end

@implementation MeasurementsAttributes 
+ (NSString *)measurement {
	return @"measurement";
}
@end

