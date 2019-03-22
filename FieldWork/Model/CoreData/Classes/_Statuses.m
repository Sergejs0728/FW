// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Statuses.m instead.

#import "_Statuses.h"

@implementation StatusesID
@end

@implementation _Statuses

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Statuses" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Statuses";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Statuses" inManagedObjectContext:moc_];
}

- (StatusesID*)objectID {
	return (StatusesID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic color;

@dynamic font_color;

@dynamic status_name;

@dynamic status_value;

@end

@implementation StatusesAttributes 
+ (NSString *)color {
	return @"color";
}
+ (NSString *)font_color {
	return @"font_color";
}
+ (NSString *)status_name {
	return @"status_name";
}
+ (NSString *)status_value {
	return @"status_value";
}
@end

