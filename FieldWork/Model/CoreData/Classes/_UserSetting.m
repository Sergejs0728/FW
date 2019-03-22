// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserSetting.m instead.

#import "_UserSetting.h"

@implementation UserSettingID
@end

@implementation _UserSetting

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"UserSetting" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"UserSetting";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"UserSetting" inManagedObjectContext:moc_];
}

- (UserSettingID*)objectID {
	return (UserSettingID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"air_print_on_offValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"air_print_on_off"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"print_on_offValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"print_on_off"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic air_print_on_off;

- (BOOL)air_print_on_offValue {
	NSNumber *result = [self air_print_on_off];
	return [result boolValue];
}

- (void)setAir_print_on_offValue:(BOOL)value_ {
	[self setAir_print_on_off:@(value_)];
}

- (BOOL)primitiveAir_print_on_offValue {
	NSNumber *result = [self primitiveAir_print_on_off];
	return [result boolValue];
}

- (void)setPrimitiveAir_print_on_offValue:(BOOL)value_ {
	[self setPrimitiveAir_print_on_off:@(value_)];
}

@dynamic print_on_off;

- (BOOL)print_on_offValue {
	NSNumber *result = [self print_on_off];
	return [result boolValue];
}

- (void)setPrint_on_offValue:(BOOL)value_ {
	[self setPrint_on_off:@(value_)];
}

- (BOOL)primitivePrint_on_offValue {
	NSNumber *result = [self primitivePrint_on_off];
	return [result boolValue];
}

- (void)setPrimitivePrint_on_offValue:(BOOL)value_ {
	[self setPrimitivePrint_on_off:@(value_)];
}

@dynamic printer_ip;

@end

@implementation UserSettingAttributes 
+ (NSString *)air_print_on_off {
	return @"air_print_on_off";
}
+ (NSString *)print_on_off {
	return @"print_on_off";
}
+ (NSString *)printer_ip {
	return @"printer_ip";
}
@end

