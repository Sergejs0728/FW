// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MaterialUsageRecord.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class TargetPest;

@interface MaterialUsageRecordID : NSManagedObjectID {}
@end

@interface _MaterialUsageRecord : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MaterialUsageRecordID *objectID;

@property (nonatomic, strong, nullable) NSNumber* amount;

@property (atomic) float amountValue;
- (float)amountValue;
- (void)setAmountValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* application_device_type_id;

@property (atomic) int32_t application_device_type_idValue;
- (int32_t)application_device_type_idValue;
- (void)setApplication_device_type_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* application_method;

@property (nonatomic, strong, nullable) NSNumber* application_method_id;

@property (atomic) int32_t application_method_idValue;
- (int32_t)application_method_idValue;
- (void)setApplication_method_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* device;

@property (nonatomic, strong, nullable) NSNumber* dilution_rate_id;

@property (atomic) int32_t dilution_rate_idValue;
- (int32_t)dilution_rate_idValue;
- (void)setDilution_rate_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* location_area_id;
//@property (nonatomic, readwrite) BOOL is_favorite;

@property (atomic) int32_t location_area_idValue;
- (int32_t)location_area_idValue;
- (void)setLocation_area_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* lot_number;

@property (nonatomic, strong, nullable) NSString* measurement;

@property (nonatomic, strong, nullable) NSSet<TargetPest*> *target_pests;
- (nullable NSMutableSet<TargetPest*>*)target_pestsSet;

@end

@interface _MaterialUsageRecord (Target_pestsCoreDataGeneratedAccessors)
- (void)addTarget_pests:(NSSet<TargetPest*>*)value_;
- (void)removeTarget_pests:(NSSet<TargetPest*>*)value_;
- (void)addTarget_pestsObject:(TargetPest*)value_;
- (void)removeTarget_pestsObject:(TargetPest*)value_;

@end

@interface _MaterialUsageRecord (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAmount;
- (void)setPrimitiveAmount:(nullable NSNumber*)value;

- (float)primitiveAmountValue;
- (void)setPrimitiveAmountValue:(float)value_;

- (nullable NSNumber*)primitiveApplication_device_type_id;
- (void)setPrimitiveApplication_device_type_id:(nullable NSNumber*)value;

- (int32_t)primitiveApplication_device_type_idValue;
- (void)setPrimitiveApplication_device_type_idValue:(int32_t)value_;

- (nullable NSString*)primitiveApplication_method;
- (void)setPrimitiveApplication_method:(nullable NSString*)value;

- (nullable NSNumber*)primitiveApplication_method_id;
- (void)setPrimitiveApplication_method_id:(nullable NSNumber*)value;

- (int32_t)primitiveApplication_method_idValue;
- (void)setPrimitiveApplication_method_idValue:(int32_t)value_;

- (nullable NSString*)primitiveDevice;
- (void)setPrimitiveDevice:(nullable NSString*)value;

- (nullable NSNumber*)primitiveDilution_rate_id;
- (void)setPrimitiveDilution_rate_id:(nullable NSNumber*)value;

- (int32_t)primitiveDilution_rate_idValue;
- (void)setPrimitiveDilution_rate_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveLocation_area_id;
- (void)setPrimitiveLocation_area_id:(nullable NSNumber*)value;

- (int32_t)primitiveLocation_area_idValue;
- (void)setPrimitiveLocation_area_idValue:(int32_t)value_;

- (nullable NSString*)primitiveLot_number;
- (void)setPrimitiveLot_number:(nullable NSString*)value;

- (nullable NSString*)primitiveMeasurement;
- (void)setPrimitiveMeasurement:(nullable NSString*)value;

- (NSMutableSet<TargetPest*>*)primitiveTarget_pests;
- (void)setPrimitiveTarget_pests:(NSMutableSet<TargetPest*>*)value;

@end

@interface MaterialUsageRecordAttributes: NSObject 
+ (NSString *)amount;
+ (NSString *)application_device_type_id;
+ (NSString *)application_method;
+ (NSString *)application_method_id;
+ (NSString *)device;
+ (NSString *)dilution_rate_id;
+ (NSString *)entity_id;
+ (NSString *)location_area_id;
+ (NSString *)lot_number;
+ (NSString *)measurement;
@end

@interface MaterialUsageRecordRelationships: NSObject
+ (NSString *)target_pests;
@end

NS_ASSUME_NONNULL_END
