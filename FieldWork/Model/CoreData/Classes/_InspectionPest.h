// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InspectionPest.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface InspectionPestID : NSManagedObjectID {}
@end

@interface _InspectionPest : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) InspectionPestID *objectID;

@property (nonatomic, strong, nullable) NSNumber* count;

@property (atomic) int32_t countValue;
- (int32_t)countValue;
- (void)setCountValue:(int32_t)value_;

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

@end

@interface _InspectionPest (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveCount;
- (void)setPrimitiveCount:(nullable NSNumber*)value;

- (int32_t)primitiveCountValue;
- (void)setPrimitiveCountValue:(int32_t)value_;

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

@end

@interface InspectionPestAttributes: NSObject 
+ (NSString *)count;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)pest_type_id;
@end

NS_ASSUME_NONNULL_END
