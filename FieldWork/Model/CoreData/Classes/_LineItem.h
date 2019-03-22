// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LineItem.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Appointment;
@class Estimate;

@interface LineItemID : NSManagedObjectID {}
@end

@interface _LineItem : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LineItemID *objectID;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* lineitem_type;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSNumber* payable_id;

@property (atomic) int32_t payable_idValue;
- (int32_t)payable_idValue;
- (void)setPayable_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* payable_type;

@property (nonatomic, strong, nullable) NSNumber* price;

@property (atomic) float priceValue;
- (float)priceValue;
- (void)setPriceValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* quantity;

@property (atomic) float quantityValue;
- (float)quantityValue;
- (void)setQuantityValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* taxable;

@property (atomic) BOOL taxableValue;
- (BOOL)taxableValue;
- (void)setTaxableValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* total;

@property (atomic) float totalValue;
- (float)totalValue;
- (void)setTotalValue:(float)value_;

@property (nonatomic, strong, nullable) Appointment *appointment;

@property (nonatomic, strong, nullable) Estimate *estimate;

@end

@interface _LineItem (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSString*)primitiveLineitem_type;
- (void)setPrimitiveLineitem_type:(nullable NSString*)value;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSNumber*)primitivePayable_id;
- (void)setPrimitivePayable_id:(nullable NSNumber*)value;

- (int32_t)primitivePayable_idValue;
- (void)setPrimitivePayable_idValue:(int32_t)value_;

- (nullable NSString*)primitivePayable_type;
- (void)setPrimitivePayable_type:(nullable NSString*)value;

- (nullable NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(nullable NSNumber*)value;

- (float)primitivePriceValue;
- (void)setPrimitivePriceValue:(float)value_;

- (nullable NSNumber*)primitiveQuantity;
- (void)setPrimitiveQuantity:(nullable NSNumber*)value;

- (float)primitiveQuantityValue;
- (void)setPrimitiveQuantityValue:(float)value_;

- (nullable NSNumber*)primitiveTaxable;
- (void)setPrimitiveTaxable:(nullable NSNumber*)value;

- (BOOL)primitiveTaxableValue;
- (void)setPrimitiveTaxableValue:(BOOL)value_;

- (nullable NSNumber*)primitiveTotal;
- (void)setPrimitiveTotal:(nullable NSNumber*)value;

- (float)primitiveTotalValue;
- (void)setPrimitiveTotalValue:(float)value_;

- (Appointment*)primitiveAppointment;
- (void)setPrimitiveAppointment:(Appointment*)value;

- (Estimate*)primitiveEstimate;
- (void)setPrimitiveEstimate:(Estimate*)value;

@end

@interface LineItemAttributes: NSObject 
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)lineitem_type;
+ (NSString *)name;
+ (NSString *)payable_id;
+ (NSString *)payable_type;
+ (NSString *)price;
+ (NSString *)quantity;
+ (NSString *)taxable;
+ (NSString *)total;
@end

@interface LineItemRelationships: NSObject
+ (NSString *)appointment;
+ (NSString *)estimate;
@end

NS_ASSUME_NONNULL_END
