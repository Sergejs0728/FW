// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TaxRates.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Appointment;

@interface TaxRatesID : NSManagedObjectID {}
@end

@interface _TaxRates : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TaxRatesID *objectID;

@property (nonatomic, strong, nullable) NSString* code;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* is_default;

@property (atomic) BOOL is_defaultValue;
- (BOOL)is_defaultValue;
- (void)setIs_defaultValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSNumber* rate;

@property (atomic) float rateValue;
- (float)rateValue;
- (void)setRateValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* service_taxable;

@property (atomic) BOOL service_taxableValue;
- (BOOL)service_taxableValue;
- (void)setService_taxableValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSSet<Appointment*> *appointments;
- (nullable NSMutableSet<Appointment*>*)appointmentsSet;

@end

@interface _TaxRates (AppointmentsCoreDataGeneratedAccessors)
- (void)addAppointments:(NSSet<Appointment*>*)value_;
- (void)removeAppointments:(NSSet<Appointment*>*)value_;
- (void)addAppointmentsObject:(Appointment*)value_;
- (void)removeAppointmentsObject:(Appointment*)value_;

@end

@interface _TaxRates (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveCode;
- (void)setPrimitiveCode:(nullable NSString*)value;

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

- (nullable NSNumber*)primitiveRate;
- (void)setPrimitiveRate:(nullable NSNumber*)value;

- (float)primitiveRateValue;
- (void)setPrimitiveRateValue:(float)value_;

- (nullable NSNumber*)primitiveService_taxable;
- (void)setPrimitiveService_taxable:(nullable NSNumber*)value;

- (BOOL)primitiveService_taxableValue;
- (void)setPrimitiveService_taxableValue:(BOOL)value_;

- (NSMutableSet<Appointment*>*)primitiveAppointments;
- (void)setPrimitiveAppointments:(NSMutableSet<Appointment*>*)value;

@end

@interface TaxRatesAttributes: NSObject 
+ (NSString *)code;
+ (NSString *)entity_id;
+ (NSString *)is_default;
+ (NSString *)name;
+ (NSString *)rate;
+ (NSString *)service_taxable;
@end

@interface TaxRatesRelationships: NSObject
+ (NSString *)appointments;
@end

NS_ASSUME_NONNULL_END
