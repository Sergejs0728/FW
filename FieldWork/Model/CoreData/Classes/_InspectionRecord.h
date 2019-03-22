// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to InspectionRecord.h instead.

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
@class InspectionPest;

@class NSObject;

@interface InspectionRecordID : NSManagedObjectID {}
@end

@interface _InspectionRecord : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) InspectionRecordID *objectID;

@property (nonatomic, strong, nullable) NSNumber* bait_condition_id;

@property (atomic) int32_t bait_condition_idValue;
- (int32_t)bait_condition_idValue;
- (void)setBait_condition_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* barcode;

@property (nonatomic, strong, nullable) NSString* building;

@property (nonatomic, strong, nullable) NSString* device_number;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* evidence;

@property (nonatomic, strong, nullable) id evidence_ids;

@property (nonatomic, strong, nullable) NSString* exception;

@property (nonatomic, strong, nullable) NSString* floor;

@property (nonatomic, strong, nullable) NSNumber* is_clean;

@property (atomic) BOOL is_cleanValue;
- (BOOL)is_cleanValue;
- (void)setIs_cleanValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* location_area_id;

@property (atomic) int32_t location_area_idValue;
- (int32_t)location_area_idValue;
- (void)setLocation_area_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* location_details;

@property (nonatomic, strong, nullable) NSString* notes;

@property (nonatomic, strong, nullable) NSNumber* removed;

@property (atomic) BOOL removedValue;
- (BOOL)removedValue;
- (void)setRemovedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSDate* scanned_on;

@property (nonatomic, strong, nullable) NSNumber* trap_condition_id;

@property (atomic) int32_t trap_condition_idValue;
- (int32_t)trap_condition_idValue;
- (void)setTrap_condition_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* trap_id;

@property (atomic) int32_t trap_idValue;
- (int32_t)trap_idValue;
- (void)setTrap_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* trap_number;

@property (nonatomic, strong, nullable) NSNumber* trap_type_id;

@property (atomic) int32_t trap_type_idValue;
- (int32_t)trap_type_idValue;
- (void)setTrap_type_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) Appointment *appointment;

@property (nonatomic, strong, nullable) NSSet<MaterialUsage*> *material_usages;
- (nullable NSMutableSet<MaterialUsage*>*)material_usagesSet;

@property (nonatomic, strong, nullable) NSSet<InspectionPest*> *pests_records;
- (nullable NSMutableSet<InspectionPest*>*)pests_recordsSet;

@end

@interface _InspectionRecord (Material_usagesCoreDataGeneratedAccessors)
- (void)addMaterial_usages:(NSSet<MaterialUsage*>*)value_;
- (void)removeMaterial_usages:(NSSet<MaterialUsage*>*)value_;
- (void)addMaterial_usagesObject:(MaterialUsage*)value_;
- (void)removeMaterial_usagesObject:(MaterialUsage*)value_;

@end

@interface _InspectionRecord (Pests_recordsCoreDataGeneratedAccessors)
- (void)addPests_records:(NSSet<InspectionPest*>*)value_;
- (void)removePests_records:(NSSet<InspectionPest*>*)value_;
- (void)addPests_recordsObject:(InspectionPest*)value_;
- (void)removePests_recordsObject:(InspectionPest*)value_;

@end

@interface _InspectionRecord (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveBait_condition_id;
- (void)setPrimitiveBait_condition_id:(nullable NSNumber*)value;

- (int32_t)primitiveBait_condition_idValue;
- (void)setPrimitiveBait_condition_idValue:(int32_t)value_;

- (nullable NSString*)primitiveBarcode;
- (void)setPrimitiveBarcode:(nullable NSString*)value;

- (nullable NSString*)primitiveBuilding;
- (void)setPrimitiveBuilding:(nullable NSString*)value;

- (nullable NSString*)primitiveDevice_number;
- (void)setPrimitiveDevice_number:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSString*)primitiveEvidence;
- (void)setPrimitiveEvidence:(nullable NSString*)value;

- (nullable id)primitiveEvidence_ids;
- (void)setPrimitiveEvidence_ids:(nullable id)value;

- (nullable NSString*)primitiveException;
- (void)setPrimitiveException:(nullable NSString*)value;

- (nullable NSString*)primitiveFloor;
- (void)setPrimitiveFloor:(nullable NSString*)value;

- (nullable NSNumber*)primitiveIs_clean;
- (void)setPrimitiveIs_clean:(nullable NSNumber*)value;

- (BOOL)primitiveIs_cleanValue;
- (void)setPrimitiveIs_cleanValue:(BOOL)value_;

- (nullable NSNumber*)primitiveLocation_area_id;
- (void)setPrimitiveLocation_area_id:(nullable NSNumber*)value;

- (int32_t)primitiveLocation_area_idValue;
- (void)setPrimitiveLocation_area_idValue:(int32_t)value_;

- (nullable NSString*)primitiveLocation_details;
- (void)setPrimitiveLocation_details:(nullable NSString*)value;

- (nullable NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(nullable NSString*)value;

- (nullable NSNumber*)primitiveRemoved;
- (void)setPrimitiveRemoved:(nullable NSNumber*)value;

- (BOOL)primitiveRemovedValue;
- (void)setPrimitiveRemovedValue:(BOOL)value_;

- (nullable NSDate*)primitiveScanned_on;
- (void)setPrimitiveScanned_on:(nullable NSDate*)value;

- (nullable NSNumber*)primitiveTrap_condition_id;
- (void)setPrimitiveTrap_condition_id:(nullable NSNumber*)value;

- (int32_t)primitiveTrap_condition_idValue;
- (void)setPrimitiveTrap_condition_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveTrap_id;
- (void)setPrimitiveTrap_id:(nullable NSNumber*)value;

- (int32_t)primitiveTrap_idValue;
- (void)setPrimitiveTrap_idValue:(int32_t)value_;

- (nullable NSString*)primitiveTrap_number;
- (void)setPrimitiveTrap_number:(nullable NSString*)value;

- (nullable NSNumber*)primitiveTrap_type_id;
- (void)setPrimitiveTrap_type_id:(nullable NSNumber*)value;

- (int32_t)primitiveTrap_type_idValue;
- (void)setPrimitiveTrap_type_idValue:(int32_t)value_;

- (Appointment*)primitiveAppointment;
- (void)setPrimitiveAppointment:(Appointment*)value;

- (NSMutableSet<MaterialUsage*>*)primitiveMaterial_usages;
- (void)setPrimitiveMaterial_usages:(NSMutableSet<MaterialUsage*>*)value;

- (NSMutableSet<InspectionPest*>*)primitivePests_records;
- (void)setPrimitivePests_records:(NSMutableSet<InspectionPest*>*)value;

@end

@interface InspectionRecordAttributes: NSObject 
+ (NSString *)bait_condition_id;
+ (NSString *)barcode;
+ (NSString *)building;
+ (NSString *)device_number;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)evidence;
+ (NSString *)evidence_ids;
+ (NSString *)exception;
+ (NSString *)floor;
+ (NSString *)is_clean;
+ (NSString *)location_area_id;
+ (NSString *)location_details;
+ (NSString *)notes;
+ (NSString *)removed;
+ (NSString *)scanned_on;
+ (NSString *)trap_condition_id;
+ (NSString *)trap_id;
+ (NSString *)trap_number;
+ (NSString *)trap_type_id;
@end

@interface InspectionRecordRelationships: NSObject
+ (NSString *)appointment;
+ (NSString *)material_usages;
+ (NSString *)pests_records;
@end

NS_ASSUME_NONNULL_END
