// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PestActivity.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface PestActivityID : NSManagedObjectID {}
@end

@interface _PestActivity : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PestActivityID *objectID;

@property (nonatomic, strong, nullable) NSNumber* activity_level_id;

@property (atomic) int32_t activity_level_idValue;
- (int32_t)activity_level_idValue;
- (void)setActivity_level_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSDate* created_at;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* pest_type_id;

@property (atomic) int32_t pest_type_idValue;
- (int32_t)pest_type_idValue;
- (void)setPest_type_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* unit_record_id;

@property (atomic) int32_t unit_record_idValue;
- (int32_t)unit_record_idValue;
- (void)setUnit_record_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSDate* updated_at;

@end

@interface _PestActivity (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveActivity_level_id;
- (void)setPrimitiveActivity_level_id:(nullable NSNumber*)value;

- (int32_t)primitiveActivity_level_idValue;
- (void)setPrimitiveActivity_level_idValue:(int32_t)value_;

- (nullable NSDate*)primitiveCreated_at;
- (void)setPrimitiveCreated_at:(nullable NSDate*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSNumber*)primitivePest_type_id;
- (void)setPrimitivePest_type_id:(nullable NSNumber*)value;

- (int32_t)primitivePest_type_idValue;
- (void)setPrimitivePest_type_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveUnit_record_id;
- (void)setPrimitiveUnit_record_id:(nullable NSNumber*)value;

- (int32_t)primitiveUnit_record_idValue;
- (void)setPrimitiveUnit_record_idValue:(int32_t)value_;

- (nullable NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(nullable NSDate*)value;

@end

@interface PestActivityAttributes: NSObject 
+ (NSString *)activity_level_id;
+ (NSString *)created_at;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)pest_type_id;
+ (NSString *)unit_record_id;
+ (NSString *)updated_at;
@end

NS_ASSUME_NONNULL_END
