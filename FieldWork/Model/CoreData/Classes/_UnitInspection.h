// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UnitInspection.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Appointment;
@class MaterialUsage;
@class PestActivity;

@interface UnitInspectionID : NSManagedObjectID {}
@end

@interface _UnitInspection : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UnitInspectionID *objectID;

@property (nonatomic, strong, nullable) NSNumber* appointment_occurrence_id;

@property (atomic) int32_t appointment_occurrence_idValue;
- (int32_t)appointment_occurrence_idValue;
- (void)setAppointment_occurrence_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSDate* created_at;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* flat_condition_id;

@property (atomic) int32_t flat_condition_idValue;
- (int32_t)flat_condition_idValue;
- (void)setFlat_condition_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* flat_type_id;

@property (atomic) int32_t flat_type_idValue;
- (int32_t)flat_type_idValue;
- (void)setFlat_type_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* notes;

@property (nonatomic, strong, nullable) NSString* service_time;

@property (nonatomic, strong, nullable) NSString* tenant_email_1;

@property (nonatomic, strong, nullable) NSString* tenant_email_2;

@property (nonatomic, strong, nullable) NSString* tenant_name;

@property (nonatomic, strong, nullable) NSString* tenant_phone_1;

@property (nonatomic, strong, nullable) NSString* tenant_phone_2;

@property (nonatomic, strong, nullable) NSString* tenant_signature;

@property (nonatomic, strong, nullable) NSString* unit_number;

@property (nonatomic, strong, nullable) NSNumber* unit_status_id;

@property (atomic) int32_t unit_status_idValue;
- (int32_t)unit_status_idValue;
- (void)setUnit_status_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSDate* updated_at;

@property (nonatomic, strong, nullable) Appointment *appointment;

@property (nonatomic, strong, nullable) NSSet<MaterialUsage*> *material_usages;
- (nullable NSMutableSet<MaterialUsage*>*)material_usagesSet;

@property (nonatomic, strong, nullable) NSSet<PestActivity*> *pests_activities;
- (nullable NSMutableSet<PestActivity*>*)pests_activitiesSet;

@end

@interface _UnitInspection (Material_usagesCoreDataGeneratedAccessors)
- (void)addMaterial_usages:(NSSet<MaterialUsage*>*)value_;
- (void)removeMaterial_usages:(NSSet<MaterialUsage*>*)value_;
- (void)addMaterial_usagesObject:(MaterialUsage*)value_;
- (void)removeMaterial_usagesObject:(MaterialUsage*)value_;

@end

@interface _UnitInspection (Pests_activitiesCoreDataGeneratedAccessors)
- (void)addPests_activities:(NSSet<PestActivity*>*)value_;
- (void)removePests_activities:(NSSet<PestActivity*>*)value_;
- (void)addPests_activitiesObject:(PestActivity*)value_;
- (void)removePests_activitiesObject:(PestActivity*)value_;

@end

@interface _UnitInspection (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAppointment_occurrence_id;
- (void)setPrimitiveAppointment_occurrence_id:(nullable NSNumber*)value;

- (int32_t)primitiveAppointment_occurrence_idValue;
- (void)setPrimitiveAppointment_occurrence_idValue:(int32_t)value_;

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

- (nullable NSNumber*)primitiveFlat_condition_id;
- (void)setPrimitiveFlat_condition_id:(nullable NSNumber*)value;

- (int32_t)primitiveFlat_condition_idValue;
- (void)setPrimitiveFlat_condition_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveFlat_type_id;
- (void)setPrimitiveFlat_type_id:(nullable NSNumber*)value;

- (int32_t)primitiveFlat_type_idValue;
- (void)setPrimitiveFlat_type_idValue:(int32_t)value_;

- (nullable NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(nullable NSString*)value;

- (nullable NSString*)primitiveService_time;
- (void)setPrimitiveService_time:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_email_1;
- (void)setPrimitiveTenant_email_1:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_email_2;
- (void)setPrimitiveTenant_email_2:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_name;
- (void)setPrimitiveTenant_name:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_phone_1;
- (void)setPrimitiveTenant_phone_1:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_phone_2;
- (void)setPrimitiveTenant_phone_2:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_signature;
- (void)setPrimitiveTenant_signature:(nullable NSString*)value;

- (nullable NSString*)primitiveUnit_number;
- (void)setPrimitiveUnit_number:(nullable NSString*)value;

- (nullable NSNumber*)primitiveUnit_status_id;
- (void)setPrimitiveUnit_status_id:(nullable NSNumber*)value;

- (int32_t)primitiveUnit_status_idValue;
- (void)setPrimitiveUnit_status_idValue:(int32_t)value_;

- (nullable NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(nullable NSDate*)value;

- (Appointment*)primitiveAppointment;
- (void)setPrimitiveAppointment:(Appointment*)value;

- (NSMutableSet<MaterialUsage*>*)primitiveMaterial_usages;
- (void)setPrimitiveMaterial_usages:(NSMutableSet<MaterialUsage*>*)value;

- (NSMutableSet<PestActivity*>*)primitivePests_activities;
- (void)setPrimitivePests_activities:(NSMutableSet<PestActivity*>*)value;

@end

@interface UnitInspectionAttributes: NSObject 
+ (NSString *)appointment_occurrence_id;
+ (NSString *)created_at;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)flat_condition_id;
+ (NSString *)flat_type_id;
+ (NSString *)notes;
+ (NSString *)service_time;
+ (NSString *)tenant_email_1;
+ (NSString *)tenant_email_2;
+ (NSString *)tenant_name;
+ (NSString *)tenant_phone_1;
+ (NSString *)tenant_phone_2;
+ (NSString *)tenant_signature;
+ (NSString *)unit_number;
+ (NSString *)unit_status_id;
+ (NSString *)updated_at;
@end

@interface UnitInspectionRelationships: NSObject
+ (NSString *)appointment;
+ (NSString *)material_usages;
+ (NSString *)pests_activities;
@end

NS_ASSUME_NONNULL_END
