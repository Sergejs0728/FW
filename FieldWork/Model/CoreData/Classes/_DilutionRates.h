// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DilutionRates.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface DilutionRatesID : NSManagedObjectID {}
@end

@interface _DilutionRates : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DilutionRatesID *objectID;

@property (nonatomic, strong, nullable) NSNumber* account_id;

@property (atomic) int32_t account_idValue;
- (int32_t)account_idValue;
- (void)setAccount_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSDate* created_at;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id1;

@property (atomic) int32_t entity_id1Value;
- (int32_t)entity_id1Value;
- (void)setEntity_id1Value:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* name1;

@property (nonatomic, strong, nullable) NSDate* updated_at;

@end

@interface _DilutionRates (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAccount_id;
- (void)setPrimitiveAccount_id:(nullable NSNumber*)value;

- (int32_t)primitiveAccount_idValue;
- (void)setPrimitiveAccount_idValue:(int32_t)value_;

- (nullable NSDate*)primitiveCreated_at;
- (void)setPrimitiveCreated_at:(nullable NSDate*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_id1;
- (void)setPrimitiveEntity_id1:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_id1Value;
- (void)setPrimitiveEntity_id1Value:(int32_t)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSString*)primitiveName1;
- (void)setPrimitiveName1:(nullable NSString*)value;

- (nullable NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(nullable NSDate*)value;

@end

@interface DilutionRatesAttributes: NSObject 
+ (NSString *)account_id;
+ (NSString *)created_at;
+ (NSString *)entity_id;
+ (NSString *)entity_id1;
+ (NSString *)name;
+ (NSString *)name1;
+ (NSString *)updated_at;
@end

NS_ASSUME_NONNULL_END
