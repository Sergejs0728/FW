// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BillingTerms.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BillingTermsID : NSManagedObjectID {}
@end

@interface _BillingTerms : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BillingTermsID *objectID;

@property (nonatomic, strong, nullable) NSNumber* days;

@property (atomic) int32_t daysValue;
- (int32_t)daysValue;
- (void)setDaysValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* is_default;

@property (atomic) BOOL is_defaultValue;
- (BOOL)is_defaultValue;
- (void)setIs_defaultValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* name;

@end

@interface _BillingTerms (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveDays;
- (void)setPrimitiveDays:(nullable NSNumber*)value;

- (int32_t)primitiveDaysValue;
- (void)setPrimitiveDaysValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveIs_default;
- (void)setPrimitiveIs_default:(nullable NSNumber*)value;

- (BOOL)primitiveIs_defaultValue;
- (void)setPrimitiveIs_defaultValue:(BOOL)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

@end

@interface BillingTermsAttributes: NSObject 
+ (NSString *)days;
+ (NSString *)entity_id;
+ (NSString *)is_default;
+ (NSString *)name;
@end

NS_ASSUME_NONNULL_END
