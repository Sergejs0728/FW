// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserSetting.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UserSettingID : NSManagedObjectID {}
@end

@interface _UserSetting : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserSettingID *objectID;

@property (nonatomic, strong, nullable) NSNumber* air_print_on_off;

@property (atomic) BOOL air_print_on_offValue;
- (BOOL)air_print_on_offValue;
- (void)setAir_print_on_offValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* print_on_off;

@property (atomic) BOOL print_on_offValue;
- (BOOL)print_on_offValue;
- (void)setPrint_on_offValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* printer_ip;

@end

@interface _UserSetting (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAir_print_on_off;
- (void)setPrimitiveAir_print_on_off:(nullable NSNumber*)value;

- (BOOL)primitiveAir_print_on_offValue;
- (void)setPrimitiveAir_print_on_offValue:(BOOL)value_;

- (nullable NSNumber*)primitivePrint_on_off;
- (void)setPrimitivePrint_on_off:(nullable NSNumber*)value;

- (BOOL)primitivePrint_on_offValue;
- (void)setPrimitivePrint_on_offValue:(BOOL)value_;

- (nullable NSString*)primitivePrinter_ip;
- (void)setPrimitivePrinter_ip:(nullable NSString*)value;

@end

@interface UserSettingAttributes: NSObject 
+ (NSString *)air_print_on_off;
+ (NSString *)print_on_off;
+ (NSString *)printer_ip;
@end

NS_ASSUME_NONNULL_END
