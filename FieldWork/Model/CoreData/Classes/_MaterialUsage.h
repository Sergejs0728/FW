// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MaterialUsage.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Appointment;
@class MaterialUsageRecord;

@interface MaterialUsageID : NSManagedObjectID {}
@end

@interface _MaterialUsage : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MaterialUsageID *objectID;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* inspection_record_id;

@property (atomic) int32_t inspection_record_idValue;
- (int32_t)inspection_record_idValue;
- (void)setInspection_record_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* material_id;

@property (atomic) int32_t material_idValue;
- (int32_t)material_idValue;
- (void)setMaterial_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* notes;

@property (nonatomic, strong, nullable) Appointment *appointment;

@property (nonatomic, strong, nullable) NSSet<MaterialUsageRecord*> *material_usage_records;
- (nullable NSMutableSet<MaterialUsageRecord*>*)material_usage_recordsSet;

@end

@interface _MaterialUsage (Material_usage_recordsCoreDataGeneratedAccessors)
- (void)addMaterial_usage_records:(NSSet<MaterialUsageRecord*>*)value_;
- (void)removeMaterial_usage_records:(NSSet<MaterialUsageRecord*>*)value_;
- (void)addMaterial_usage_recordsObject:(MaterialUsageRecord*)value_;
- (void)removeMaterial_usage_recordsObject:(MaterialUsageRecord*)value_;

@end

@interface _MaterialUsage (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSNumber*)primitiveInspection_record_id;
- (void)setPrimitiveInspection_record_id:(nullable NSNumber*)value;

- (int32_t)primitiveInspection_record_idValue;
- (void)setPrimitiveInspection_record_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveMaterial_id;
- (void)setPrimitiveMaterial_id:(nullable NSNumber*)value;

- (int32_t)primitiveMaterial_idValue;
- (void)setPrimitiveMaterial_idValue:(int32_t)value_;

- (nullable NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(nullable NSString*)value;

- (Appointment*)primitiveAppointment;
- (void)setPrimitiveAppointment:(Appointment*)value;

- (NSMutableSet<MaterialUsageRecord*>*)primitiveMaterial_usage_records;
- (void)setPrimitiveMaterial_usage_records:(NSMutableSet<MaterialUsageRecord*>*)value;

@end

@interface MaterialUsageAttributes: NSObject 
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)inspection_record_id;
+ (NSString *)material_id;
+ (NSString *)notes;
@end

@interface MaterialUsageRelationships: NSObject
+ (NSString *)appointment;
+ (NSString *)material_usage_records;
@end

NS_ASSUME_NONNULL_END
